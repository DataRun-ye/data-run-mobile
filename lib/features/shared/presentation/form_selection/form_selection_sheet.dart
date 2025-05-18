import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:datarunmobile/features/shared/presentation/form_selection/form_selection_viewmodel.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked/stacked.dart';

class FormSelectionSheet extends ConsumerWidget {
  const FormSelectionSheet({
    super.key,
    required this.assignment,
    required this.onComplete,
  });

  final String assignment;

  final void Function(String formVersion, String assignment) onComplete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ViewModelBuilder<FormSelectionViewmodel>.reactive(
      viewModelBuilder: () => FormSelectionViewmodel(assignment),
      builder: (context, model, child) {
        if (model.isBusy) {
          return const Center(child: CircularProgressIndicator());
        }
        if (model.hasError) {
          return Center(child: Text(model.modelError!));
        }
        return DraggableScrollableSheet(
          expand: false,
          builder: (_, controller) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.document_scanner, size: 30),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          S.of(context).selectForm,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Divider(color: Colors.grey.shade400, thickness: 1.0),
                  const SizedBox(height: 10.0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.forms.length,
                    itemBuilder: (context, index) {
                      final formTemplate = model.forms[index];

                      return ListTile(
                        leading: const Icon(Icons.description),
                        title: Text(
                          getItemLocalString(formTemplate.label),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                        onTap: () =>
                            onComplete(formTemplate.formVersion, assignment),
                        trailing: const Icon(Icons.chevron_right),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        // tileColor: Colors.grey.shade100,
                        hoverColor:
                            Theme.of(context).primaryColor.withOpacity(0.1),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
