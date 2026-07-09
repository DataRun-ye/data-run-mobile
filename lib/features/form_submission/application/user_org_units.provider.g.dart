// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_org_units.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userOrgUnits)
final userOrgUnitsProvider = UserOrgUnitsFamily._();

final class UserOrgUnitsProvider extends $FunctionalProvider<
        AsyncValue<List<OrgUnit>>, List<OrgUnit>, FutureOr<List<OrgUnit>>>
    with $FutureModifier<List<OrgUnit>>, $FutureProvider<List<OrgUnit>> {
  UserOrgUnitsProvider._(
      {required UserOrgUnitsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'userOrgUnitsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userOrgUnitsHash();

  @override
  String toString() {
    return r'userOrgUnitsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<OrgUnit>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<OrgUnit>> create(Ref ref) {
    final argument = this.argument as String;
    return userOrgUnits(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UserOrgUnitsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userOrgUnitsHash() => r'39b0ac422f70e9e4a12356b7b1beaff1fb369951';

final class UserOrgUnitsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<OrgUnit>>, String> {
  UserOrgUnitsFamily._()
      : super(
          retry: null,
          name: r'userOrgUnitsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  UserOrgUnitsProvider call(
    String activity,
  ) =>
      UserOrgUnitsProvider._(argument: activity, from: this);

  @override
  String toString() => r'userOrgUnitsProvider';
}
