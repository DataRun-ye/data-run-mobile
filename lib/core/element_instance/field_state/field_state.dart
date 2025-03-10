import 'package:datarun/core/element_instance/element_state.dart';
import 'package:datarun/core/element_instance/element_vistor/element_vistor.dart';
import 'package:datarun/data_run/screens/form_module/form_template/form_element_template.dart';

class FieldState extends ElementStat {
  FieldState._({
    required this.id,
    this.value,
    this.isVisible = true,
    this.isEnabled = true,
    this.errors,
    required this.templatePath,
  });

  factory FieldState.fromTemplate(FormElementTemplate template,
      [dynamic value]) {
    return FieldState._(
      id: template.id!,
      isEnabled: template.readOnly,
      value: value,
      templatePath: template.path!,
    );
  }

  final String id;
  final bool isVisible;
  final bool isEnabled;

  //
  bool get hasError => errors != null && errors!.isNotEmpty;

  final Map<String, dynamic>? errors;
  final dynamic value;
  final String templatePath;

  @override
  List<Object?> get props =>
      super.props + [value, hasError, errors, isVisible, templatePath];

  FieldState copyWith({
    String? id,
    dynamic value,
    bool? isVisible,
    bool? isEnabled,
    bool? hasError,
    Map<String, dynamic>? errors,
  }) {
    return FieldState._(
      id: id ?? this.id,
      value: value ?? this.value,
      isVisible: isVisible ?? this.isVisible,
      isEnabled: isEnabled ?? this.isEnabled,
      errors: errors ?? this.errors,
      templatePath: this.templatePath,
    );
  }

  @override
  void accept(ElementVisitor<dynamic> visitor) {
    visitor.doForField(this);
  }
}
