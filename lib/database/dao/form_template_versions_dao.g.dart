// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_template_versions_dao.dart';

// ignore_for_file: type=lint
mixin _$FormTemplateVersionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $FormTemplatesTable get formTemplates => attachedDatabase.formTemplates;
  $FormTemplateVersionsTable get formTemplateVersions =>
      attachedDatabase.formTemplateVersions;
  FormTemplateVersionsDaoManager get managers =>
      FormTemplateVersionsDaoManager(this);
}

class FormTemplateVersionsDaoManager {
  final _$FormTemplateVersionsDaoMixin _db;
  FormTemplateVersionsDaoManager(this._db);
  $$FormTemplatesTableTableManager get formTemplates =>
      $$FormTemplatesTableTableManager(_db.attachedDatabase, _db.formTemplates);
  $$FormTemplateVersionsTableTableManager get formTemplateVersions =>
      $$FormTemplateVersionsTableTableManager(
          _db.attachedDatabase, _db.formTemplateVersions);
}
