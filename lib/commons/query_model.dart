import 'package:equatable/equatable.dart';

class QueryModel with EquatableMixin {
  QueryModel({this.limit, this.offset});

  final int? limit;
  final int? offset;


  Map<String, dynamic> toMap() {
    final map = {
      'limit': this.limit,
      'offset': this.offset,
    };
    return map..removeWhere((_, v) => v == null);
  }

  @override
  List<Object?> get props => [limit, offset];

  QueryModel copyWith({
    int? limit,
    int? offset,
  }) {
    return QueryModel(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }
}
