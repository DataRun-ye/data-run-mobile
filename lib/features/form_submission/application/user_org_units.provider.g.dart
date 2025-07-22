// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_org_units.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userOrgUnitsHash() => r'39b0ac422f70e9e4a12356b7b1beaff1fb369951';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [userOrgUnits].
@ProviderFor(userOrgUnits)
const userOrgUnitsProvider = UserOrgUnitsFamily();

/// See also [userOrgUnits].
class UserOrgUnitsFamily extends Family<AsyncValue<List<OrgUnit>>> {
  /// See also [userOrgUnits].
  const UserOrgUnitsFamily();

  /// See also [userOrgUnits].
  UserOrgUnitsProvider call(
    String activity,
  ) {
    return UserOrgUnitsProvider(
      activity,
    );
  }

  @override
  UserOrgUnitsProvider getProviderOverride(
    covariant UserOrgUnitsProvider provider,
  ) {
    return call(
      provider.activity,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userOrgUnitsProvider';
}

/// See also [userOrgUnits].
class UserOrgUnitsProvider extends AutoDisposeFutureProvider<List<OrgUnit>> {
  /// See also [userOrgUnits].
  UserOrgUnitsProvider(
    String activity,
  ) : this._internal(
          (ref) => userOrgUnits(
            ref as UserOrgUnitsRef,
            activity,
          ),
          from: userOrgUnitsProvider,
          name: r'userOrgUnitsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userOrgUnitsHash,
          dependencies: UserOrgUnitsFamily._dependencies,
          allTransitiveDependencies:
              UserOrgUnitsFamily._allTransitiveDependencies,
          activity: activity,
        );

  UserOrgUnitsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.activity,
  }) : super.internal();

  final String activity;

  @override
  Override overrideWith(
    FutureOr<List<OrgUnit>> Function(UserOrgUnitsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserOrgUnitsProvider._internal(
        (ref) => create(ref as UserOrgUnitsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        activity: activity,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<OrgUnit>> createElement() {
    return _UserOrgUnitsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserOrgUnitsProvider && other.activity == activity;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, activity.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserOrgUnitsRef on AutoDisposeFutureProviderRef<List<OrgUnit>> {
  /// The parameter `activity` of this provider.
  String get activity;
}

class _UserOrgUnitsProviderElement
    extends AutoDisposeFutureProviderElement<List<OrgUnit>>
    with UserOrgUnitsRef {
  _UserOrgUnitsProviderElement(super.provider);

  @override
  String get activity => (origin as UserOrgUnitsProvider).activity;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
