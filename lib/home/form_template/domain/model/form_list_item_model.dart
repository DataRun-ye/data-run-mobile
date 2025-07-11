import 'package:d_sdk/database/shared/shared.dart';

class FormListItemModel extends IdentifiableModel {
  FormListItemModel({
    required super.id,
    required super.name,
    super.label,
    required this.versionNumber,
  });

  final int versionNumber;

  @override
  List<Object?> get props => super.props + [versionNumber];
}
