// import 'package:d2_remote/core/common/value_type.dart';
// import 'package:d2_remote/d2_remote.dart';
// import 'package:d2_remote/modules/metadata/option_set/entities/option.entity.dart';
// import 'package:d2_remote/modules/metadata/program/entities/program_tracked_entity_attribute.entity.dart';
// import 'package:d2_remote/modules/metadata/program/entities/tracked_entity_attribute.entity.dart';
// import 'package:d2_remote/modules/metadata/program/entities/tracked_entity_type_attribute.entity.dart';
// import 'package:d2_remote/shared/utilities/sort_order.util.dart';
// import 'package:dartx/dartx_io.dart';
//
// import '../model/field_ui_model.dart';
// import '../model/option_set_configuration.dart';
// import '../ui/field_view_model_factory.dart';
// import 'data_entry_base_repository.dart';
//
// class SearchRepository extends DataEntryBaseRepository {
//   SearchRepository(
//       {required this.fieldViewModelFactory,
//       this.programUid,
//       required this.teiTypeUid,
//       required this.currentSearchValues})
//       : super(fieldViewModelFactory);
//   final FieldViewModelFactory fieldViewModelFactory;
//   String? programUid;
//   final String teiTypeUid;
//   final Map<String, String> currentSearchValues;
//
//   @override
//   Future<List<FieldUiModel>> list() {
//     if (programUid != null) {
//       return programTrackedEntityAttributes();
//     }
//     return trackedEntitySearchFields();
//   }
//
//   @override
//   Future<List<String>> sectionUids() {
//     return Future.sync(() => <String>[]);
//   }
//
//   @override
//   bool isEvent() {
//     return false;
//   }
//
//   Future<List<FieldUiModel>> trackedEntitySearchFields() async {
//     final List<TrackedEntityTypeAttribute> teTypeAttributes = await D2Remote
//         .programModule.trackedEntityTypeAttribute
//         .byTrackedEntityType(teiTypeUid)
//         .where(attribute: 'searchable', value: true)
//         .get();
//
//     final List<FieldUiModel> fields = [];
//
//     for (final typeAttribute in teTypeAttributes) {
//       final TrackedEntityAttribute attribute = (await D2Remote
//           .programModule.trackedEntityAttribute
//           .byId(typeAttribute.id!)
//           .getOne())!;
//       if (attribute.optionSet != null) {
//         final int optionsCount = await D2Remote.optionModule.option
//             .byOptionSet(attribute.optionSet!)
//             .count();
//
//         final List<Option> options = await D2Remote.optionModule.option
//             .byOptionSet(attribute.optionSet!)
//             .orderBy(attribute: 'sortOrder', order: SortOrder.ASC)
//             .get();
//
//         final OptionSetConfiguration optionSetConfiguration =
//             OptionSetConfiguration.config(optionsCount, () => options);
//
//         final field = await fieldViewModelFactory.createForAttribute(
//             trackedEntityAttribute: attribute,
//             value: currentSearchValues[attribute.id],
//             editable: true,
//             optionSetConfiguration: optionSetConfiguration);
//         fields.add(field);
//       }
//     }
//     return fields
//         .filter((item) =>
//             item.valueType != ValueType.IMAGE &&
//             item.valueType != ValueType.COORDINATE)
//         .toList(growable: false);
//   }
//
//   Future<List<FieldUiModel>> programTrackedEntityAttributes() async {
//     final List<ProgramTrackedEntityAttribute> searchableAttributes =
//         (await D2Remote
//                 .programModule.programTrackedEntityAttribute
//                 .byProgram(programUid ?? '')
//                 .get())
//             .filter((programAttribute) =>
//                 programAttribute.searchable! ||
//                 programAttribute.isUnique == true)
//             .toList(growable: false);
//
//     final List<FieldUiModel> fields = [];
//
//     for (final programAttribute in searchableAttributes) {
//       final TrackedEntityAttribute attribute = (await D2Remote
//           .programModule.trackedEntityAttribute
//           .byId(programAttribute.attribute)
//           .getOne())!;
//
//       if (attribute.optionSet != null) {
//         final int optionsCount = await D2Remote.optionModule.option
//             .byOptionSet(attribute.optionSet!)
//             .count();
//
//         final List<Option> options = await D2Remote.optionModule.option
//             .byOptionSet(attribute.optionSet!)
//             .orderBy(attribute: 'sortOrder', order: SortOrder.ASC)
//             .get();
//
//         final OptionSetConfiguration optionSetConfiguration =
//             OptionSetConfiguration.config(optionsCount, () => options);
//
//         final field = await fieldViewModelFactory.createForAttribute(
//             trackedEntityAttribute: attribute,
//             programTrackedEntityAttribute: programAttribute,
//             value: currentSearchValues[attribute.id],
//             editable: true,
//             optionSetConfiguration: optionSetConfiguration);
//         fields.add(field);
//       }
//     }
//     return fields
//         .filter((item) =>
//             item.valueType != ValueType.IMAGE &&
//             item.valueType != ValueType.COORDINATE)
//         .toList(growable: false);
//   }
// }
