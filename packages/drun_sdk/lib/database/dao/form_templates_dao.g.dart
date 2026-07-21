// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_templates_dao.dart';

// ignore_for_file: type=lint
mixin _$FormTemplatesDaoMixin on DatabaseAccessor<AppDatabase> {
  $FormTemplatesTable get formTemplates => attachedDatabase.formTemplates;
  FormTemplatesDaoManager get managers => FormTemplatesDaoManager(this);
}

class FormTemplatesDaoManager {
  final _$FormTemplatesDaoMixin _db;
  FormTemplatesDaoManager(this._db);
  $$FormTemplatesTableTableManager get formTemplates =>
      $$FormTemplatesTableTableManager(_db.attachedDatabase, _db.formTemplates);
}
