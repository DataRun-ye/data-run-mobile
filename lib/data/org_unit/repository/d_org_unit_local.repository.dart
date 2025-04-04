import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/di/injection.dart';
import 'package:d2_remote/modules/metadatarun/metadatarun.dart';
import 'package:d2_remote/modules/metadatarun/org_unit/entities/org_unit.entity.dart';
import 'package:d2_remote/shared/queries/base.query.dart';
import 'package:datarunmobile/core/d2_remote_extensions/base_query_extension.dart';
import 'package:datarunmobile/commons/identifiable.repository.dart';
import 'package:datarunmobile/commons/query/query_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DRunBaseRepository<OrgUnit>)
class DOrgUnitLocalRepository extends DRunBaseRepository<OrgUnit> {
  DOrgUnitLocalRepository() : super(sdkLocator<OrgUnitQuery>());
}
