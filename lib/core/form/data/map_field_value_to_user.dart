import 'package:d_sdk/core/utilities/date_helper.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/commons/extensions/string_extension.dart';
import 'package:datarunmobile/core/element_instance/data_value_repository.dart';
import 'package:datarunmobile/core/form/ui/intent/field_model.dart';
import 'package:datarunmobile/core/resources/resource_manager.provider.dart';

// @injectable
class MapFieldValueToUser {
  MapFieldValueToUser({required this.resources, required this.repository});

  final ResourceManager resources;
  final DataValueRepository repository;

  Future<String?> map(FieldModel field, DataElement dataElement) async {
    return switch (dataElement.type) {
      ValueType.Boolean || ValueType.TrueOnly => !field.value.isNullOrEmpty
          ? field.value.toBoolean()
              ? resources.getString('yes')
              : resources.getString('no')
          : field.value,
      ValueType.Age => !field.value.isNullOrEmpty
          ? DateHelper.uiDateFormat().format(field.value.toDate()!)
          : field.value,
      ValueType.Image ||
      ValueType.TrackerAssociate ||
      ValueType.Reference ||
      ValueType.Username ||
      ValueType.GeoJson =>
        resources.getString('unsupportedValueType'),
      ValueType.OrganisationUnit => !field.value.isNullOrEmpty
          ? await repository.getOrgUnitById(field.value!)
          : field.value,
      ValueType.Team => !field.value.isNullOrEmpty
          ? resources.getTeamLabel(await repository.getTeamById(field.value!))
          : field.value,
      ValueType.SelectMulti => field.value
          ?.split(', ')
          .map((code) => field.options
              .where((it) => it.contains(code))
              .map((o) => o.split('_')[1]))
          .join(', '),
      _ => field.value
    };
  }
}
