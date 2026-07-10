// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userAvailableForms)
final userAvailableFormsProvider = UserAvailableFormsFamily._();

final class UserAvailableFormsProvider extends $FunctionalProvider<
        AsyncValue<List<Pair<AssignmentForm, bool>>>,
        List<Pair<AssignmentForm, bool>>,
        FutureOr<List<Pair<AssignmentForm, bool>>>>
    with
        $FutureModifier<List<Pair<AssignmentForm, bool>>>,
        $FutureProvider<List<Pair<AssignmentForm, bool>>> {
  UserAvailableFormsProvider._(
      {required UserAvailableFormsFamily super.from,
      required String? super.argument})
      : super(
          retry: null,
          name: r'userAvailableFormsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userAvailableFormsHash();

  @override
  String toString() {
    return r'userAvailableFormsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Pair<AssignmentForm, bool>>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Pair<AssignmentForm, bool>>> create(Ref ref) {
    final argument = this.argument as String?;
    return userAvailableForms(
      ref,
      assignment: argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UserAvailableFormsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userAvailableFormsHash() =>
    r'b17420bd6ba2b577ab5166c8df786b474e0d1130';

final class UserAvailableFormsFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<List<Pair<AssignmentForm, bool>>>,
            String?> {
  UserAvailableFormsFamily._()
      : super(
          retry: null,
          name: r'userAvailableFormsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  UserAvailableFormsProvider call({
    String? assignment,
  }) =>
      UserAvailableFormsProvider._(argument: assignment, from: this);

  @override
  String toString() => r'userAvailableFormsProvider';
}

@ProviderFor(teams)
final teamsProvider = TeamsFamily._();

final class TeamsProvider extends $FunctionalProvider<
        AsyncValue<List<IdentifiableModel>>,
        List<IdentifiableModel>,
        FutureOr<List<IdentifiableModel>>>
    with
        $FutureModifier<List<IdentifiableModel>>,
        $FutureProvider<List<IdentifiableModel>> {
  TeamsProvider._(
      {required TeamsFamily super.from, required String? super.argument})
      : super(
          retry: null,
          name: r'teamsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$teamsHash();

  @override
  String toString() {
    return r'teamsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<IdentifiableModel>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<IdentifiableModel>> create(Ref ref) {
    final argument = this.argument as String?;
    return teams(
      ref,
      activity: argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TeamsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$teamsHash() => r'17c914c54bb0c42b261af697d8f0a379b72c92a9';

final class TeamsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<IdentifiableModel>>, String?> {
  TeamsFamily._()
      : super(
          retry: null,
          name: r'teamsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  TeamsProvider call({
    String? activity,
  }) =>
      TeamsProvider._(argument: activity, from: this);

  @override
  String toString() => r'teamsProvider';
}

@ProviderFor(managedTeams)
final managedTeamsProvider = ManagedTeamsFamily._();

final class ManagedTeamsProvider extends $FunctionalProvider<
        AsyncValue<List<IdentifiableModel>>,
        List<IdentifiableModel>,
        FutureOr<List<IdentifiableModel>>>
    with
        $FutureModifier<List<IdentifiableModel>>,
        $FutureProvider<List<IdentifiableModel>> {
  ManagedTeamsProvider._(
      {required ManagedTeamsFamily super.from,
      required ({
        String? team,
        String? activity,
        String? assignmentId,
      })
          super.argument})
      : super(
          retry: null,
          name: r'managedTeamsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$managedTeamsHash();

  @override
  String toString() {
    return r'managedTeamsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<IdentifiableModel>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<IdentifiableModel>> create(Ref ref) {
    final argument = this.argument as ({
      String? team,
      String? activity,
      String? assignmentId,
    });
    return managedTeams(
      ref,
      team: argument.team,
      activity: argument.activity,
      assignmentId: argument.assignmentId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ManagedTeamsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$managedTeamsHash() => r'c0a5f287963ee04bfff4bee467ee5a32358cc2e8';

final class ManagedTeamsFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<List<IdentifiableModel>>,
            ({
              String? team,
              String? activity,
              String? assignmentId,
            })> {
  ManagedTeamsFamily._()
      : super(
          retry: null,
          name: r'managedTeamsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ManagedTeamsProvider call({
    String? team,
    String? activity,
    String? assignmentId,
  }) =>
      ManagedTeamsProvider._(argument: (
        team: team,
        activity: activity,
        assignmentId: assignmentId,
      ), from: this);

  @override
  String toString() => r'managedTeamsProvider';
}
