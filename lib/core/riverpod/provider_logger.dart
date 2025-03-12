import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';

class ProviderLogger extends ProviderObserver {
  ProviderLogger({required this.providersNameToLog});

  final IList<String> providersNameToLog;

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (providersNameToLog.isEmpty) {
      provider.name != null
          ? logDebug('didAddProvider, NAME: ${provider.name}, VALUE: $value')
          : logDebug(
              'didAddProvider, TYPE: ${provider.runtimeType}, VALUE: $value');
    } else {
      if (providersNameToLog.contains(provider.name)) {
        provider.name != null
            ? logDebug('didAddProvider, VALUE: $value')
            : logDebug(
                'didAddProvider, TYPE: ${provider.runtimeType}, VALUE: $value');
      }
    }
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (providersNameToLog.isEmpty) {
      provider.name != null
          ? logDebug('didUpdateProvider, newValue: $newValue')
          : logDebug(
              'didUpdateProvider, TYPE: ${provider.runtimeType}, newValue: $newValue');
    } else {
      if (providersNameToLog.contains(provider.name)) {
        provider.name != null
            ? logDebug('didUpdateProvider, newValue: $newValue')
            : logDebug(
                'didUpdateProvider, TYPE: ${provider.runtimeType}, newValue: $newValue');
      }
    }
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    if (providersNameToLog.isEmpty) {
      provider.name != null
          ? logDebug('NAME: ${provider.name}, didDisposeProvider')
          : logDebug('TYPE: ${provider.runtimeType}, didDisposeProvider');
    } else {
      if (providersNameToLog.contains(provider.name)) {
        provider.name != null
            ? logDebug('NAME: ${provider.name}, didDisposeProvider')
            : logDebug('TYPE: ${provider.runtimeType}, didDisposeProvider');
      }
    }
  }
}
