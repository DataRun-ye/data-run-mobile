import 'package:d_sdk/core/utilities/date_helper.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/commons/extensions/string_extension.dart';
import 'package:datarunmobile/core/element_instance/data_value_repository.dart';
import 'package:datarunmobile/core/resources/resource_manager.provider.dart';
import 'package:injectable/injectable.dart';

@injectable
class MapValueToDisplay {
  MapValueToDisplay({required this.resources, required this.repository});

  final ResourceManager resources;
  final DataValueRepository repository;

  Future<String?> map(ValueType type, String? value) async {
    return switch (type) {
      ValueType.Boolean || ValueType.TrueOnly => !value.isNullOrEmpty
          ? value.toBoolean()
              ? resources.getString('yes')
              : resources.getString('no')
          : value,
      ValueType.Age => !value.isNullOrEmpty
          ? DateHelper.uiDateFormat().format(value.toDate()!)
          : value,
      ValueType.OrganisationUnit => !value.isNullOrEmpty
          ? await repository.getOrgUnitById(value!)
          : value,
      ValueType.Team => !value.isNullOrEmpty
          ? resources.getTeamLabel(await repository.getTeamById(value!))
          : value,
      ValueType.SelectOne => !value.isNullOrEmpty
          ? resources.getTeamLabel(await repository.getOptionById(value!))
          : value,
      _ => value,
    };
  }
}
