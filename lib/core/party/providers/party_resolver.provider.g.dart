// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_resolver.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PartyResolver)
final partyResolverProvider = PartyResolverFamily._();

final class PartyResolverProvider
    extends $AsyncNotifierProvider<PartyResolver, List<Party>> {
  PartyResolverProvider._(
      {required PartyResolverFamily super.from,
      required PartyResolutionParams super.argument})
      : super(
          retry: null,
          name: r'partyResolverProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$partyResolverHash();

  @override
  String toString() {
    return r'partyResolverProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PartyResolver create() => PartyResolver();

  @override
  bool operator ==(Object other) {
    return other is PartyResolverProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$partyResolverHash() => r'bcb3e1624efee10e7c064dafb52c5c8882c5301f';

final class PartyResolverFamily extends $Family
    with
        $ClassFamilyOverride<PartyResolver, AsyncValue<List<Party>>,
            List<Party>, FutureOr<List<Party>>, PartyResolutionParams> {
  PartyResolverFamily._()
      : super(
          retry: null,
          name: r'partyResolverProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PartyResolverProvider call(
    PartyResolutionParams params,
  ) =>
      PartyResolverProvider._(argument: params, from: this);

  @override
  String toString() => r'partyResolverProvider';
}

abstract class _$PartyResolver extends $AsyncNotifier<List<Party>> {
  late final _$args = ref.$arg as PartyResolutionParams;
  PartyResolutionParams get params => _$args;

  FutureOr<List<Party>> build(
    PartyResolutionParams params,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Party>>, List<Party>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Party>>, List<Party>>,
        AsyncValue<List<Party>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
