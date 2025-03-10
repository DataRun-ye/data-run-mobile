abstract class FormNode {
  String? path;
  Map<String, dynamic> get data;
  void validate(); // Field-specific validation
}

class FormFieldNode extends FormNode {
  dynamic value;

  @override
  Map<String, dynamic> get data => throw UnimplementedError();

  @override
  void validate() {
    // TODO: implement validate
  }
}

class FormSectionNode extends FormNode {
  List<FormNode> children = [];
  final Map<String, dynamic> data = {};

  @override
  void validate() {
    // TODO: implement validate
  }
}

class FormTableNode extends FormNode {
  List<FormSectionNode> rows = [];

  @override
  Map<String, dynamic> data = {};

  @override
  void validate() {
    // TODO: implement validate
  }
}
