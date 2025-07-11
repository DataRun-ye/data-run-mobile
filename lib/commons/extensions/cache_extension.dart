import 'dart:async';

import 'package:d_sdk/core/common/standard_extensions.dart';

extension IterableExtension<T> on Map<String, T?> {
  FutureOr<T?> fromCacheOrElseAsync(
      String key, Future<T?> Function() defaultValue) async {
    return this[key] ??
        (await defaultValue.call())?.also((value) => this[key] = value);
  }
}
