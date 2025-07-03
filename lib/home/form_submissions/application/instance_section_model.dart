import 'package:equatable/equatable.dart';

class InstanceSectionModel with EquatableMixin {
  InstanceSectionModel(
      {required this.sectionUid,
      required this.sectionName,
      required this.numberOfCompletedFields,
      required this.numberOfTotalFields});

  final String sectionUid;
  final String sectionName;
  final int numberOfCompletedFields;
  final int numberOfTotalFields;

  InstanceSectionModel copyWith({
    String? sectionUid,
    String? sectionName,
    int? numberOfCompletedFields,
    int? numberOfTotalFields,
  }) {
    return InstanceSectionModel(
      sectionUid: sectionUid ?? this.sectionUid,
      sectionName: sectionName ?? this.sectionName,
      numberOfCompletedFields:
          numberOfCompletedFields ?? this.numberOfCompletedFields,
      numberOfTotalFields: numberOfTotalFields ?? this.numberOfTotalFields,
    );
  }

  @override
  List<Object?> get props =>
      [sectionUid, sectionName, numberOfCompletedFields, numberOfTotalFields];
}
