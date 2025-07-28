import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormDisplay extends ConsumerWidget {
  const FormDisplay(
      {super.key, required this.form, this.row = false, this.size = 25});

  final String form;
  final bool row;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formAsync = ref.watch(latestFormTemplateProvider(formId: form));
    final cs = Theme.of(context).colorScheme;
    final metadataStyle = Theme.of(context)
        .textTheme
        .bodySmall
        ?.copyWith(color: Colors.grey.shade700);
    return AsyncValueWidget(
      value: formAsync,
      valueBuilder: (FormTemplateRepository template) {
        return Tooltip(
          triggerMode: TooltipTriggerMode.tap,
          message: getItemLocalString(template.template.label,
              defaultString: template.template.name),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.document_scanner_outlined, size: size),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('v${template.template.versionNumber}',
                        style: metadataStyle),
                  )
                ],
              ),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  getItemLocalString(template.template.label,
                      defaultString: template.template.name),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
