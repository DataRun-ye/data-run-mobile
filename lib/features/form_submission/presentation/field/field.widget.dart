import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/form_widget_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FieldWidget extends HookConsumerWidget {
  FieldWidget({
    required super.key,
    required this.element,
    this.focusNode,
  });

  final FieldInstance<dynamic> element;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final elementPropertiesSnapshot = useStream(element.propertiesChanged);

    final control = element.elementControl;

    useEffect(() {
      final subscription = control.valueChanges.listen((value) {
        if (value == null) {
          element.updateValue(value);
        } else {
          element.updateValue(value);
        }
      });

      logDebug('call use effect: ${element.name}, unsubscribe');
      return () => subscription;
    }, [control]);

    if (!elementPropertiesSnapshot.hasData) {
      return const SizedBox.shrink();
    }

    if (elementPropertiesSnapshot.data!.hidden) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FieldFactory.fromType(element),
    );
  }
}
