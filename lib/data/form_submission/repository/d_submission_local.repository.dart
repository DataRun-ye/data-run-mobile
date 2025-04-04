import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/di/injection.dart';
import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun/data_value/queries/data_form_submission.query.dart';
import 'package:d2_remote/shared/queries/base.query.dart';
import 'package:datarunmobile/commons/query/query_model.dart';
import 'package:datarunmobile/core/d2_remote_extensions/base_query_extension.dart';
import 'package:datarunmobile/commons/identifiable.repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DRunBaseRepository<DataFormSubmission>)
class SubmissionListLocalRepository
    extends DRunBaseRepository<DataFormSubmission> {
  SubmissionListLocalRepository()
      : super(sdkLocator<DataFormSubmissionQuery>());
}
