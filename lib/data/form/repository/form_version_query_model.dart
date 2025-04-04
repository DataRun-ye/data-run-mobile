import 'package:datarunmobile/commons/query/query_model.dart';

class FormVersionQueryModel extends QueryModel {
  FormVersionQueryModel(
      {this.formTemplate,
      this.version,
      super.limit,
      super.offset,
      super.orderBy});

  final String? formTemplate;
  final int? version;

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
