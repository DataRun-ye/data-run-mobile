import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';

class DataInstanceService {
  AppDatabase get _db => DSdk.db;

  Future<DataInstance> fetchSubmission(String submissionUid) async {
    final submission = await _db.dataInstancesDao.getById(submissionUid);
    return submission!;
  }
}
