// ignore_for_file: avoid_dynamic_calls

import 'package:d2_remote/modules/datarun/common/standard_extensions.dart';
import 'package:d2_remote/modules/metadatarun/project/entities/d_project.entity.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:mass_pro/commons/resources/resource_manager.dart';
import 'package:mass_pro/commons/ui/metadata_icon_data.dart';
import 'package:mass_pro/core/common/state.dart';
import 'package:mass_pro/data_run/screens/home_screen/home_deck/home_item.model.dart';
import 'package:mass_pro/data_run/utils/activities_access_repository.dart';
import 'package:mass_pro/main/data/service/sync_status_controller.dart';
import 'package:mass_pro/main/data/service/sync_status_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_items_models_notifier.g.dart';

@riverpod
HomeItemModel homeItemModel(HomeItemModelRef ref) {
  throw UnimplementedError();
}

@riverpod
class HomeItemsModelsNotifier extends _$HomeItemsModelsNotifier {
  @override
  Future<IList<HomeItemModel>> build() async {
    final syncStatusData = ref.watch(syncStatusControllerInstanceProvider
        .select((value) => value.syncStatusData));

    final IList<DProject> projects =
        await ref.watch(activitiesAccessRepositoryProvider).getActiveProjects();

    IList<HomeItemModel> programModels = IList<HomeItemModel>();
    for (final DProject project in projects) {
      final SyncStatus state = SyncStatus.SYNCED;

      final HomeItemModel programModel = HomeItemModel(
          uid: project.uid!,
          title: project.name!,
          metadataIconData: MetadataIconData(
              programColor: ref
                  .read(resourceManagerProvider)
                  .getColorOrDefaultFrom(null),
              iconResource: ref
                  .read(resourceManagerProvider)
                  .getObjectStyleDrawableResource(
                      null,
                      Icons.question_mark)),

          type: project.name,
          dirty: project.dirty,
          state: state,
          downloadState: ProjectDownloadState.NONE);

      programModels = programModels.add(programModel);
    }

    return programModels
        .let((t) => applyFilters(t))
        .let((t) => applySync(t, syncStatusData))
        .sort((p1, p2) =>
            p1.title.toLowerCase().compareTo(p2.title.toLowerCase()));
  }

  IList<HomeItemModel> applyFilters(IList<HomeItemModel> models) {
    return models;
  }

  IList<HomeItemModel> applySync(
      IList<HomeItemModel> models, SyncStatusData syncStatusData) {
    return models;
  }
}
