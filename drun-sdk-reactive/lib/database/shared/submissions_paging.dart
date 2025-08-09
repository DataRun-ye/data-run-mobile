// import 'package:d_sdk/database/shared/shared.dart';
//
// class SubmissionPage extends PagedItems<SubmissionSummary> {
//   final String formId;
//   final String? assignmentId;
//
//   SubmissionPage({
//     super.items,
//     super.page,
//     super.itemsCount,
//     super.paged = true,
//     super.totalCount,
//     required this.formId,
//     this.assignmentId,
//   });
//
//   SubmissionPage copyWith({
//     String? formId,
//     String? assignmentId,
//     int? page,
//     int? itemsCount,
//     bool? paged,
//   }) {
//     return SubmissionPage(
//         formId: formId ?? this.formId,
//         assignmentId: assignmentId ?? this.assignmentId,
//         page: page ?? this.page,
//         itemsCount: itemsCount ?? this.itemsCount,
//         paged: paged ?? this.paged);
//   }
//
//   @override
//   List<Object?> get props =>
//       super.props + [formId, assignmentId];
// }
