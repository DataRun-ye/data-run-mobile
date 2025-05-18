import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:datarunmobile/core/models/overlay_request.dart';
import 'package:datarunmobile/core/models/overlay_response.dart';
import 'package:datarunmobile/features/custom/presentation/create_submission_sheet/create_submission_sheet_model.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

class CreateSubmissionSheet extends StackedView<CreateSubmissionSheetModel> {
  const CreateSubmissionSheet({
    super.key,
    required this.request,
    required this.completer,
  });

  final SheetRequest<dynamic> request;
  final Function(SheetResponse<dynamic>)? completer;

  @override
  Widget builder(
    BuildContext context,
    CreateSubmissionSheetModel viewModel,
    Widget? child,
  ) {
    return viewModel.isBusy ? const Center(child: CircularProgressIndicator()) : Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.document_scanner, size: 30),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  S.of(context).selectForm,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                  '(${S.of(context).form(viewModel.assignedForms.length)})',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Divider(color: Colors.grey.shade400, thickness: 1.0),
          const SizedBox(height: 10.0),
          ListView.builder(
            shrinkWrap: true,
            itemCount: viewModel.assignedForms.length,
            itemBuilder: (context, index) {
              final formTemplate = viewModel.assignedForms[index];

              return ListTile(
                leading: const Icon(Icons.description),
                title: Text(
                  getItemLocalString(formTemplate.label),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  softWrap: true,
                ),
                subtitle: formTemplate.description != null
                    ? Text(
                        formTemplate.description!,
                        style: Theme.of(context).textTheme.bodySmall,
                        softWrap: true,
                      )
                    : null,
                onTap: () => completer
                    ?.call(SheetResponse(confirmed: true, data: formTemplate)),
                trailing: const Icon(Icons.chevron_right),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hoverColor: Theme.of(context).primaryColor.withOpacity(0.1),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  CreateSubmissionSheetModel viewModelBuilder(BuildContext context) =>
      CreateSubmissionSheetModel(id: request.data!);

  @override
  void onViewModelReady(CreateSubmissionSheetModel viewModel) =>
      SchedulerBinding.instance.addPostFrameCallback(
          (timeStamp) => viewModel.showBasicBottomSheet());
}
