// import 'dart:async';
//
// import 'package:d2_remote/modules/datarun/form/shared/rule/rule_parse_extension.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';
// import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
//
// void useRegisterDependencies<E extends FormElementInstance<dynamic>>(E element,
//     [List<String> unresolvedDependencies = const []]) {
//   /// resolve and cache a form element dependencies
//   final resolvedDependency = useMemoized(() {
//     return _resolveFormElementDependencies(element);
//   }, [element.elementPath]);
//
//   /// bind dependencies
//   useEffect(() {
//     // if (element is FieldInstance) {
//     //   element.elementControl!.valueChanges.listen((value) {
//     //     if (value == null) {
//     //       element.updateStatus(element.elementState.reset(value: value));
//     //     } else {
//     //       element.updateStatus(element.elementState.copyWith(value: value));
//     //     }
//     //   });
//     // }
//
//     // bind to the
//     for (final elementDependency in resolvedDependency.values) {
//       // add a dependency entry in the the element's dependencies map
//       element.addDependency(elementDependency);
//       // add/bind action behaviour to the element
//       // evaluate element's initial status
//       // element.evaluate(elementDependency.name);
//     }
//
//     element.evaluate();
//
//     return () => element.dispose();
//   }, [element.elementPath]);
// }
//
// Map<String, FormElementInstance<dynamic>> _resolveFormElementDependencies(
//     FormElementInstance<dynamic> element) {
//   final List<String> dependencies = <String>[
//     ...element.template.dependencies,
//     ...element.template.filterDependencies
//   ].toSet().toList();
//   if (!element.type.isSectionType) {
//     logDebug(
//         info:
//             'resolving dependencies for: ${element.name} ${dependencies.length > 0 ? ', dependencies: ${dependencies}' : '... has no dependencies'}');
//   }
//
//   final Map<String, FormElementInstance<dynamic>> resolved = {};
//
//   for (final dependencyName in dependencies) {
//     final dependency = element.findElementInParentSection(dependencyName);
//     if (dependency != null) {
//       resolved[dependency.name] = dependency;
//     }
//   }
//
//   return resolved;
// }
//
// //
// // final loggerInitialization = Logger(
// //     printer: PrettyPrinter(
// //         colors: true,
// //         methodCount: 0,
// //         printEmojis: false,
// //         excludeBox: {Level.trace: true, Level.info: true}),
// //     level: Level.debug);
// //
// /// merging dependencies streams
// class MergedStreamResponse {
//   MergedStreamResponse(this.streamIdentity, this.data);
//
//   StreamIdentity streamIdentity;
//
//   dynamic data;
// }
//
// class StreamIdentity {
//   StreamIdentity(this.identifier, this.stream);
//
//   String identifier;
//
//   Stream<dynamic> stream;
// }
//
// Stream<MergedStreamResponse> mergeStream(List<StreamIdentity> streams) {
//   // Initialize a stream controller
//
//   StreamController<MergedStreamResponse> controller = StreamController();
//
//   for (var identity in streams) {
//     // Add a listener to all streams
//     identity.stream.listen((event) {
//       controller.add(MergedStreamResponse(identity, event));
//     });
//   }
//   return controller.stream;
// }
