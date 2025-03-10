part of 'form_element_model.dart';

/// A section
class RepeatItemElementModel extends SectionElementModel {
  RepeatItemElementModel(
      {super.hidden,
      super.elements,
      required String uid,
      required super.templatePath})
      : _uid = uid;

  final String _uid;

  String get uid => _uid;

  String get index =>
      '${parent.RepeatItemIndexWhere((section) => section.uid == this.uid)}';

  @override
  String get name => '$uid';

  RepeatElementModel get parent => _parent as RepeatElementModel;

  set parent(CollectionElementModel<dynamic>? parent) {
    if (parent is! RepeatElementModel) {
      throw StateError(
          'A RepeatItemInstance\'s Parent can only be a RepeatInstance, parent: ${parent.runtimeType}');
    }

    _parent = parent;
  }

  String pathBuilder(String? pathItem) {
    return [parent.elementPath, pathItem].whereType<String>().join('.');
  }

  @override
  RepeatItemElementModel getInstance() => RepeatItemElementModel(
      templatePath: templatePath, uid: CodeGenerator.generateCompositeUid());

  @override
  RepeatItemElementModel clone(CollectionElementModel<dynamic>? parent) {
    final instance = getInstance();
    instance.parent = parent;
    final elements =
        _elements.map((key, element) => MapEntry(key, element.clone(instance)));
    instance.addAll(elements);
    return instance;
  }
}
