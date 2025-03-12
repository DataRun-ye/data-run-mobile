import 'package:datarunmobile/core/element_instance/field_state/field_state.dart';
import 'package:datarunmobile/core/element_instance/repeat_instance/repeat_row_state.dart';
import 'package:datarunmobile/core/element_instance/repeat_instance/repeat_state.dart';
import 'package:datarunmobile/core/element_instance/sction_instance/section_state.dart';

abstract class ElementVisitor<T> {
  T doForField(FieldState field);

  T doForSection(SectionState section);

  T doForRepeatSection(RepeatState section);

  T doForRepeatItem(RowState section);
}
