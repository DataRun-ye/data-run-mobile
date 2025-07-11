// import 'package:d_sdk/d2_remote.dart';
// import 'package:d_sdk/database/app_database.dart';
// import 'package:datarunmobile/core/d2_remote_extensions/base_query_extension.dart';
// import 'package:datarunmobile/data/repository/identifiable.repository.dart';
// import 'package:injectable/injectable.dart';
//
// @Injectable(as: IdentifiableRepository<FormTemplateVersion>)
// class DFormTemplateLocalRepository implements IdentifiableRepository<FormTemplateVersion> {
//   @override
//   Future<int> delete(String id) {
//     return D2Remote.formModule.formTemplateV.byId(id).delete();
//   }
//
//   @override
//   Future<FormTemplateVersion?> getById(String id) {
//     return D2Remote.formModule.formTemplateV.byId(id).getOne();
//   }
//
//   @override
//   Future<List<FormTemplateVersion>> getWhere(
//       {String? attribute, value, int? limit, int? offset}) {
//     if (attribute != null) {
//       return D2Remote.formModule.formTemplateV
//           .resetFilters()
//           .where(attribute: attribute, value: value)
//           .get(limit: limit, offset: offset);
//     }
//     return D2Remote.formModule.formTemplateV
//         .resetFilters()
//         .get(limit: limit, offset: offset);
//   }
//
//   @override
//   Future<FormTemplateVersion> save(FormTemplateVersion identifiable) async {
//     await D2Remote.formModule.formTemplateV.setData(identifiable).save();
//     return D2Remote.formModule.formTemplateV.byId(identifiable.id!).getOne();
//   }
// }
