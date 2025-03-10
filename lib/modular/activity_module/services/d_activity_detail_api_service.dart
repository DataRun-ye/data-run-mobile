import 'package:datarun/core/models/d_run_identifiable.dart';
import 'package:datarun/modular/activity_module/services/identifiable_api_service.dart';

class DActivityDetailApiService
    implements IdentifiableApiService<DRunIdentifiable> {
  @override
  Future<DRunIdentifiable> save(DRunIdentifiable identifiable) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<DRunIdentifiable> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<DRunIdentifiable>> getWhere({
    String? attribute,
    dynamic value,
    int? limit,
    int? offset,
  }) {
    // TODO: implement getWhere
    throw UnimplementedError();
  }
}
