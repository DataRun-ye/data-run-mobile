import 'package:d_sdk/datasource/remote_data_sources/remote_data_sources.dart';

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
  static const int dataInstance = 1500;

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
    // option: OptionDatasource,
    dataElement: DataElementDatasource,
    formTemplate: DataFormTemplateDatasource,
    // formVersion: FormVersionDatasource,
    team: TeamDatasource,
    // managedTeam: ManagedTeamDatasource,
    userFormAccess: UserFormAccessesDatasource,
    assignment: AssignmentDatasource,
    dataInstance: DataInstanceDatasource,
    // repeatInstance: RepeatInstanceDatasource,
    dataValue: DataValueDatasource,
    metadataSubmission: MetadataSubmissionDatasource,
  };
}
