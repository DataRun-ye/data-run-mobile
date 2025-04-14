import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class BaseModel with EquatableMixin {
  String get id;

  @override
  List<Object?> get props => [id];
}
