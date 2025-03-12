import 'package:datarunmobile/core/element_instance/element_vistor/element_vistor.dart';
import 'package:equatable/equatable.dart';

abstract class ElementStat with EquatableMixin {
  String? get id;
  String? get templatePath;

  void accept(ElementVisitor<dynamic> visitor);

  @override
  List<Object?> get props => [id];
}
