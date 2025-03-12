// import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
// import 'package:d2_remote/shared/enumeration/assignment_status.dart';
// import 'package:datarunmobile/data_run/d_activity/activity_card.dart';
// import 'package:datarunmobile/data_run/d_activity/activity_inherited_widget.dart';
// import 'package:datarunmobile/data_run/d_assignment/assignment_detail/assignment_detail_page.dart';
// import 'package:datarunmobile/data_run/d_assignment/model/assignment_model.dart';
// import 'package:datarunmobile/data_run/d_assignment/assignment.provider.dart';
// import 'package:datarunmobile/data_run/d_assignment/assignment_page.dart';
// import 'package:datarunmobile/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
//
// class AssignmentOverviewItem extends ConsumerWidget {
//   const AssignmentOverviewItem({
//     super.key,
//     required this.assignment,
//     required this.onFormSubmission,
//     required this.onViewDetails,
//     required this.onChangeStatus,
//   });
//
//   final AssignmentModel assignment;
//   final Function(DataFormSubmission submission) onFormSubmission;
//   final VoidCallback onViewDetails;
//   final void Function(AssignmentStatus newStatus) onChangeStatus;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final searchQuery =
//         ref.watch(filterQueryProvider.select((value) => value.searchQuery));
//     final activityModel = ActivityInheritedWidget.of(context);
//     return Card(
//       color: statusColor(assignment.status),
//       margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: _buildHighlightedText(
//                       assignment.activity, searchQuery, context),
//                 ),
//                 buildStatusBadge(assignment.status),
//               ],
//             ),
//             const SizedBox(height: 8),
//             _buildDetailRow(
//               context,
//               icon: Icons.category,
//               label: S.of(context).scope,
//               value: Intl.message(assignment.scope.name.toLowerCase()),
//               style: TextStyle(color: Colors.grey[700]),
//             ),
//
//             const Divider(height: 20),
//
//             // Details Section
//             _buildDetailIcon(
//                 Icons.location_on,
//                 '${assignment.entityCode} - ${assignment.entityName}',
//                 searchQuery,
//                 context),
//             const SizedBox(height: 8),
//             _buildDetailIcon(
//                 Icons.group,
//                 '${S.of(context).team}: ${assignment.teamCode}',
//                 searchQuery,
//                 context),
//             const SizedBox(height: 16),
//
//             if (assignment.dueDate != null)
//               _buildDetailRow(
//                 context,
//                 icon: Icons.calendar_today,
//                 label: S.of(context).dueDate,
//                 value: formatDate(assignment.dueDate!, context),
//                 style: assignment.dueDate!.isBefore(DateTime.now())
//                     ? Theme.of(context)
//                         .textTheme
//                         .bodyMedium
//                         ?.copyWith(color: Colors.red)
//                     : Theme.of(context)
//                         .textTheme
//                         .bodyMedium
//                         ?.copyWith(color: Colors.grey[700]),
//               ),
//             if (assignment.startDay != null && assignment.dueDate != null)
//               _buildDetailRow(
//                 context,
//                 icon: Icons.calendar_today,
//                 label: S.of(context).dueDay,
//                 value: '${S.of(context).day} ${assignment.startDay}',
//                 style: assignment.dueDate!.isBefore(DateTime.now())
//                     ? Theme.of(context)
//                         .textTheme
//                         .bodyMedium
//                         ?.copyWith(color: Colors.red)
//                     : Theme.of(context)
//                         .textTheme
//                         .bodyMedium
//                         ?.copyWith(color: Colors.grey[700]),
//               ),
//             if (assignment.rescheduledDate != null)
//               _buildDetailIcon(
//                 Icons.calendar_view_day,
//                 formatDate(assignment.rescheduledDate!, context),
//                 searchQuery,
//                 context,
//               ),
//             const Divider(height: 20),
//
//             // Forms Section
//             Text(
//               '${S.of(context).formsAssigned}: ${assignment.forms.length}',
//               style: Theme.of(context).textTheme.labelMedium,
//               softWrap: true,
//             ),
//
//             const SizedBox(height: 16),
//             // Resources Section
//
//             _buildResourcesComparison(context,
//                 ActivityInheritedWidget.of(context).managedTeams.length > 0),
//
//             const SizedBox(height: 16),
//
//             // Actions Section
//             Column(
//               children: [
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ElevatedButton.icon(
//                         onPressed: () async {
//                           await showFormSelectionBottomSheet(
//                               context, assignment, activityModel);
//                           ref.invalidate(assignmentsProvider);
//                         },
//                         icon: const Icon(Icons.document_scanner),
//                         label: Text(
//                           S.of(context).openNewForm,
//                           softWrap: true,
//                         ),
//                       ),
//                       TextButton.icon(
//                         onPressed: onViewDetails,
//                         icon: const Icon(Icons.info_outline),
//                         label: Text(S.of(context).viewDetails, softWrap: true),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // const Divider(height: 20),
//                 // DropdownButton<AssignmentStatus>(
//                 //   onChanged: (value) {
//                 //     if (value != null) onChangeStatus(value);
//                 //   },
//                 //   value: assignment.status,
//                 //   items: AssignmentStatus.values
//                 //       .map((status) => DropdownMenuItem<AssignmentStatus>(
//                 //             value: status,
//                 //             child: Text(
//                 //               Intl.message(status.name.toLowerCase()),
//                 //               style: Theme.of(context).textTheme.labelSmall,
//                 //             ),
//                 //           ))
//                 //       .toList(),
//                 // ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Color? getCardColor(AssignmentStatus status) {
//     if (assignment.status.isNotStarted() || assignment.status.isRescheduled()) {
//       return Colors.grey.withOpacity(0.3); // Set the color to gray
//     }
//     if (assignment.status.isDone()) {
//       return null; // Set the color to gray
//     }
//     return Colors.greenAccent.withOpacity(0.3); // Use default color
//   }
//
//   //
//   // Future<void> _showFormSelectionBottomSheet(BuildContext context) async {
//   //   try {
//   //     final activityModel = ActivityInheritedWidget.of(context);
//   //     await showModalBottomSheet(
//   //       enableDrag: false,
//   //       // backgroundColor: Colors.transparent,
//   //       context: context,
//   //       builder: (BuildContext context) {
//   //         return ActivityInheritedWidget(
//   //           activityModel: activityModel,
//   //           child: FormSubmissionCreate(
//   //             assignment: assignment,
//   //             onNewFormCreated: (createdSubmissionId) {
//   //               onFormSubmission(createdSubmissionId);
//   //             },
//   //           ),
//   //         );
//   //       },
//   //     );
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text(
//   //             '${S.of(context).errorOpeningForm}: ${e.toString().substring(0, 50)}'),
//   //         duration: const Duration(seconds: 2),
//   //       ),
//   //     );
//   //     return;
//   //   }
//   // }
//   //
//   Widget _buildHighlightedText(
//       String text, String searchQuery, BuildContext context) {
//     if (searchQuery.isEmpty) {
//       return Text(text, softWrap: true);
//     }
//
//     final matches = RegExp(searchQuery, caseSensitive: false).allMatches(text);
//     if (matches.isEmpty) {
//       return Text(text, softWrap: true);
//     }
//
//     final List<TextSpan> spans = [];
//     int start = 0;
//
//     for (final match in matches) {
//       if (match.start > start) {
//         spans.add(TextSpan(text: text.substring(start, match.start)));
//       }
//       spans.add(TextSpan(
//         text: text.substring(match.start, match.end),
//         style: const TextStyle(backgroundColor: Colors.yellow),
//       ));
//       start = match.end;
//     }
//
//     if (start < text.length) {
//       spans.add(TextSpan(text: text.substring(start)));
//     }
//
//     return RichText(
//       text:
//           TextSpan(style: DefaultTextStyle.of(context).style, children: spans),
//     );
//   }
//
//   Widget _buildDetailIcon(
//       IconData icon, String value, String searchQuery, BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, size: 20, color: Colors.grey[600]),
//         const SizedBox(width: 4),
//         _buildHighlightedText(value, searchQuery, context),
//       ],
//     );
//   }
//
//   Widget _buildResourcesComparison(BuildContext context, bool showTarget) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           S.of(context).resources,
//           style: Theme.of(context).textTheme.labelMedium,
//         ),
//         const SizedBox(height: 8),
//         ...assignment.allocatedResources.keys.map((key) {
//           final allocated = assignment.allocatedResources[key] ?? 0;
//           final reported = assignment.reportedResources[key.toLowerCase()] ?? 0;
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 Intl.message(key.toLowerCase()),
//                 style: Theme.of(context).textTheme.bodySmall,
//               ),
//               Text(
//                 showTarget ? '${reported} / $allocated' : '$reported',
//                 style: Theme.of(context).textTheme.bodySmall,
//               ),
//             ],
//           );
//         }).toList(),
//       ],
//     );
//   }
//
//   Widget _buildDetailRow(BuildContext context,
//       {required IconData icon,
//       required String label,
//       required String value,
//       String searchQuery = '',
//       TextStyle? style}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           Icon(icon, size: 20, color: Colors.grey[600]),
//           const SizedBox(width: 8),
//           Text('$label:', style: style, softWrap: true),
//           const SizedBox(width: 8),
//           Expanded(
//             child: _buildHighlightedText(value, searchQuery, context),
//           ),
//         ],
//       ),
//     );
//   }
//
// // Widget _buildStatusBadge() {
// //   IconData statusIcon;
// //   Color badgeColor;
// //
// //   switch (assignment.status) {
// //     case AssignmentStatus.NOT_STARTED:
// //       statusIcon = Icons.hourglass_empty;
// //       badgeColor = Colors.grey;
// //       break;
// //     case AssignmentStatus.IN_PROGRESS:
// //       statusIcon = Icons.autorenew;
// //       badgeColor = Colors.blue;
// //       break;
// //     case AssignmentStatus.COMPLETED:
// //       statusIcon = Icons.check_circle;
// //       badgeColor = Colors.green;
// //       break;
// //     case AssignmentStatus.RESCHEDULED:
// //       statusIcon = Icons.schedule;
// //       badgeColor = Colors.orange;
// //       break;
// //     case AssignmentStatus.CANCELLED:
// //       statusIcon = Icons.cancel;
// //       badgeColor = Colors.red;
// //       break;
// //     default:
// //       statusIcon = Icons.help_outline;
// //       badgeColor = Colors.black;
// //   }
// //
// //   return Tooltip(
// //     message: Intl.message(assignment.status.name.toLowerCase()),
// //     child: Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// //       decoration: BoxDecoration(
// //         color: badgeColor,
// //         borderRadius: BorderRadius.circular(20),
// //       ),
// //       child: Icon(statusIcon, color: Colors.white),
// //     ),
// //   );
// // }
// }
