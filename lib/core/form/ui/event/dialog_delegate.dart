import 'package:d_sdk/core/utilities/date_helper.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/commons/extensions/standard_extensions.dart';
import 'package:datarunmobile/core/form/ui/intent/form_intent_sealed.dart';

import 'package:datarunmobile/core/form/ui/event/list_view_ui_events.data.dart';

class DialogDelegate {
  static FormIntent handleDateInput(String uid, int year, int month, int day) {
    final ageDate = DateTime(year, month, day);

    final date = DateHelper.formatForUi(ageDate);

    return FormIntent.onSave(uid, date, ValueType.Date);
  }

  static FormIntent handleTimeInput(
      String uid, DateTime? date, int hourOfDay, int minutes) {
    final DateTime dateTime =
        date?.copyWith(hour: hourOfDay, minute: minutes) ??
            DateTime.now().copyWith(hour: hourOfDay, minute: minutes);

    final String dateValue = when(date, {
      null: () => DateHelper.timeFormat().format(dateTime),
    }).orElse(() => DateHelper.formatForUi(dateTime, includeTime: true));

    return FormIntent.onSave(uid, dateValue,
        date?.let((it) => ValueType.DateTime) ?? ValueType.Time);
  }

  static ListViewUiEvents handleDateTimeInput(
    String uid,
    String label,
    DateTime? date,
    int year,
    int month,
    int day,
  ) {
    final DateTime dateTime =
        date?.copyWith(year: year, month: month, day: day) ??
            DateTime.now().copyWith(year: year, month: month, day: day);

    return ListViewUiEvents.openTimePicker(
        uid: uid, label: label, date: dateTime, isDateTime: true);
  }
}
