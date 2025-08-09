import 'package:d_sdk/database/shared/d_identifiable_model.dart';

class DataElementValue extends IdentifiableModel {
  DataElementValue({
    required super.id,
    required super.name,
    super.label,
    required this.path,
    required this.submission,
    this.parent,
    this.value,
    this.shown = false,
  });

  final String? value;
  final String path;
  final String? parent;
  final bool shown;
  final String submission;

  @override
  List<Object?> get props => super.props + [value, shown, parent, submission];
}
