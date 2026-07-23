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
        AsyncValue<List<AssignmentFormAvailability>>,
        List<AssignmentFormAvailability>,
        FutureOr<List<AssignmentFormAvailability>>>
    with
        $FutureModifier<List<AssignmentFormAvailability>>,
        $FutureProvider<List<AssignmentFormAvailability>> {
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
  $FutureProviderElement<List<AssignmentFormAvailability>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<AssignmentFormAvailability>> create(Ref ref) {
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
    r'a60cba80c669bccc59872fe4f6ce25c58ea94687';

final class UserAvailableFormsFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<List<AssignmentFormAvailability>>,
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

String _$teamsHash() => r'4f766aa3309d639e6549298296445b59a6a2c6c8';

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
      {required ManagedTeamsFamily super.from, required String? super.argument})
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
    return managedTeams(
      ref,
      assignmentId: argument,
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

String _$managedTeamsHash() => r'fc9bdec4792a463974da21bc21f9314699381679';

final class ManagedTeamsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<IdentifiableModel>>, String?> {
  ManagedTeamsFamily._()
      : super(
          retry: null,
          name: r'managedTeamsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ManagedTeamsProvider call({
    String? assignmentId,
  }) =>
      ManagedTeamsProvider._(argument: assignmentId, from: this);

  @override
  String toString() => r'managedTeamsProvider';
}
