import 'package:datarunmobile/core/element_instance/element_vistor/element_vistor.dart';
import 'package:datarunmobile/core/element_instance/field_state/field_state.dart';
import 'package:datarunmobile/core/element_instance/repeat_instance/repeat_row_state.dart';
import 'package:datarunmobile/core/element_instance/repeat_instance/repeat_state.dart';
import 'package:datarunmobile/core/element_instance/sction_instance/section_state.dart';

class ExtractValueVisitor implements ElementVisitor<dynamic> {
  Map<String, dynamic> values = {};

  @override
  dynamic doForField(FieldState field) {
    return field.value;
  }

  @override
  dynamic doForRepeatItem(RowState row) {
    return row.fields.map((key, value) => MapEntry(key, value.accept(this)));
  }

  @override
  dynamic doForRepeatSection(RepeatState section) {
    return section.fields
        .map((key, value) => MapEntry(key, value.accept(this)));
  }

  @override
  dynamic doForSection(SectionState section) {
    return section.fields
        .map((key, value) => MapEntry(key, value.accept(this)));
  }
}
