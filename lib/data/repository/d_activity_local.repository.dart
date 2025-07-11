// import 'package:d_sdk/d2_remote.dart';
// import 'package:d_sdk/database/database.dart';
// import 'package:datarunmobile/core/d2_remote_extensions/base_query_extension.dart';
// import 'package:datarunmobile/data/repository/identifiable.repository.dart';
// import 'package:injectable/injectable.dart';
//
// @Injectable(as: IdentifiableRepository<Activity>)
// class DActivityLocalRepository implements IdentifiableRepository<Activity> {
//   @override
//   Future<int> delete(String id) {
//     return D2Remote.activityModuleD.activity.byId(id).delete();
//   }
//
//   @override
//   Future<Activity?> getById(String id) {
//     return D2Remote.activityModuleD.activity.byId(id).getOne();
//   }
//
//   @override
//   Future<List<Activity>> getWhere(
//       {String? attribute, value, int? limit, int? offset}) {
//     if (attribute != null) {
//       return D2Remote.activityModuleD.activity
//           .resetFilters()
//           .where(attribute: attribute, value: value)
//           .get(limit: limit, offset: offset);
//     }
//     return D2Remote.activityModuleD.activity
//         .resetFilters()
//         .get(limit: limit, offset: offset);
//   }
//
//   @override
//   Future<Activity> save(Activity identifiable) async {
//     await D2Remote.activityModuleD.activity.setData(identifiable).save();
//     return D2Remote.activityModuleD.activity.byId(identifiable.id!).getOne();
//   }
// }
