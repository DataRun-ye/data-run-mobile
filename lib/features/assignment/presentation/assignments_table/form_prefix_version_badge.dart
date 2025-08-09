import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/features/form/application/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormPrefixVersionBadge extends ConsumerWidget {
  const FormPrefixVersionBadge({super.key, this.form, this.version});

  final String? form;
  final String? version;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formAsync =
        ref.watch(formTemplateProvider(formId: form, versionId: version));
    final cs = Theme.of(context).colorScheme;
    final metadataStyle = Theme.of(context)
        .textTheme
        .bodySmall
        ?.copyWith(color: Colors.grey.shade700);

    return AsyncValueWidget(
      value: formAsync,
      loadingBuilder: () => const Center(
        heightFactor: 5,
        widthFactor: 5,
        child: CircularProgressIndicator(),
      ),
      valueBuilder: (template) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: Icon(Icons.document_scanner_outlined,
                    color: cs.secondaryContainer)),
            SizedBox(
              width: 3,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              decoration: BoxDecoration(
                color: cs.surfaceContainer,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text('v${template.versionNumber}', style: metadataStyle),
            )
          ],
        );
      },
    );
  }
}
