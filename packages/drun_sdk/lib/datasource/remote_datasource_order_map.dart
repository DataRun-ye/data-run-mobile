import 'package:d_sdk/datasource/remote_data_sources/activity_datasource.dart';
import 'package:d_sdk/datasource/remote_data_sources/assignment_datasource.dart';
import 'package:d_sdk/datasource/remote_data_sources/data_element_datasource.dart';
import 'package:d_sdk/datasource/remote_data_sources/data_value_datasource.dart';
import 'package:d_sdk/datasource/remote_data_sources/form_template_datasource.dart';
import 'package:d_sdk/datasource/remote_data_sources/option_set_datasource.dart';
import 'package:d_sdk/datasource/remote_data_sources/org_unit_datasource.dart';
import 'package:d_sdk/datasource/remote_data_sources/ou_level_datasource.dart';
import 'package:d_sdk/datasource/remote_data_sources/project_datasource.dart';
import 'package:d_sdk/datasource/remote_data_sources/team_datasource.dart';
import 'package:d_sdk/datasource/remote_data_sources/user_datasource.dart';
import 'package:d_sdk/datasource/remote_data_sources/user_form_permission_datasource.dart';

class DSOrder {
  static const int user = 100;
  static const int project = 200;
  static const int activity = 300;
  static const int ouLevel = 400;
  static const int orgUnit = 500;
  static const int optionSet = 600;

  // static const int option = 700;
  static const int dataElement = 800;
  static const int formTemplateVersion = 900;
  static const int formTemplate = 1000;
  static const int team = 1100;
  static const int managedTeam = 1200;
  static const int userFormAccess = 1300;
  static const int assignment = 1400;

  // static const int assignmentForms = 1450;
  // static const int repeatInstance = 1600;
  static const int dataValue = 1700;
  static const int metadataSubmission = 1800;

  static const orderedRemoteDatasource = <int, Type>{
    user: UserDatasource,
    project: ProjectDatasource,
    activity: ActivityDatasource,
    ouLevel: OuLevelDatasource,
    orgUnit: OrgUnitDatasource,
    optionSet: OptionSetDatasource,
    dataElement: DataElementDatasource,
    formTemplate: DataFormTemplateDatasource,
    team: TeamDatasource,
    userFormAccess: UserFormAccessesDatasource,
    assignment: AssignmentDatasource,
    dataValue: DataValueDatasource,
  };
}
