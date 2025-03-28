import 'package:datarunmobile/commons/query_model.dart';

class FormVersionQueryModel extends QueryModel {
  FormVersionQueryModel({this.formTemplate, this.version, super.limit, super.offset});

  final String? formTemplate;
  final int? version;

  @override
  FormVersionQueryModel copyWith({
    String? formTemplate,
    int? version,
    int? limit,
    int? offset,
  }) {
    return FormVersionQueryModel(
      formTemplate: formTemplate ?? this.formTemplate,
      version: version ?? this.version,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  @override
  List<Object?> get props => super.props + [formTemplate, version];

  @override
  Map<String, dynamic> toMap() {
    final map = {
      'formTemplate': this.formTemplate,
      'version': this.version,
      ...super.toMap()
    };
    return map..removeWhere((k, v) => v == null);
  }
}
