import 'package:datarunmobile/features/form_submission/presentation/form_entry_view_silver.widget.dart';
import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/features/form_submission/application/submission_list.provider.dart';
import 'package:datarunmobile/features/form_submission/presentation/form_initial_view.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/hooks/scroll_controller_for_animation.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/presentation/form_metadata_inherit_widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/form_template_inherit_widget.dart';
import 'package:datarunmobile/features/form_ui_elements/presentation/bottom_sheet.widget.dart';
import 'package:datarunmobile/data/completion_dialog_config.provider.dart';
import 'package:datarunmobile/features/form_ui_elements/application/form_completion_dialog.dart';
import 'package:datarunmobile/features/form_ui_elements/presentation/get_error_widget.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormSubmissionScreen extends StatefulHookConsumerWidget {
  const FormSubmissionScreen({super.key, this.currentPageIndex = 0});

  final int currentPageIndex;

  @override
  FormSubmissionScreenState createState() => FormSubmissionScreenState();
}

class FormSubmissionScreenState extends ConsumerState<FormSubmissionScreen> {
  @override
  Widget build(BuildContext context) {
    final FormMetadata formMetadata = FormMetadataWidget.of(context);

    final AsyncValue<bool> submissionEditStatus =
        ref.watch(submissionEditStatusProvider(formMetadata: formMetadata));

    return AsyncValueWidget(
        value: submissionEditStatus,
        valueBuilder: (canEdit) {
          final formFlatTemplateAsync =
              ref.watch(formFlatTemplateProvider(formMetadata: formMetadata));

          return _EagerInitialization(
            child: AsyncValueWidget(
                value: formFlatTemplateAsync,
                valueBuilder: (formFlatTemplate) =>
                    FormFlatTemplateInheritWidget(
                      formContainerTemplate: formFlatTemplate,
                      child: FormTabScreen(
                        enabled: canEdit,
                        currentPageIndex: widget.currentPageIndex,
                      ),
                    )),
          );
        });
  }
}

class FormTabScreen extends StatefulHookConsumerWidget {
  const FormTabScreen(
      {super.key, this.currentPageIndex = 0, this.enabled = true});

  final int currentPageIndex;
  final bool enabled;

  @override
  ConsumerState<FormTabScreen> createState() => _SubmissionTabScreenState();
}

class _SubmissionTabScreenState extends ConsumerState<FormTabScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FormMetadata metadata(BuildContext context) => FormMetadataWidget.of(context);

  FormMetadata get formMetadata => FormMetadataWidget.of(context);

  FormGroup formGroup(BuildContext context) => ref
      .read(formInstanceProvider(formMetadata: formMetadata))
      .requireValue
      .form;

  @override
  Widget build(BuildContext context) {
    final currentPageIndex = useState(widget.currentPageIndex);
    final hideFabAnimController = useAnimationController(
        duration: kThemeAnimationDuration, initialValue: 1);
    final scrollController =
        useScrollControllerForAnimation(hideFabAnimController);

    final formInstance = ref
        .watch(formInstanceProvider(formMetadata: formMetadata))
        .requireValue;

    final _buildBody = <Widget>[
      const FormInitialView(),
      // FormInstanceEntryView(scrollController: scrollController),
      FormInstanceEntryViewSliver(scrollController: scrollController),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) async {
        if (didPop) {
          return;
        }
        backButtonPressed(formInstance.form);
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Text(getItemLocalString(
                FormFlatTemplateInheritWidget.of(context).template.label,
                defaultString:
                    FormFlatTemplateInheritWidget.of(context).template.name))),
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
        body: Stack(
          children: [
            IndexedStack(
              index: currentPageIndex.value,
              children: _buildBody,
            ),
          ],
        ),
        floatingActionButton: FadeTransition(
          opacity: hideFabAnimController,
          child: ScaleTransition(
            scale: hideFabAnimController,
            child: FloatingActionButton(
              tooltip: S.of(context).saveAndCheck,
              child: getFloatIcon(),
              onPressed: () {
                if (widget.enabled) {
                  _saveAndShowBottomSheet(formGroup(context));
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

  Future<void> _saveAndShowBottomSheet(FormGroup form) async {
    await _onSaveForm();
    if (context.mounted) {
      return _showBottomSheet(form);
    }
  }

  Future<void> backButtonPressed(FormGroup form) async {
    if (form.dirty) {
      await _saveAndShowBottomSheet(form);
    } else {
      Navigator.pop(context);
    }
  }

  /// Save the form
  Future<void> _onSaveForm() async {
    ref
        .read(formInstanceProvider(formMetadata: formMetadata))
        .requireValue
        .saveFormData();
  }

  Future<void> _showBottomSheet(FormGroup form) async {
    final bottomSheetUiModel = ref.read(formCompletionBottomSheetProvider(
        formMetadata: FormMetadataWidget.of(context)));
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return QBottomSheetDialog(
          completionDialogModel: bottomSheetUiModel,
          onButtonClicked: (action) =>
              _onCompletionDialogButtonClicked(form, action),
        );
      },
    );
  }

  Future<void> _onCompletionDialogButtonClicked(
      FormGroup form, FormBottomDialogActionType? action) async {
    switch (action) {
      case FormBottomDialogActionType.NotNow:
        Navigator.pop(context);
      case FormBottomDialogActionType.MarkAsFinal:
        await _markEntityAsFinal(context);
        if (context.mounted) Navigator.pop(context);
        break;
      case FormBottomDialogActionType.CheckFields:
      case null:
        return;
    }
  }

  Future<void> _markEntityAsFinal(BuildContext context) async {
    return ref
        .read(formInstanceProvider(formMetadata: formMetadata))
        .requireValue
        .markSubmissionAsFinal();
  }
}

class _EagerInitialization extends ConsumerWidget {
  _EagerInitialization({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref.watch(
        formInstanceProvider(formMetadata: FormMetadataWidget.of(context)));
    if (formInstance.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (formInstance.hasError) {
      return getErrorWidget(formInstance.error, formInstance.stackTrace);
    }

    return child;
  }
}
