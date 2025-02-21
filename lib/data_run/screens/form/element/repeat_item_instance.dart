part of 'form_element.dart';

/// A section
class RepeatItemInstance extends Section {
  RepeatItemInstance(
      {required super.template,
      required super.form,
      super.elements,
      // required this.parentUid,
      String? uid,
      this.selected = false})
      : _uid = uid;

  bool selected;

  // final String parentUid;
  String? _uid;

  String? get uid => _uid;

  void setUid(String value) {
    if (_uid != null) {
      throw StateError('A RepeatItemInstance\'s uid cannot be changed');
    }
    _uid = value;
  }

  int get sectionIndex => (parentSection as RepeatSection)
      .sectionIndexWhere((section) => section == this);

  @override
  String get name => '$sectionIndex';

  set parentSection(SectionElement<dynamic>? parent) {
    if (parent is! RepeatSection?) {
      throw StateError(
          'A RepeatItemInstance\'s Parent can only be a RepeatInstance, parent: ${parent.runtimeType}');
    }

    _parentSection = parent;
  }

  @override
  Map<String, Object?>? reduceValue() {
    final map = <String, Object?>{};
    // map['parentUid'] = parentUid;
    // map['repeatUid'] = _uid ?? CodeGenerator.generateUid();
    _elements.forEach((key, element) {
      if (element.visible || hidden) {
        map[key] = element.value;
      }
    });

    return map;
  }

  String pathBuilder(String pathItem) {
    if (parentSection == null) {
      throw StateError('RepeatItemInstance\'s Parent should not be null');
    }

    return [parentSection?.elementPath, pathItem].whereType<String>().join('.');
  }
}
