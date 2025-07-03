import 'package:d_sdk/database/database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StageFormContent extends ConsumerWidget {
  StageFormContent({super.key, required this.assignment, required this.stage});

  final Assignment assignment;
  final StageDefinition stage;

  @override
  Widget build(_, ref) {
    final submissions = ref.watch(submissionsProvider(assignment.id, stage.id));
    final hasEntity = stage.entityBoundEntityTypeId != null;
    return Column(
      children: [
        // 1. Show existing submissions or entity instances
        if (stage.repeatable)
          Expanded(
            child: ListView(
              children: [
                if (hasEntity)
                  ...ref
                      .watch(entitiesProvider(assignment.id, stage.id))
                      .map((e) => EntityCard(entity: e))
                else
                  ...submissions.map((s) => SubmissionCard(submission: s)),
                AddButton(onPressed: () {
                  ref.read(vmProvider).startNew(stage.id);
                }),
              ],
            ),
          )
        else if (submissions.isNotEmpty)
          SubmissionCard(submission: submissions.first)
        else
          DynamicForm(
            // fall-through when no submissions yet
            template: stage.formTemplate,
            initialData: {},
            onSave: (data) => ref.read(vmProvider).save(stage.id, data),
          ),

        // 2. New / Edit form
        if (ref.watch(vmProvider).isEditing(stage.id))
          DynamicForm(
            template: stage.formTemplate,
            initialData: ref.watch(vmProvider).draft(stage.id),
            onSave: (data) => ref.read(vmProvider).save(stage.id, data),
            onCancel: () => ref.read(vmProvider).cancel(stage.id),
          ),
      ],
    );
  }
}
