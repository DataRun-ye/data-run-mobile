// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_display.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(valueDisplay)
final valueDisplayProvider = ValueDisplayFamily._();

final class ValueDisplayProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  ValueDisplayProvider._(
      {required ValueDisplayFamily super.from,
      required ({
        ValueType valueType,
        dynamic value,
      })
          super.argument})
      : super(
          retry: null,
          name: r'valueDisplayProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$valueDisplayHash();

  @override
  String toString() {
    return r'valueDisplayProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    final argument = this.argument as ({
      ValueType valueType,
      dynamic value,
    });
    return valueDisplay(
      ref,
      valueType: argument.valueType,
      value: argument.value,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ValueDisplayProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$valueDisplayHash() => r'337250606bace1c877149a70ffb3984f96cea02f';

final class ValueDisplayFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<String?>,
            ({
              ValueType valueType,
              dynamic value,
            })> {
  ValueDisplayFamily._()
      : super(
          retry: null,
          name: r'valueDisplayProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ValueDisplayProvider call({
    required ValueType valueType,
    dynamic value,
  }) =>
      ValueDisplayProvider._(argument: (
        valueType: valueType,
        value: value,
      ), from: this);

  @override
  String toString() => r'valueDisplayProvider';
}
