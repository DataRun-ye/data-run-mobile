import 'package:datarunmobile/features/form/application/form_list_filter.dart';
import 'package:datarunmobile/features/form/application/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// The shell widget fetches and provides the template
class FormShell extends ConsumerWidget {
  const FormShell(
      {required this.titel, required this.formId, required this.child});

  final String titel;
  final String formId;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTemplate =
        ref.watch(formListItemsProvider(const FormListFilter()));
    // AsyncValueWidget(
    //   value: asyncTemplate, valueBuilder: (List<FormListItemModel> forms) {
    //
    // },);
    return Scaffold(
      body: SafeArea(
        child: asyncTemplate.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) =>
              const Center(child: Text('Error loading form: \$e')),
          data: (_) => child,
        ),
      ),
    );
  }
}
