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
    this.prefix,
  });

  final String? form;
  final String? version;
  final String? prefix;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formAsync =
        ref.watch(formTemplateProvider(formId: form, versionId: version));
    return AsyncValueWidget(
      value: formAsync,
      valueBuilder: (template) {
        final label =
            '${prefix != null ? prefix : ''} ${getItemLocalString(template.label, defaultString: template.name)}';
        return Tooltip(
          triggerMode: TooltipTriggerMode.tap,
          message: label,
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
    );
  }
}
