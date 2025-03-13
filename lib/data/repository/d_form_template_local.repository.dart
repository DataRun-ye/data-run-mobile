import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:datarunmobile/core/d2_remote_extensions/base_query_extension.dart';
import 'package:datarunmobile/data/repository/identifiable.repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IdentifiableRepository<FormVersion>)
class DFormTemplateLocalRepository implements IdentifiableRepository<FormVersion> {
  @override
  Future<int> delete(String id) {
    return D2Remote.formModule.formTemplateV.byId(id).delete();
  }

  @override
  Future<FormVersion?> getById(String id) {
    return D2Remote.formModule.formTemplateV.byId(id).getOne();
  }

  @override
  Future<List<FormVersion>> getWhere(
      {String? attribute, value, int? limit, int? offset}) {
    if (attribute != null) {
      return D2Remote.formModule.formTemplateV
          .resetFilters()
          .where(attribute: attribute, value: value)
          .get(limit: limit, offset: offset);
    }
    return D2Remote.formModule.formTemplateV
        .resetFilters()
        .get(limit: limit, offset: offset);
  }

  @override
  Future<FormVersion> save(FormVersion identifiable) async {
    await D2Remote.formModule.formTemplateV.setData(identifiable).save();
    return D2Remote.formModule.formTemplateV.byId(identifiable.id!).getOne();
  }
}
