// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_model.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(assignmentForms)
final assignmentFormsProvider = AssignmentFormsProvider._();

final class AssignmentFormsProvider extends $FunctionalProvider<
        AsyncValue<List<FormTemplateVersion>>,
        List<FormTemplateVersion>,
        FutureOr<List<FormTemplateVersion>>>
    with
        $FutureModifier<List<FormTemplateVersion>>,
        $FutureProvider<List<FormTemplateVersion>> {
  AssignmentFormsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'assignmentFormsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$assignmentFormsHash();

  @$internal
  @override
  $FutureProviderElement<List<FormTemplateVersion>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<FormTemplateVersion>> create(Ref ref) {
    return assignmentForms(ref);
  }
}

String _$assignmentFormsHash() => r'0db9b00b9fa016279fed2fd45346e9283e0b7552';

@ProviderFor(assignment)
final assignmentProvider = AssignmentProvider._();

final class AssignmentProvider extends $FunctionalProvider<AssignmentModel,
    AssignmentModel, AssignmentModel> with $Provider<AssignmentModel> {
  AssignmentProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'assignmentProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$assignmentHash();

  @$internal
  @override
  $ProviderElement<AssignmentModel> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AssignmentModel create(Ref ref) {
    return assignment(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssignmentModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssignmentModel>(value),
    );
  }
}

String _$assignmentHash() => r'02f87ffeee92adc173256978cece63f9257656aa';

/// a notifier that retrieves all assignments with their data populated

@ProviderFor(Assignments)
final assignmentsProvider = AssignmentsProvider._();

/// a notifier that retrieves all assignments with their data populated
final class AssignmentsProvider
    extends $AsyncNotifierProvider<Assignments, List<AssignmentModel>> {
  /// a notifier that retrieves all assignments with their data populated
  AssignmentsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'assignmentsProvider',
          isAutoDispose: true,
          dependencies: <ProviderOrFamily>[activityModelProvider],
          $allTransitiveDependencies: <ProviderOrFamily>[
            AssignmentsProvider.$allTransitiveDependencies0,
          ],
        );

  static final $allTransitiveDependencies0 = activityModelProvider;

  @override
  String debugGetCreateSourceHash() => _$assignmentsHash();

  @$internal
  @override
  Assignments create() => Assignments();
}

String _$assignmentsHash() => r'8f6a661ab7b4eb384921ccd19ec63aac62fc41f0';

/// a notifier that retrieves all assignments with their data populated

abstract class _$Assignments extends $AsyncNotifier<List<AssignmentModel>> {
  FutureOr<List<AssignmentModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<List<AssignmentModel>>, List<AssignmentModel>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<AssignmentModel>>, List<AssignmentModel>>,
        AsyncValue<List<AssignmentModel>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
