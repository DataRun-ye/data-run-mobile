import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:datarunmobile/core/element_instance/element_state.dart';
import 'package:datarunmobile/core/element_instance/field_state/field_state.dart';
import 'package:datarunmobile/core/element_instance/repeat_instance/repeat_state.dart';
import 'package:datarunmobile/core/element_instance/sction_instance/section_state.dart';

ElementStat fromTemplate(Template template, {dynamic value}) {
  return switch (template) {
    SectionTemplate sectionTemplate => sectionTemplate.repeatable
        ? SectionState.fromTemplate(sectionTemplate, value: value)
        : RepeatState.fromTemplate(sectionTemplate, value: value),
    FieldTemplate fieldTemplate => FieldState.fromTemplate(fieldTemplate),
    _ => throw UnimplementedError(),
  };
}

// FieldState fromTemplateField<T>(FieldTemplate template) {
//   return switch (template.type) {
//     ValueType.Attribute ||
//     ValueType.PhoneNumber ||
//     ValueType.Text ||
//     ValueType.LongText ||
//     ValueType.Letter ||
//     ValueType.Email ||
//     ValueType.PhoneNumber ||
//     ValueType.Email ||
//     ValueType.Username ||
//     ValueType.Team ||
//     ValueType.Reference ||
//     ValueType.FullName ||
//     ValueType.URL ||
//     ValueType.FileResource ||
//     ValueType.Image ||
//     ValueType.OrganisationUnit ||
//     ValueType.SelectOne ||
//     ValueType.ScannedCode ||
//     ValueType.YesNo ||
//     ValueType.Date ||
//     ValueType.DateTime ||
//     ValueType.Time ||
//     ValueType.Calculated =>
//       FieldState.fromTemplate(template),
//     ValueType.Number ||
//     ValueType.UnitInterval ||
//     ValueType.Percentage ||
//     ValueType.Integer ||
//     ValueType.IntegerPositive ||
//     ValueType.IntegerNegative ||
//     ValueType.IntegerZeroOrPositive =>
//       FieldState.fromTemplate(template),
//     ValueType.Boolean => FieldState.fromTemplate(template),
//     ValueType.TrueOnly => FieldState.fromTemplate(template),
//     ValueType.Coordinate => FieldState.fromTemplate(template),
//     ValueType.Age => FieldState.fromTemplate(template),
//     ValueType.SelectMulti => FieldState.fromTemplate(template),
//     ValueType.GeoJson => FieldState.fromTemplate(template),
//     ValueType.Unknown => FieldState.fromTemplate(template),
//     _ => FieldState.fromTemplate(template)
//   };
// }
