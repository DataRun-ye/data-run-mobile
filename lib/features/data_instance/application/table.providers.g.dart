// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$totalItemsStreamHash() => r'3af0341bc7c0495859ed213d12ed353aa8c1c0bb';

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

/// See also [totalItemsStream].
@ProviderFor(totalItemsStream)
const totalItemsStreamProvider = TotalItemsStreamFamily();

/// See also [totalItemsStream].
class TotalItemsStreamFamily extends Family<AsyncValue<int>> {
  /// See also [totalItemsStream].
  const TotalItemsStreamFamily();

  /// See also [totalItemsStream].
  TotalItemsStreamProvider call({
    required SubmissionsFilter templateFilter,
  }) {
    return TotalItemsStreamProvider(
      templateFilter: templateFilter,
    );
  }

  @override
  TotalItemsStreamProvider getProviderOverride(
    covariant TotalItemsStreamProvider provider,
  ) {
    return call(
      templateFilter: provider.templateFilter,
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
  String? get name => r'totalItemsStreamProvider';
}

/// See also [totalItemsStream].
class TotalItemsStreamProvider extends AutoDisposeStreamProvider<int> {
  /// See also [totalItemsStream].
  TotalItemsStreamProvider({
    required SubmissionsFilter templateFilter,
  }) : this._internal(
          (ref) => totalItemsStream(
            ref as TotalItemsStreamRef,
            templateFilter: templateFilter,
          ),
          from: totalItemsStreamProvider,
          name: r'totalItemsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$totalItemsStreamHash,
          dependencies: TotalItemsStreamFamily._dependencies,
          allTransitiveDependencies:
              TotalItemsStreamFamily._allTransitiveDependencies,
          templateFilter: templateFilter,
        );

  TotalItemsStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.templateFilter,
  }) : super.internal();

  final SubmissionsFilter templateFilter;

