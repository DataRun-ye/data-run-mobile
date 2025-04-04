import 'package:datarunmobile/commons/query/order_by.dart';
import 'package:equatable/equatable.dart';

class QueryModel with EquatableMixin {
  QueryModel({this.limit, this.offset, this.orderBy});

  final int? limit;
  final int? offset;
  final OrderBy? orderBy;

  Map<String, dynamic> toMap() {
    final map = {
      'limit': this.limit,
      'offset': this.offset,
    };
    return map..removeWhere((_, v) => v == null);
  }

  @override
  List<Object?> get props => [limit, offset, orderBy];

  QueryModel copyWith({int? limit, int? offset, OrderBy? orderBy}) {
    return QueryModel(
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        orderBy: orderBy ?? this.orderBy);
  }
}
