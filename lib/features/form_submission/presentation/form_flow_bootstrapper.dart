import 'package:datarunmobile/features/common_ui_element/common/ui_helpers.dart';
import 'package:datarunmobile/features/form_submission/presentation/form_flow_bootstrapper_vm.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

class FormFlowBootstrapper extends StackedView<FormFlowBootstrapperVm> {
  const FormFlowBootstrapper({
    Key? key,
    this.submissionId,
    this.formId,
    this.versionId,
    this.assignmentId,
  }) : super(key: key);
  final String? formId;
  final String? versionId;
  final String? assignmentId;
  final String? submissionId;

  @override
  Widget builder(
    BuildContext context,
    FormFlowBootstrapperVm viewModel,
    Widget? child,
  ) {
    final cs = Theme.of(context).colorScheme;
    final message = submissionId == null
        ? S.of(context).draftDataInstance
        : S.of(context).initializingDataInstance;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${message}...',
                overflow: TextOverflow.ellipsis,
              ),
              if (viewModel.hasError)
                Text(
                  '${viewModel.modelError.toString()}...'
                ),
              SizedBox(
                width: 2,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(S.of(context).checkingSession,
                      style: TextStyle(fontSize: 16, color: cs.surfaceDim)),
                  horizontalSpaceSmall,
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.orangeAccent[400]!),
                      strokeWidth: 6,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  FormFlowBootstrapperVm viewModelBuilder(
    BuildContext context,
  ) =>
      FormFlowBootstrapperVm(
        formId: formId,
        versionId: versionId,
        assignmentId: assignmentId,
      );

  @override
  void onViewModelReady(FormFlowBootstrapperVm viewModel) =>
      SchedulerBinding.instance.addPostFrameCallback(
          (timeStamp) => viewModel.bootstrapFlow(submissionId));
}
