// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_display.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$valueDisplayHash() => r'337250606bace1c877149a70ffb3984f96cea02f';

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

/// See also [valueDisplay].
@ProviderFor(valueDisplay)
const valueDisplayProvider = ValueDisplayFamily();

/// See also [valueDisplay].
class ValueDisplayFamily extends Family<AsyncValue<String?>> {
  /// See also [valueDisplay].
  const ValueDisplayFamily();

  /// See also [valueDisplay].
  ValueDisplayProvider call({
    required ValueType valueType,
    dynamic value,
  }) {
    return ValueDisplayProvider(
      valueType: valueType,
      value: value,
    );
  }

  @override
  ValueDisplayProvider getProviderOverride(
    covariant ValueDisplayProvider provider,
  ) {
    return call(
      valueType: provider.valueType,
      value: provider.value,
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
  String? get name => r'valueDisplayProvider';
}

/// See also [valueDisplay].
class ValueDisplayProvider extends AutoDisposeFutureProvider<String?> {
  /// See also [valueDisplay].
  ValueDisplayProvider({
    required ValueType valueType,
    dynamic value,
  }) : this._internal(
          (ref) => valueDisplay(
            ref as ValueDisplayRef,
            valueType: valueType,
            value: value,
          ),
          from: valueDisplayProvider,
          name: r'valueDisplayProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$valueDisplayHash,
          dependencies: ValueDisplayFamily._dependencies,
          allTransitiveDependencies:
              ValueDisplayFamily._allTransitiveDependencies,
          valueType: valueType,
          value: value,
        );

  ValueDisplayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.valueType,
    required this.value,
  }) : super.internal();

  final ValueType valueType;
  final dynamic value;

  @override
  Override overrideWith(
    FutureOr<String?> Function(ValueDisplayRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ValueDisplayProvider._internal(
        (ref) => create(ref as ValueDisplayRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        valueType: valueType,
        value: value,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _ValueDisplayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ValueDisplayProvider &&
        other.valueType == valueType &&
        other.value == value;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, valueType.hashCode);
    hash = _SystemHash.combine(hash, value.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ValueDisplayRef on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `valueType` of this provider.
  ValueType get valueType;

  /// The parameter `value` of this provider.
  dynamic get value;
}

class _ValueDisplayProviderElement
    extends AutoDisposeFutureProviderElement<String?> with ValueDisplayRef {
  _ValueDisplayProviderElement(super.provider);

  @override
  ValueType get valueType => (origin as ValueDisplayProvider).valueType;
  @override
  dynamic get value => (origin as ValueDisplayProvider).value;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
