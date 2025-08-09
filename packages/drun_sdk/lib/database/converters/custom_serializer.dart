import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:drift/drift.dart';

class CustomSerializer extends ValueSerializer {
  @override
  T fromJson<T>(dynamic json) {
    if (json == null) {
      return null as T;
    }

    final typeList = <T>[];

    if (typeList is List<List<String>?>) {
      return json.map<String>((e) => e as String).toList() as T;
    }

    if (typeList is List<List<Translation>?>) {
      return (json as List<dynamic>?)
          ?.map<Translation>((e) => Translation.fromJson(e))
          .toList() as T;
    } else if (typeList is List<List<FormOption>?>) {
      return (json as List<dynamic>?)
          ?.map<FormOption>((e) => FormOption.fromJson(e))
          .toList() as T;
    } else if (typeList is List<List<DOptionSet>?>) {
      return (json as List<dynamic>?)
          ?.map<DOptionSet>((e) => DOptionSet.fromJson(e))
          .toList() as T;
    } else if (typeList is List<List<FormPermission>?>) {
      return (json as List<dynamic>?)
          ?.map<FormPermission>((e) => FormPermission.getType(e)!)
          .toList() as T;
    } else if (typeList is List<List<TeamFormPermission>?>) {
      return (json as List<dynamic>?)
          ?.map<TeamFormPermission>((e) => TeamFormPermission.fromJson(e))
          .toList() as T;
    } else if (typeList is List<List<Template>?>) {
      return (json as List<dynamic>?)
          ?.map<Template>((e) => Template.fromJsonFactory(e))
          .toList() as T;
    } else if (typeList is List<List<User>?>) {
      return (json as List<dynamic>?)
          ?.map<User>((e) => User.fromJson(e, serializer: CustomSerializer()))
          .toList() as T;
    }

    return driftRuntimeOptions.defaultSerializer.fromJson<T>(json);
  }

  // @override
  // dynamic toJson<T>(T value) {
  //   return driftRuntimeOptions.defaultSerializer.toJson(value);
  // }

  @override
  dynamic toJson<T>(T value) {
    if (value is List<Translation>) {
      return value.map((e) => e.toJson()).toList();
    } else if (value is List<FormOption>) {
      return value.map((e) => e.toJson()).toList();
    } else if (value is List<DOptionSet>) {
      return value.map((e) => e.toJson()).toList();
    } else if (value is List<TeamFormPermission>) {
      return value.map((e) => e.toJson()).toList();
    } else if (value is List<Template>) {
      return value.map((e) => Template.toJsonFactory(e)).toList();
    } else if (value is List<String>) {
      return value.map((e) => e).toList();
    } else if (value is List<FormOption>) {
      return value.map((e) => e.toJson()).toList();
    } else if (value is List<User>) {
      return value.map((e) => e.toJson()).toList();
    }
    // Handle other types
    return driftRuntimeOptions.defaultSerializer.toJson(value);
  }
}
