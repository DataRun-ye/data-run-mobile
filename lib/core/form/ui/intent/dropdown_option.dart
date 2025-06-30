import 'package:equatable/equatable.dart';

class DropdownOption with EquatableMixin {
  DropdownOption({required this.code, required this.name});

  final String code;
  final String name;

  @override
  List<Object?> get props => [code, name];

  DropdownOption copyWith({
    String? code,
    String? name,
  }) {
    return DropdownOption(
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }
}
