import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/features/form/application/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormDisplay extends ConsumerWidget {
  const FormDisplay({
    super.key,
    this.form,
    this.version,
    this.row = false,
    this.size = 25,
  });

  final String? form;
  final String? version;
  final bool row;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formAsync =
        ref.watch(formTemplateProvider(formId: form, versionId: version));
    return AsyncValueWidget(
      value: formAsync,
      valueBuilder: (template) {
        return Tooltip(
          triggerMode: TooltipTriggerMode.tap,
          message:
              getItemLocalString(template.label, defaultString: template.name),
          child: Text(
            getItemLocalString(template.label, defaultString: template.name),
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
    );
  }
}