  @override
  Override overrideWith(
    Stream<int> Function(TotalItemsStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TotalItemsStreamProvider._internal(
        (ref) => create(ref as TotalItemsStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        templateFilter: templateFilter,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<int> createElement() {
    return _TotalItemsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TotalItemsStreamProvider &&
        other.templateFilter == templateFilter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, templateFilter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TotalItemsStreamRef on AutoDisposeStreamProviderRef<int> {
  /// The parameter `templateFilter` of this provider.
  SubmissionsFilter get templateFilter;
}

class _TotalItemsStreamProviderElement
    extends AutoDisposeStreamProviderElement<int> with TotalItemsStreamRef {
  _TotalItemsStreamProviderElement(super.provider);

  @override
  SubmissionsFilter get templateFilter =>
      (origin as TotalItemsStreamProvider).templateFilter;
}

String _$totalItemsHash() => r'3bf366f0ea1818df1c69eae456c65cd00cb80add';

/// See also [totalItems].
@ProviderFor(totalItems)
const totalItemsProvider = TotalItemsFamily();

/// See also [totalItems].
class TotalItemsFamily extends Family<AsyncValue<int>> {
  /// See also [totalItems].
  const TotalItemsFamily();

  /// See also [totalItems].
  TotalItemsProvider call({
    required SubmissionsFilter templateFilter,
  }) {
    return TotalItemsProvider(
      templateFilter: templateFilter,
    );
  }

  @override
  TotalItemsProvider getProviderOverride(
    covariant TotalItemsProvider provider,
  ) {
    return call(
      templateFilter: provider.templateFilter,
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
  String? get name => r'totalItemsProvider';
}

/// See also [totalItems].
class TotalItemsProvider extends AutoDisposeFutureProvider<int> {
  /// See also [totalItems].
  TotalItemsProvider({
    required SubmissionsFilter templateFilter,
  }) : this._internal(
          (ref) => totalItems(
            ref as TotalItemsRef,
            templateFilter: templateFilter,
          ),
          from: totalItemsProvider,
          name: r'totalItemsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$totalItemsHash,
          dependencies: TotalItemsFamily._dependencies,
          allTransitiveDependencies:
              TotalItemsFamily._allTransitiveDependencies,
          templateFilter: templateFilter,
        );

  TotalItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.templateFilter,
  }) : super.internal();

  final SubmissionsFilter templateFilter;

  @override
  Override overrideWith(
    FutureOr<int> Function(TotalItemsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TotalItemsProvider._internal(
        (ref) => create(ref as TotalItemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        templateFilter: templateFilter,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _TotalItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TotalItemsProvider &&
        other.templateFilter == templateFilter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, templateFilter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TotalItemsRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `templateFilter` of this provider.
  SubmissionsFilter get templateFilter;
}

class _TotalItemsProviderElement extends AutoDisposeFutureProviderElement<int>
    with TotalItemsRef {
  _TotalItemsProviderElement(super.provider);

  @override
  SubmissionsFilter get templateFilter =>
      (origin as TotalItemsProvider).templateFilter;
}

String _$selectedFinalizedItemHash() =>
    r'351b2c427818867cd0e6edd2a87de565ee4ce0ad';

/// See also [selectedFinalizedItem].
@ProviderFor(selectedFinalizedItem)
final selectedFinalizedItemProvider =
    AutoDisposeFutureProvider<ISet<String>>.internal(
  selectedFinalizedItem,
  name: r'selectedFinalizedItemProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedFinalizedItemHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SelectedFinalizedItemRef = AutoDisposeFutureProviderRef<ISet<String>>;
String _$dataInstanceFilterHash() =>
    r'091d5bb718eadfe76b6933abd7b1fca6c21c5d8e';

abstract class _$DataInstanceFilter
    extends BuildlessAutoDisposeNotifier<SubmissionsFilter> {
  late final String formId;
  late final String? assignmentId;

  SubmissionsFilter build({
    required String formId,
    String? assignmentId,
  });
}

/// See also [DataInstanceFilter].
@ProviderFor(DataInstanceFilter)
const dataInstanceFilterProvider = DataInstanceFilterFamily();

/// See also [DataInstanceFilter].
class DataInstanceFilterFamily extends Family<SubmissionsFilter> {
  /// See also [DataInstanceFilter].
  const DataInstanceFilterFamily();

  /// See also [DataInstanceFilter].
  DataInstanceFilterProvider call({
    required String formId,
    String? assignmentId,
  }) {
    return DataInstanceFilterProvider(
      formId: formId,
      assignmentId: assignmentId,
    );
  }

  @override
  DataInstanceFilterProvider getProviderOverride(
    covariant DataInstanceFilterProvider provider,
  ) {
    return call(
      formId: provider.formId,
      assignmentId: provider.assignmentId,
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
  String? get name => r'dataInstanceFilterProvider';
}

/// See also [DataInstanceFilter].
class DataInstanceFilterProvider extends AutoDisposeNotifierProviderImpl<
    DataInstanceFilter, SubmissionsFilter> {
  /// See also [DataInstanceFilter].
  DataInstanceFilterProvider({
    required String formId,
    String? assignmentId,
  }) : this._internal(
          () => DataInstanceFilter()
            ..formId = formId
            ..assignmentId = assignmentId,
          from: dataInstanceFilterProvider,
          name: r'dataInstanceFilterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dataInstanceFilterHash,
          dependencies: DataInstanceFilterFamily._dependencies,
          allTransitiveDependencies:
              DataInstanceFilterFamily._allTransitiveDependencies,
          formId: formId,
          assignmentId: assignmentId,
        );

  DataInstanceFilterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.formId,
    required this.assignmentId,
  }) : super.internal();

  final String formId;
  final String? assignmentId;

  @override
  SubmissionsFilter runNotifierBuild(
    covariant DataInstanceFilter notifier,
  ) {
    return notifier.build(
      formId: formId,
      assignmentId: assignmentId,
    );
  }

  @override
  Override overrideWith(DataInstanceFilter Function() create) {
    return ProviderOverride(
      origin: this,
      override: DataInstanceFilterProvider._internal(
        () => create()
          ..formId = formId
          ..assignmentId = assignmentId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        formId: formId,
        assignmentId: assignmentId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<DataInstanceFilter, SubmissionsFilter>
      createElement() {
    return _DataInstanceFilterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DataInstanceFilterProvider &&
        other.formId == formId &&
        other.assignmentId == assignmentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, formId.hashCode);
    hash = _SystemHash.combine(hash, assignmentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DataInstanceFilterRef
    on AutoDisposeNotifierProviderRef<SubmissionsFilter> {
  /// The parameter `formId` of this provider.
  String get formId;

  /// The parameter `assignmentId` of this provider.
  String? get assignmentId;
}

class _DataInstanceFilterProviderElement
    extends AutoDisposeNotifierProviderElement<DataInstanceFilter,
        SubmissionsFilter> with DataInstanceFilterRef {
  _DataInstanceFilterProviderElement(super.provider);

  @override
  String get formId => (origin as DataInstanceFilterProvider).formId;
  @override
  String? get assignmentId =>
      (origin as DataInstanceFilterProvider).assignmentId;
}

String _$tablePaginationHash() => r'2147240643591eed88d3d8eef8cbd5b2d683417d';

/// See also [TablePagination].
@ProviderFor(TablePagination)
final tablePaginationProvider =
    AutoDisposeNotifierProvider<TablePagination, Pagination>.internal(
  TablePagination.new,
  name: r'tablePaginationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tablePaginationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TablePagination = AutoDisposeNotifier<Pagination>;
String _$selectedItemsHash() => r'c160887e2af4eb7f57ca168ce4018b32cd3bbc0a';

/// See also [SelectedItems].
@ProviderFor(SelectedItems)
final selectedItemsProvider =
    AutoDisposeNotifierProvider<SelectedItems, ISet<String>>.internal(
  SelectedItems.new,
  name: r'selectedItemsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedItems = AutoDisposeNotifier<ISet<String>>;
String _$tableAppearanceControllerHash() =>
    r'95057ae626c649fa928b138bf0bc6569b4069238';

/// See also [TableAppearanceController].
@ProviderFor(TableAppearanceController)
final tableAppearanceControllerProvider = AutoDisposeNotifierProvider<
    TableAppearanceController, TableAppearance>.internal(
  TableAppearanceController.new,
  name: r'tableAppearanceControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tableAppearanceControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TableAppearanceController = AutoDisposeNotifier<TableAppearance>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
