import 'package:datarunmobile/data_run/d_activity/activity_model.dart';
import 'package:stacked/stacked.dart';

class ActivityCardViewModel extends BaseViewModel {
  ActivityCardViewModel({required this.id});

  final String id;

  ActivityModel? activity;

  Future<void> fetchActivityDetail() async {

  }
}
