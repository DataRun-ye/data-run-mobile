import 'package:datarunmobile/core/element_instance/element_state.dart';
import 'package:datarunmobile/core/element_instance/element_state_factory.dart';
import 'package:datarunmobile/core/element_instance/element_vistor/element_vistor.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class SectionState extends ElementStat {
  SectionState({
    required this.id,
    this.fields = const IMapConst({}),
    this.isVisible = true, // Defaults to visible
    required this.templatePath,
  });

  factory SectionState.fromTemplate(SectionElementTemplate template,
      {Map<String, dynamic>? value}) {
    final fields = IMap.fromIterable(template.children,
        keyMapper: (t) => t.id!,
        valueMapper: (t) => fromTemplate(template, value: value?[t.id]));

    // final allFields = template.treeFields
    //     .map((f) => fromTemplate(template, value: value?[f.id]))
    //     .toIList();
    return SectionState(
        id: template.name!, fields: fields, templatePath: template.path);
  }

  final String id;

  // final IList<ElementStat> fields;
  final IMap<String, ElementStat> fields;

  final bool isVisible;

  final String? templatePath;

  SectionState copyWith({
    String? id,
    bool? isVisible,
    IMap<String, ElementStat>? fields,
  }) {
    return SectionState(
        id: id ?? this.id,
        fields: fields ?? this.fields,
        isVisible: isVisible ?? this.isVisible,
        templatePath: templatePath);
  }

  @override
  void accept(ElementVisitor<dynamic> visitor) {
    visitor.doForSection(this);
  }

  @override
  List<Object?> get props => super.props..addAll([isVisible, fields]);
}
