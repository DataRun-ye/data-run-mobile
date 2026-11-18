import 'dart:async';

import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/logging/new_app_logging.dart';
import 'package:datarunmobile/core/util/date_helper.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/features/common_ui_element/common/app_colors.dart';
import 'package:datarunmobile/features/data_instance/application/recorded_values_lookup.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/reference_field_service.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/reference_search/reference_value_display.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:datarunmobile/core/util/latin_digits_input_formatter.dart';

class QReferenceDropDownSearchField extends StatefulWidget {
  const QReferenceDropDownSearchField({super.key, required this.element});

  final ReferenceFieldInstance element;

  @override
  State<QReferenceDropDownSearchField> createState() =>
      _QReferenceDropDownSearchFieldState();
}

class _QReferenceDropDownSearchFieldState
    extends State<QReferenceDropDownSearchField> {
  late final FormInstance _formInstance;
  late final ReferenceFieldService _service;
  late final RecordedValuesLookup _recordedLookup;
  late final Future<String> _orgUnitUid;

  @override
  void initState() {
    super.initState();
    _formInstance = appLocator<FormInstance>();
    _service = ReferenceFieldService(appLocator<AppDatabase>());
    _recordedLookup = RecordedValuesLookup(appLocator<AppDatabase>());
    _orgUnitUid = _service.resolveOrgUnitUid(
      _formInstance.formMetadata.assignmentId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _orgUnitUid,
      builder: (context, scopeSnapshot) {
        if (scopeSnapshot.connectionState != ConnectionState.done) {
          return InputDecorator(
            decoration: InputDecoration(
              labelText: widget.element.label,
              border: const OutlineInputBorder(),
            ),
            child: const LinearProgressIndicator(),
          );
        }
        if (scopeSnapshot.hasError || scopeSnapshot.data == null) {
          return InputDecorator(
            decoration: InputDecoration(
              labelText: widget.element.label,
              errorText: S.of(context).referenceConfigurationUnavailable,
              border: const OutlineInputBorder(),
            ),
            child: Text(S.of(context).referenceFieldHint),
          );
        }
        return _buildField(context, scopeSnapshot.data!);
      },
    );
  }

  Widget _buildField(BuildContext context, String orgUnitUid) {
    return ReactiveFormField<String, String>(
      formControl: widget.element.elementControl,
      validationMessages: validationMessages(),
      builder: (field) {
        final uid = field.value;
        final canEdit =
            field.control.enabled && !widget.element.template.readOnly;

        return InkWell(
          onTap: canEdit
              ? () => _selectReference(
                    field: field,
                    orgUnitUid: orgUnitUid,
                  )
              : null,
          child: InputDecorator(
            isEmpty: uid == null,
            decoration: InputDecoration(
              labelText: widget.element.label,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              errorText: field.errorText,
              enabled: canEdit,
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.manage_search),
              suffixIcon: uid != null && canEdit
                  ? IconButton(
                      tooltip: S.of(context).clear,
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        field.control.markAsTouched();
                        field.didChange(null);
                      },
                    )
                  : const Icon(Icons.arrow_drop_down),
            ),
            child: uid == null
                ? Text(S.of(context).referenceFieldHint)
                : ReferenceValueDisplay(
                    uid: uid,
                    orgUnitUid: orgUnitUid,
                  ),
          ),
        );
      },
    );
  }

  Future<void> _selectReference({
    required ReactiveFormFieldState<String, String> field,
    required String orgUnitUid,
  }) async {
    final recordedAt = await _recordedElsewhere(orgUnitUid);
    if (!mounted) {
      return;
    }
    final selectedUid = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => _ReferencePickerSheet(
        service: _service,
        orgUnitUid: orgUnitUid,
        currentUid: field.value,
        disabledUids: _formInstance.usedReferenceUids(widget.element),
        recordedAt: recordedAt,
      ),
    );
    if (!mounted || selectedUid == null) {
      return;
    }
    field.control.markAsTouched();
    field.didChange(selectedUid);
  }

  /// Values this phone recorded in other submissions of the form for the
  /// village. Empty when the check fails, so the picker still opens.
  Future<Map<String, DateTime>> _recordedElsewhere(String orgUnitUid) async {
    try {
      return await _recordedLookup.references(
        formId: _formInstance.formMetadata.formId,
        orgUnitUid: orgUnitUid,
        excludeSubmissionId: _formInstance.submissionId,
      );
    } catch (error, stackTrace) {
      logError(
        'Could not check values recorded in other submissions',
        source: error,
        stackTrace: stackTrace,
      );
      return const {};
    }
  }
}

class _ReferencePickerSheet extends StatefulWidget {
  const _ReferencePickerSheet({
    required this.service,
    required this.orgUnitUid,
    required this.currentUid,
    required this.disabledUids,
    required this.recordedAt,
  });

  final ReferenceFieldService service;
  final String orgUnitUid;
  final String? currentUid;
  final Set<String> disabledUids;

  /// When each value was recorded in another submission on this phone.
  final Map<String, DateTime> recordedAt;

