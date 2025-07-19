// import 'package:d_sdk/database/shared/activity_model.dart';
// import 'package:flutter/material.dart';
//
// class ActivityInheritedWidget extends InheritedWidget {
//   const ActivityInheritedWidget({
//     super.key,
//     required this.activityModel,
//     required super.child,
//   });
//
//   final ActivityModel activityModel;
//
//   static ActivityModel of(BuildContext context) {
//     final ActivityInheritedWidget? inheritedWidget =
//         context.dependOnInheritedWidgetOfExactType<ActivityInheritedWidget>();
//     if (inheritedWidget == null) {
//       throw 'No ActivityInheritedWidget found in context.';
//     }
//     return inheritedWidget.activityModel;
//   }
//
//   @override
//   bool updateShouldNotify(covariant ActivityInheritedWidget oldWidget) {
//     return oldWidget.activityModel != activityModel;
//   }
// }
