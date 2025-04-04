import 'package:d2_remote/core/datarun/utilities/date_helper.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/data_value/entities/data_value.entity.dart';
import 'package:d2_remote/shared/utilities/merge_mode.util.dart';

class DataValueRepository {
  static Future<DataValue?> get(
      {required String submissionId,
      required String path,
      String? parent}) async {
    return D2Remote.formSubmissionModule.dataValue.byId(_makeCompositeKey(
        submission: submissionId, parent: parent, path: path)).getOne();
  }

  static Future<DataValue> create(
      {required String submissionId,
      required String path,
      dynamic value,
      String? parent}) async {
    final elementPath = path.split('.');
    D2Remote.formSubmissionModule.dataValue.setData(DataValue(
        id: _makeCompositeKey(
            submission: submissionId, parent: parent, path: path),
        parent: parent,
        value: value,
        submission: submissionId,
        templatePath: path,
        dataElement: elementPath[elementPath.length - 1],
        dirty: true));

    await D2Remote.formSubmissionModule.dataValue.save();

    return D2Remote.formSubmissionModule.dataValue.data;
  }

  static Future<DataValue> save(
      {required String submissionId,
      required String path,
      dynamic value,
      String? parent}) async {
    final elementPath = path.split('.');
    D2Remote.formSubmissionModule.dataValue.setData(DataValue(
        id: _makeCompositeKey(
            submission: submissionId, parent: parent, path: path),
        parent: parent,
        value: value,
        submission: submissionId,
        templatePath: path,
        dataElement: elementPath[elementPath.length - 1],
        lastModifiedDate: DateHelper.nowUtc(),
        dirty: true));

    await D2Remote.formSubmissionModule.dataValue
      ..mergeMode = MergeMode.Merge
      ..save();

    return D2Remote.formSubmissionModule.dataValue.data;
  }

  static String _makeCompositeKey(
      {required String submission, String? parent, required String path}) {
    final elementIdentifier = path.split('.');
    return '$submission${parent != null ? '.$parent' : ''}.${elementIdentifier[elementIdentifier.length - 1]}';
  }
}
