import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:datarunmobile/core/common/state.dart';

class SubmissionItemSummaryModel with EquatableMixin {
  SubmissionItemSummaryModel(
      {this.code,
      required this.orgUnit,
      required this.syncStatus,
      Map<String, dynamic>? formData})
      : this.formData = IMap.orNull(formData) ?? const IMap.empty();

  final String? code;
  final String orgUnit;
  final SyncStatus syncStatus;
  final IMap<String, dynamic> formData;

  @override
  List<Object?> get props => [code, orgUnit, syncStatus, formData];
}
