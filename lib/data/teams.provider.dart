import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_template.entity.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/team_form_permission.dart';
import 'package:d2_remote/modules/metadatarun/teams/entities/d_team.entity.dart';
import 'package:datarunmobile/commons/helpers/collections.dart';
import 'package:datarunmobile/data_run/d_team/team_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'teams.provider.g.dart';

@riverpod
Future<List<Pair<TeamFormPermission, bool>>> userAvailableForms(
    UserAvailableFormsRef ref) async {
  final List<Team> assignedTeams = await D2Remote.teamModuleD.team
      .where(attribute: 'scope', value: 'Assigned')
      .where(attribute: 'disabled', value: false)
      .get();

  final assignedForms = assignedTeams.expand((t) => t.formPermissions).toList();

  final List<FormTemplate> availableFormTemplates = await D2Remote
      .formModule.formTemplate
      .byIds(assignedForms.map((f) => f.form).toList())
      .get();

  final List<String> availableForms =
      availableFormTemplates.map((f) => f.id!).toList();

  final availableAssignedForms = assignedTeams
      .expand((t) => t.formPermissions)
      .map((fp) => Pair(fp, availableForms.contains(fp.form)))
      .toList();

  return availableAssignedForms;
}

@riverpod
class Teams extends _$Teams {
  @override
  Future<IList<TeamModel>> build(EntityScope scope) async {
    final List<Team> teams = await D2Remote.teamModuleD.team
        .where(attribute: 'scope', value: scope.name)
        .get();

    final List<Pair<TeamFormPermission, bool>> availableForms =
        await ref.watch(userAvailableFormsProvider.future);

    return teams
        .where((t) => !t.disabled)
        .map((t) => TeamModel.fromIdentifiable(
            identifiableEntity: t,
            activity: t.activity,
            formPermissions:
                availableForms.where((fp) => fp.first.team == t.id)))
        .toList()
        .lock;
  }
}
