import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/core/util/string_extension.dart';
import 'package:datarunmobile/features/common_ui_element/common/app_colors.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/form_widget_factory.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

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
      return const SliverToBoxAdapter(child: CircularProgressIndicator());
    }

    final hidden = element.elementState.hidden;

    if (hidden) {
      return const SliverToBoxAdapter();
    }

    return SliverPadding(
      padding: const EdgeInsets.only(right: 16.0, left: 16, top: 12, bottom: 12),
      sliver: MultiSliver(children: [
        SliverToBoxAdapter(
          child: FieldFactory.fromType(element),
        ),
        SliverToBoxAdapter(
          child:
              elementPropertiesSnapshot.data?.warning.isNotNullOrEmpty == true
                  ? Text(
                      '${S.of(context).warning}: ${elementPropertiesSnapshot.data?.warning}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: SurfaceColors.Warning),
                    )
                  : null,
        )
      ]),
    );
  }
}
