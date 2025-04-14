import 'dart:async';

import 'package:d_sdk/core/form/rule/rule_parse_extension.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';

class DependencyBinder {
  DependencyBinder({required this.element})
      : dependencies = resolveDependencies(element);
  final FormElementInstance<dynamic> element;
  final Map<String, FormElementInstance<dynamic>> dependencies;

  final List<StreamSubscription<dynamic>> _subscriptions = [];

  static Map<String, FormElementInstance<dynamic>> resolveDependencies(
      FormElementInstance<dynamic> element) {
    final Map<String, FormElementInstance<dynamic>> _resolvedDependencies = {};
    final List<String> deps = {
      ...element.template.dependencies,
      ...element.template.filterDependencies
    }.toSet().toList();

    if (deps.isEmpty) {
      // logDebug('${element.name} has no dependencies');
      return {};
    }

    logDebug('resolving(${deps.length}): $deps, of: ${element.name}');

    for (final dependencyName in deps) {
      final dependency = element.findElementInParentSection(dependencyName);
      if (dependency != null) {
        _resolvedDependencies[dependency.name!] = dependency;
      }
    }
    logDebug(
        'resolved(${_resolvedDependencies.keys.length}): ${_resolvedDependencies.keys}, of: ${element.name}');

    return _resolvedDependencies;
  }

  void bind() {
    for (final dep in dependencies.values) {
      // Update context initially.
      element.updateContext(
          name: dep.name!,
          value: ElementDependencyHandler.calculationFriendlyValue(dep));
      final sub = dep.elementControl?.statusChanged.listen((_) {
        logDebug(
            'change dep: ${dep.name}:${dep.elementControl!.value}, updating context of: ${element.name}');
        element.updateContext(
            name: dep.name!,
            value: ElementDependencyHandler.calculationFriendlyValue(dep));
        element.evaluateDependencies();
      });
      if (sub != null) {
        _subscriptions.add(sub);
      }
    }
  }

  void dispose() {
    logDebug('dispose binder of: ${element.name}');
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
  }
}

//
// // Riverpod Integration
// final dependencyManagerProvider = Provider.autoDispose
//     .family<FormDependencyManager, FormElementInstance>((ref, element) {
//   final manager = FormDependencyManager(element);
//   ref.onDispose(() => manager.dispose());
//   return manager;
// });
//
// // Widget Usage
// class FieldWidget extends HookConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final manager = ref.watch(dependencyManagerProvider(element));
//     final state = useValueListenable(element.stateNotifier);
//
//     return AnimatedVisibility(
//       visible: !state.hidden,
//       child: FieldFactory.fromType(element),
//     );
//   }
// }
