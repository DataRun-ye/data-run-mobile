import 'package:d2_remote/shared/entities/d_run_identifiable.dart';

abstract class IdentifiableApiService<T extends IdentifiableModel> {
  Future<T> save(T identifiable);

  Future<T> getById(String id);

  /// if attribute is null, get all
  Future<List<T>> getWhere({
    String? attribute,
    dynamic value,
    int? limit,
    int? offset,
  });
}
