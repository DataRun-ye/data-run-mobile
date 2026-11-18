import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/field.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/repeat_table_sliver.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/section.widget.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormInstanceEntryViewSliver extends HookConsumerWidget {
  const FormInstanceEntryViewSliver({
    super.key,
    required this.scrollController,
    required this.submissionId,
  });

  final ScrollController scrollController;
  final String submissionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = appLocator<FormInstance>();

    List<Widget> buildSlivers() {
      final unknownReferences = formInstance.unknownReferences;
      return [
        if (unknownReferences.isNotEmpty)
          SliverToBoxAdapter(
            child: _FormSetupErrorBanner(unknownReferences: unknownReferences),
          ),
        ...formInstance.formSection.elements.values.map((element) {
          if (element is Section) {
            return SectionWidget(element: element);
          } else if (element is RepeatSection) {
            return RepeatTableSliver(repeatInstance: element);
          } else if (element is FieldInstance) {
            return FieldWidget(
                key: appLocator<FieldContextRegistry>()
                    .getOrCreateKey(element.elementPath!),
                element: element);
          }
          return const SliverToBoxAdapter();
        }),
      ];
    }

    return CustomScrollView(
      shrinkWrap: true,
      controller: scrollController,
      slivers: buildSlivers(),
    );
  }
}

/// Tells the user that some checks or conditions of this form cannot work,
/// naming the element and the unknown fields, so it gets reported.
class _FormSetupErrorBanner extends StatelessWidget {
  const _FormSetupErrorBanner({required this.unknownReferences});

  final Map<String, Set<String>> unknownReferences;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.all(8),
      color: colors.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).formSetupErrorTitle,
              style: TextStyle(
                color: colors.onErrorContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            for (final MapEntry(key: owner, value: names)
                in unknownReferences.entries)
              Text(
                S.of(context).formSetupUnknownFields(owner, names.join(', ')),
                style: TextStyle(color: colors.onErrorContainer),
              ),
          ],
        ),
      ),
    );
  }
}
