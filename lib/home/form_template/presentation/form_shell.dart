import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/home/form_template/application/form_list_filter.dart';
import 'package:datarunmobile/home/form_template/application/form_provider.dart';
import 'package:datarunmobile/home/form_template/domain/model/form_list_item_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// The shell widget fetches and provides the template
class FormShell extends ConsumerWidget {
  final String titel;
  final String formId;
  final Widget child;

  const FormShell({required this.titel,required this.formId, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTemplate =
    ref.watch(formListItemsProvider(const FormListFilter()));
    AsyncValueWidget(
      value: asyncTemplate, valueBuilder: (List<FormListItemModel> forms) {

    },);
    return asyncTemplate.when(
      loading: () =>
      const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) =>
          Scaffold(
            body: Center(child: Text('Error loading form: \$e')),
          ),
      data: (_) => child,
    );
  }
}
