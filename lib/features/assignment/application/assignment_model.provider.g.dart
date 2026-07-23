// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_model.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(assignments)
final assignmentsProvider = AssignmentsFamily._();

final class AssignmentsProvider extends $FunctionalProvider<
        AsyncValue<List<AssignmentModel>>,
        List<AssignmentModel>,
        FutureOr<List<AssignmentModel>>>
    with
        $FutureModifier<List<AssignmentModel>>,
        $FutureProvider<List<AssignmentModel>> {
  AssignmentsProvider._(
      {required AssignmentsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'assignmentsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$assignmentsHash();

  @override
  String toString() {
    return r'assignmentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<AssignmentModel>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<AssignmentModel>> create(Ref ref) {
    final argument = this.argument as String;
    return assignments(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AssignmentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$assignmentsHash() => r'5acf8cf599ddd5c87a51a3c1499a08fd6b9db739';

final class AssignmentsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<AssignmentModel>>, String> {
  AssignmentsFamily._()
      : super(
          retry: null,
          name: r'assignmentsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  AssignmentsProvider call(
    String activityId,
  ) =>
      AssignmentsProvider._(argument: activityId, from: this);

  @override
  String toString() => r'assignmentsProvider';
}
