import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class DRunBaseModel with EquatableMixin {
  String get id;

  DRunBaseModel copyWith({String? id});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
    };
  }

  @override
  List<Object?> get props => [id];
}