  @override
  State<_ReferencePickerSheet> createState() => _ReferencePickerSheetState();
}

class _ReferencePickerSheetState extends State<_ReferencePickerSheet> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<ReferenceEntry> _entries = const [];
  bool _loading = true;
  bool _creating = false;
  String? _createError;
  int _searchGeneration = 0;

  @override
  void initState() {
    super.initState();
    _search();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    setState(() => _createError = null);
    _debounce = Timer(const Duration(milliseconds: 250), _search);
  }

  Future<void> _search() async {
    final generation = ++_searchGeneration;
    setState(() {
      _loading = true;
      _createError = null;
    });
    final entries = await widget.service.search(
      orgUnitUid: widget.orgUnitUid,
      query: _searchController.text,
    );
    if (!mounted || generation != _searchGeneration) {
      return;
    }
    setState(() {
      _entries = entries;
      _loading = false;
    });
  }

  Future<void> _create() async {
    if (_creating) {
      return;
    }
    final name = _searchController.text;
    setState(() {
      _creating = true;
      _createError = null;
    });
    try {
      final entry = await widget.service.create(
        orgUnitUid: widget.orgUnitUid,
        displayName: name,
      );
      if (mounted) {
        Navigator.pop(context, entry.uid);
      }
    } on ReferenceDisplayNameException catch (error) {
      if (mounted) {
        setState(() => _createError = _nameErrorMessage(context, error.reason));
      }
    } catch (_) {
      if (mounted) {
        setState(() => _createError = S.of(context).generalErrorMessage);
      }
    } finally {
      if (mounted) {
        setState(() => _creating = false);
      }
    }
  }

  /// Picks [entry], first asking for confirmation when another submission
  /// already recorded it: a return visit is legitimate, a repeat is not.
  Future<void> _pick(ReferenceEntry entry) async {
    final recordedAt = widget.recordedAt[entry.uid];
    if (recordedAt != null && entry.uid != widget.currentUid) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(S.of(dialogContext).referenceRecordAgainTitle),
          content: Text(S.of(dialogContext).referenceRecordAgainMessage(
                entry.displayName,
                _formatDate(recordedAt),
              )),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(S.of(dialogContext).cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(S.of(dialogContext).referenceRecordAgain),
            ),
          ],
        ),
      );
      if (confirmed != true || !mounted) {
        return;
      }
    }
    Navigator.pop(context, entry.uid);
  }

  static String _formatDate(DateTime value) =>
      DateFormat(DateHelper.UI_DATE_FORMAT).format(value.toLocal());

  String _nameErrorMessage(BuildContext context, String reason) {
    return switch (reason) {
      'invalidCharacters' => S.of(context).pleaseUseLettersOnly,
      'tooFewParts' => S.of(context).pleaseEnterAtLeastFourNameParts,
      _ => S.of(context).thisFieldIsRequired,
    };
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim();
    final sheet = FractionallySizedBox(
      heightFactor: 0.88,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    S.of(context).referenceFieldHint,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  tooltip: S.of(context).close,
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              inputFormatters: const [LatinDigitsInputFormatter()],
              autofocus: true,
              textInputAction: TextInputAction.search,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: S.of(context).search,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: query.isEmpty
                    ? null
                    : IconButton(
                        tooltip: S.of(context).clear,
                        onPressed: () {
                          _searchController.clear();
                          _search();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          if (_createError != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text(
                _createError!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          const Divider(height: 1),
          if (_loading)
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_entries.isEmpty)
            Expanded(
              child: Center(child: Text(S.of(context).noItemsFound)),
            )
          else
            Expanded(
              child: ListView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: _entries.length,
                itemBuilder: (context, index) {
                  final entry = _entries[index];
                  final disabled = widget.disabledUids.contains(entry.uid);
                  final selected = widget.currentUid == entry.uid;
                  final recordedAt = widget.recordedAt[entry.uid];
                  return ListTile(
                    enabled: !disabled,
                    selected: selected,
                    leading: Icon(
                      selected
                          ? Icons.check_circle
                          : recordedAt != null
                              ? Icons.history
                              : Icons.link,
                    ),
                    title: Text(entry.displayName),
                    subtitle: disabled
                        ? Text(S.of(context).referenceAlreadySelected)
                        : recordedAt != null
                            ? Text(
                                S.of(context).referenceRecordedOn(
                                      _formatDate(recordedAt),
                                    ),
                                style: TextStyle(color: SurfaceColors.Warning),
                              )
                            : null,
                    onTap: disabled ? null : () => _pick(entry),
                  );
                },
              ),
            ),
          if (query.isNotEmpty) ...[
            const Divider(height: 1),
            SafeArea(
              top: false,
              child: ListTile(
                leading: _creating
                    ? const SizedBox.square(
                        dimension: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.add_link),
                title: Text(S.of(context).addNew),
                subtitle: Text(
                  query,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                enabled: !_creating,
                onTap: _creating ? null : _create,
              ),
            ),
          ],
        ],
      ),
    );
    return AnimatedPadding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      duration: kThemeAnimationDuration,
      curve: Curves.easeOut,
      child: sheet,
    );
  }
}
