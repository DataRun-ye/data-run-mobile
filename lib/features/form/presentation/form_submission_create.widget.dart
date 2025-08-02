import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/collections.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/commons/custom_widgets/expandable_text.dart';
import 'package:datarunmobile/data/data.dart';
import 'package:datarunmobile/features/form/application/form_provider.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormSubmissionCreate extends HookConsumerWidget {
  const FormSubmissionCreate(
      {super.key, this.assignmentId, required this.onTap});

  final Function(String templateId) onTap;

  final String? assignmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    // final List<Pair<AssignmentForm, bool>> userForms =
    //     assignment.userForms;
    // final List<Pair<AssignmentForm, bool>> availableLocally =
    //     assignment.availableForms;
    final availableFormsAsync =
        ref.watch(userAvailableFormsProvider(assignment: assignmentId));
    final isEnabled = useState(true);

    return AsyncValueWidget(
      value: availableFormsAsync,
      valueBuilder: (List<Pair<AssignmentForm, bool>> userForms) {
        final List<Pair<AssignmentForm, bool>> availableLocally =
            userForms.where((form) => form.second).toList();
        final cs = Theme.of(context).colorScheme;

        return FractionallySizedBox(
          heightFactor: 0.7,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.document_scanner, size: 30),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        S.of(context).selectForm,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            )
                            .copyWith(color: cs.onSurfaceVariant),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      availableLocally.length == userForms.length
                          ? '(${S.of(context).form(availableLocally.length)})'
                          : '(${availableLocally.length}/${S.of(context).form(userForms.length)})',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (_, __) => const Divider(
                        height: 4,
                        thickness: 0.5,
                        indent: 16,
                        endIndent: 16,
                      ),
                      itemCount: availableLocally.length,
                      itemBuilder: (BuildContext context, int index) {
                        final form = availableLocally[index].first;
                        return _FormListItem(
                            index: index,
                            permission: form,
                            onTap: (templateId) {
                              onTap(templateId);
                            });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FormListItem extends ConsumerWidget {
  const _FormListItem(
      {required this.index, required this.permission, this.onTap});

  final int index;
  final AssignmentForm permission;
  final void Function(String templateId)? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formTemplateAsync =
        ref.watch(formTemplateProvider(formId: permission.form));
    final theme = Theme.of(context);
    final metadataStyle =
        theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade700);
    final cs = Theme.of(context).colorScheme;
    return AsyncValueWidget(
      value: formTemplateAsync,
      valueBuilder: (formTemplate) {
        final cs = Theme.of(context).colorScheme;
        return ListTile(
          tileColor: cs.surfaceContainerHigh.withValues(alpha: .7),
          iconColor: cs.primary,
          textColor: cs.onSurfaceVariant,
          titleTextStyle: Theme.of(context).textTheme.titleMedium,
          subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
          isThreeLine: formTemplate.description != null,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: const Icon(Icons.description)),
              SizedBox(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                decoration: BoxDecoration(
                  color: cs.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text('v${formTemplate.versionNumber}',
                    style: metadataStyle),
              ),
            ],
          ),
          title: Text(
              '${index + 1}. ${getItemLocalString(formTemplate.label, defaultString: formTemplate.name)}'),
          subtitle: formTemplate.description != null
              ? ExpandableText(
                  text: formTemplate.description!,
                )
              : null,
          enableFeedback: true,
          onTap: () {
            onTap?.call(formTemplate.id);
          },
          trailing: const Icon(Icons.chevron_right),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hoverColor: cs.onSurface.withValues(alpha: 0.1),
        );
      },
    );
  }
}
