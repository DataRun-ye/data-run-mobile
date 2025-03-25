import 'package:datarunmobile/data_run/screens/form/hooks/register_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
import 'package:datarunmobile/data_run/screens/form/element_widgets/form_widget_factory.dart';

class FieldWidget extends HookConsumerWidget {
  FieldWidget({super.key, required this.element});

  final FieldInstance<dynamic> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final elementStatus = useRegisterDependencies(element);
    if (elementStatus.value.hidden) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FieldFactory.fromType(element),
    );
  }
}
