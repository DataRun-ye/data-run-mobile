import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:datarun/commons/logging/new_app_logging.dart';
import 'package:datarun/data_run/screens/form/element/form_element.dart';
import 'package:datarun/data_run/screens/form/element_widgets/form_widget_factory.dart';

class FieldWidget extends HookConsumerWidget {
  FieldWidget({super.key, required this.element});

  final FieldInstance<dynamic> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // useRegisterDependencies(element);

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
      return SizedBox.shrink();
    }

    if (elementPropertiesSnapshot.data!.hidden) {
      return SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FieldFactory.fromType(element),
    );
  }
}
