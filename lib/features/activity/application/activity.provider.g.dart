// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activityModel)
final activityModelProvider = ActivityModelProvider._();

final class ActivityModelProvider
    extends $FunctionalProvider<ActivityModel, ActivityModel, ActivityModel>
    with $Provider<ActivityModel> {
  ActivityModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'activityModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$activityModelHash();

  @$internal
  @override
  $ProviderElement<ActivityModel> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ActivityModel create(Ref ref) {
    return activityModel(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActivityModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActivityModel>(value),
    );
  }
}

String _$activityModelHash() => r'928a4945ee10951d3a3e28af8119fd2287ea3f76';
