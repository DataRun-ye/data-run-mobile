import 'package:datarunmobile/features/form_submission/application/repeat_row_edit_session.dart';
import 'package:flutter/widgets.dart';

class RepeatRowEditSessionScope extends InheritedWidget {
  const RepeatRowEditSessionScope({
    super.key,
    required this.session,
    required super.child,
  });

  final RepeatRowEditSession session;

  static RepeatRowEditSession? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<RepeatRowEditSessionScope>()
      ?.session;

  @override
  bool updateShouldNotify(RepeatRowEditSessionScope oldWidget) =>
      !identical(session, oldWidget.session);
}
