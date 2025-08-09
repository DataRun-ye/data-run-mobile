// import 'dart:async';
// import 'package:drun_annotations/drun_annotations.dart';
// import 'package:d_sdk/core/util/list_extensions.dart';
// import 'package:build/build.dart';
// import 'package:source_gen/source_gen.dart';
// import 'package:analyzer/dart/element/element.dart';
//
// import 'model_visitor.dart';
//
// // class ApiResourceGenerator extends GeneratorForAnnotation<ApiResource> {
// //   @override
// //   String generateForAnnotatedElement(
// //       Element element, // Represent a class in this case.
// //       ConstantReader annotation,
// //       BuildStep buildStep,
// //       ) {
// //     final ModelVisitor visitor = ModelVisitor();
// //     // Visit the class fields and constructor, then the className and fields
// //     // variable in the visitor will contain a value.
// //     element.visitChildren(visitor);
// //     final buffer = StringBuffer();
// //     // Start the map literal.
// //     buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
// //     buffer.writeln('final Map<Type, ApiResource> apiMetadataMap = {');
// //
// //     if (element is ClassElement) {
// //       // final annotation = annotation;
// //       final apiName = annotation.read('name').stringValue;
// //       final apiType = ApiResourceType.values.firstOrNullWhere(
// //               (t) => t.name == annotation.read('type').stringValue);
// //       final className = element.name;
// //       // Add an entry to the map.
// //       buffer.writeln(
// //           '  $className: const ApiResource(name: \'$apiName\', type: $apiType),');
// //     }
// //
// //     buffer.writeln('};');
// //     return buffer.toString();
// //   }
// //
// // }
//
// class ApiResourceGenerator extends Generator {
//   @override
//   FutureOr<String> generate(LibraryReader library, BuildStep buildStep) {
//     print('ApiResourceGenerator: start -------------------');
//     final buffer = StringBuffer();
//     // Start the map literal.
//     buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
//     buffer.writeln('final Map<Type, ApiResource> apiMetadataMap = {');
//
//     // Find all elements annotated with ApiMetadata.
//     final annotatedElements = library.annotatedWith(
//       const TypeChecker.fromRuntime(ApiResource),
//     );
//
//     for (var annotated in annotatedElements) {
//       final element = annotated.element;
//       // Ensure we're dealing with a class element.
//       if (element is ClassElement) {
//         print('ApiResourceGenerator: ${element.name}');
//         final annotation = annotated.annotation;
//         final apiName = annotation.read('name').stringValue;
//         final apiType = ApiResourceType.values.firstOrNullWhere(
//             (t) => t.name == annotation.read('type').stringValue);
//         final className = element.name;
//         // Add an entry to the map.
//         buffer.writeln(
//             '  $className: const ApiResource(name: \'$apiName\', type: $apiType),');
//       }
//     }
//
//     buffer.writeln('};');
//     return buffer.toString();
//   }
// }
