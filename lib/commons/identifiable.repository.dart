// import 'package:d2_remote/shared/mixin/d_run_base.dart';
// import 'package:d2_remote/shared/queries/base.repository.dart';
// import 'package:datarunmobile/commons/query/query_model.dart';
// import 'package:datarunmobile/core/common/paged_result.dart';
//
// abstract class DRunBaseRepository<T extends DRunBase> {
//   DRunBaseRepository(this.entityQuery);
//
//   final BaseRepository<T> entityQuery;
//
//   BaseRepository<T> buildQuery(QueryModel? query) {
//     entityQuery.resetFilters();
//
//     if (query != null) {
//       for (final attribute in query
//           .toMap()
//           .keys) {
//         entityQuery.where(
//             attribute: attribute, value: query.toMap()[attribute]);
//       }
//       if (query.orderBy != null) {
//         entityQuery.orderBy(attribute: query.orderBy!.attribute,
//             order: query.orderBy!.sortOrder);
//       }
//     }
//     return entityQuery;
//   }
//
//   Future<int> delete(String id) {
//     return entityQuery.byId(id).delete();
//   }
//
//   Future<List<T>> getByIds(List<String> ids) {
//     return entityQuery.byIds(ids).get();
//   }
//
//   Future<T?> getById(String id) {
//     return entityQuery.byId(id).getOne();
//   }
//
//   Future<List<T>> get({QueryModel? query}) async {
//     return buildQuery(query).get(limit: query?.limit, offset: query?.offset);
//   }
//
//   Future<T> save(T identifiable) async {
//     await entityQuery.setData(identifiable).save();
//     final entity = await entityQuery.byId(identifiable.id!).getOne();
//     return entity!;
//   }
//
//   Future<PagedResult<T>> getPage({
//     int offset = 1,
//     int limit = 20,
//     QueryModel? query,
//     String? searchQuery,
//   }) {
//     // buildQuery(query).like(attribute: attribute, value: value)..operator = LogicalOperator.OR;
//     throw UnimplementedError();
//   }
//
//   Future<int> getCount({QueryModel? query}) async {
//     return (await get(query: query)).length;
//   }
// }
