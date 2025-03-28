import 'package:d2_remote/shared/mixin/d_run_base.dart';
import 'package:datarunmobile/commons/query_model.dart';

abstract class IdentifiableRepository<T extends DRunBase> {
  Future<T?> getById(String id);

  /// if attribute is null, get all
  Future<List<T>> get({QueryModel? query});

  Future<T> save(T identifiable);

  Future<int> delete(String id);
}
