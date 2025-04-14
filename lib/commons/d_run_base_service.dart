// import 'dart:async';
//
// import 'package:datarunmobile/commons/identifiable.repository.dart';
// import 'package:datarunmobile/commons/query/query_model.dart';
// import 'package:datarunmobile/core/models/d_run_base_model.dart';
// import 'package:fast_immutable_collections/fast_immutable_collections.dart';
//
// abstract class DRunBaseService<T extends DRunBaseModel<E>> {
//   DRunBaseService(this.repository);
//
//   DRunBaseRepository<E> repository;
//   IMap<String, T> models = IMap();
//
//   FutureOr<T> createModel(E identifiable);
//
//   Future<T?> getById(String id) async {
//     final E? entity = await repository.getById(id);
//     return entity != null ? createModel(entity) : null;
//   }
//
//   Future<List<T>> get({QueryModel? query}) async {
//     final List<E> entities = await repository.get(query: query);
//
//     List<T> entityModels = [];
//     for (final a in entities) {
//       entityModels.add(await createModel(a));
//     }
//
//     updateList(Map.fromIterable(entityModels,
//         key: (item) => item.id, value: (item) => item));
//
//     return entityModels;
//   }
//
//   Future<T> save(T entityModel) async {
//     final savedEntity = await repository.save(entityModel.baseEntity);
//     final savedModel = await createModel(savedEntity);
//     models = models.update(savedModel.id, (value) => savedModel,
//         ifAbsent: () => savedModel);
//
//     return savedModel;
//   }
//
//   void updateList(Map<String, T> entityModels) {
//     for (final key in entityModels.keys) {
//       models = models.putIfAbsent(key, () => entityModels[key]!);
//     }
//   }
// }
