import 'package:datarunmobile/core/form/element_template/get_item_local_string.dart';
import 'package:datarunmobile/core/logging/new_app_logging.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/features/form_submission/application/configure_form_completion_dialog.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/features/form_submission/application/submission_list.provider.dart';
import 'package:datarunmobile/features/form_submission/presentation/form_entry_view_silver.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/form_initial_view.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/hooks/scroll_controller_for_animation.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/bottom_sheet.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_completion_dialog.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_metadata_inherit_widget.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormSubmissionScreen extends StatefulHookConsumerWidget {
  const FormSubmissionScreen({
    super.key,
    required this.submissionId,
    required this.formId,
    required this.versionId,
    this.assignmentId,
    this.currentPageIndex = 0,
  });

  final int currentPageIndex;
  final String? assignmentId;
  final String submissionId;
  final String formId;
  final String versionId;

  @override
  FormSubmissionScreenState createState() => FormSubmissionScreenState();
}

class FormSubmissionScreenState extends ConsumerState<FormSubmissionScreen> {
  @override
  Widget build(BuildContext context) {
    // final FormMetadata formMetadata = FormMetadataWidget.of(context);

    final AsyncValue<bool> submissionEditStatus = ref
        .watch(submissionEditStatusProvider(submissionId: widget.submissionId));

    return AsyncValueWidget(
        value: submissionEditStatus,
        valueBuilder: (canEdit) {
          return FormMetadataWidget(
            formMetadata: FormMetadata(
                assignmentId: widget.assignmentId,
                formId: widget.formId,
                submission: widget.submissionId,
                versionUid: widget.versionId),
            child: FormTabScreen(
              enabled: canEdit,
              currentPageIndex: widget.currentPageIndex,
              submissionId: widget.submissionId,
            ),
          );
        });
  }
}

class FormTabScreen extends StatefulHookConsumerWidget {
  const FormTabScreen({
    super.key,
    required this.submissionId,
    this.currentPageIndex = 0,
    this.enabled = true,
  });

  final int currentPageIndex;
  final bool enabled;
  final String submissionId;

  @override
  ConsumerState<FormTabScreen> createState() => _SubmissionTabScreenState();
}

class _SubmissionTabScreenState extends ConsumerState<FormTabScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FormMetadata metadata(BuildContext context) => FormMetadataWidget.of(context);

  FormMetadata get formMetadata => FormMetadataWidget.of(context);

  @override
  void initState() {
    super.initState();
    appLocator<FieldContextRegistry>().clear();
  }

  @override
  Widget build(BuildContext context) {
    final currentPageIndex = useState(widget.currentPageIndex);
    final hideFabAnimController = useAnimationController(
        duration: kThemeAnimationDuration, initialValue: 1);
    final scrollController =
        useScrollControllerForAnimation(hideFabAnimController);

    final formInstance = appLocator<FormInstance>();

    final _buildBody = <Widget>[
      const FormInitialView(),
      FormInstanceEntryViewSliver(
        scrollController: scrollController,
        submissionId: widget.submissionId,
      ),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) async {
        if (didPop) {
          return;
        }
        await backButtonPressed(formInstance);
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Text(getItemLocalString(
                appLocator<FormTemplateRepository>().template.label,
                defaultString:
                    appLocator<FormTemplateRepository>().template.name))),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) => currentPageIndex.value = index,
          indicatorColor: Colors.amber,
          selectedIndex: currentPageIndex.value,
          destinations: <Widget>[
            NavigationDestination(
              selectedIcon: const Icon(Icons.home),
              icon: const Icon(Icons.home_outlined),
              label: S.of(context).submissionInitialData,
            ),
            NavigationDestination(
              icon: const Badge(child: Icon(Icons.data_array)),
              label: S.of(context).submissionDataEntry,
            )
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              IndexedStack(
                index: currentPageIndex.value,
                children: _buildBody,
              ),
            ],
          ),
        ),
        floatingActionButton: FadeTransition(
          opacity: hideFabAnimController,
          child: ScaleTransition(
            scale: hideFabAnimController,
            child: FloatingActionButton(
              tooltip: S.of(context).saveAndCheck,
              child: getFloatIcon(),
              onPressed: () async {
                if (widget.enabled) {
                  await _saveAndShowBottomSheet(formInstance);
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget getFloatIcon() {
    return widget.enabled
        ? const Icon(Icons.save)
        : const Icon(Icons.arrow_back);
  }

  Future<void> _saveAndShowBottomSheet(FormInstance formInstance) async {
    await _onSaveForm();
    if (context.mounted) {
      return _showBottomSheet(formInstance);
    }
  }

  Future<void> backButtonPressed(FormInstance formInstance) async {
    if (formInstance.form.hasErrors || formInstance.form.dirty) {
      await _saveAndShowBottomSheet(formInstance);
    } else {
      Navigator.pop(context);
      await appLocator.popScopesTill(widget.submissionId);
    }
  }

  /// Save the form
  Future<void> _onSaveForm() async {
    // ref
    //     .read(formInstanceProvider(submissionId: widget.submissionId))
    //     .requireValue
    //     .saveFormData();
    await appLocator<FormInstance>().saveFormData();
  }

  Future<void> _showBottomSheet(FormInstance formInstance) async {
    final formInstance = appLocator<FormInstance>();

    final configurator = const ConfigureFormCompletionDialog();
    final bottomSheetUiModel = configurator(formInstance.formSection);

    final action = await showModalBottomSheet<FormBottomDialogActionType>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return QBottomSheetDialog(
          completionDialogModel: bottomSheetUiModel,
          onItemWithErrorClicked: (path) {
            logDebug('${path} clicked');
            _onErrorTap(path!, formInstance);
          },
        );
      },
    );

    if (context.mounted && action != null) {
      await _onCompletionDialogButtonClicked(action);
    }
  }

  void _onErrorTap(
    String elementPath,
    FormInstance formInstance,
  ) {
    formInstance.onErrorTap(elementPath);
    Navigator.pop(context);
    formInstance.form.control(elementPath).markAsTouched();
  }

  Future<void> _onCompletionDialogButtonClicked(
    FormBottomDialogActionType action,
  ) async {
    switch (action) {
      case FormBottomDialogActionType.NotNow:
        Navigator.pop(context);
        if (appLocator.currentScopeName == widget.submissionId) {
          await appLocator.dropScope(widget.submissionId);
        }
      case FormBottomDialogActionType.MarkAsFinal:
        await _markEntityAsFinal(context);
        if (context.mounted) {
          Navigator.pop(context);
        }
        if (appLocator.currentScopeName == widget.submissionId) {
          await appLocator.dropScope(widget.submissionId);
        }
        break;
      case FormBottomDialogActionType.CheckFields:
        return;
    }
  }

  Future<void> _markEntityAsFinal(BuildContext context) async {
    final formInstance = appLocator<FormInstance>();

    return formInstance.markSubmissionAsFinal();
  }
}
