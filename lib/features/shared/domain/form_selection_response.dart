import 'package:equatable/equatable.dart';

class FormSelectionResponse with EquatableMixin {
  FormSelectionResponse({required this.assignment, required this.formVersion});

  final String assignment;
  final String formVersion;

  @override
  List<Object?> get props => [formVersion, assignment];
}
