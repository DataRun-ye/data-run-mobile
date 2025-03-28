import 'package:d2_remote/shared/entities/base.entity.dart';
import 'package:d2_remote/shared/queries/base.query.dart';

extension BaseQueryExtension<E extends BaseQuery<T>, T extends BaseEntity> on E {
  E resetFilters() {
    id = null;
    filters?.clear();
    return this;
  }
}
