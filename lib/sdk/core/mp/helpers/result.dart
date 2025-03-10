/// This abstraction contains either a success data of generic type `S` or a
/// failure error of type `Exception` as its result.
///
/// `data` property must only be retrieved when `DataResult` was constructed by
/// using `DataResult.success(value)`. It can be validated by calling
/// `isSuccess` first. Alternatively, `dataOrElse` can be used instead since it
/// ensures a valid value is returned in case the result is a failure.
///
/// `error` must only be retrieved when `DataResult` was constructed by using
/// `DataResult.failure(error)`. It can be validated by calling `isFailure`
/// first.
abstract class Result<S, E> {
  static Result<S, E> failure<S, E>(E failure) => _FailureResult(failure);

  static Result<S, E> success<S, E>(S data) => _SuccessResult(data);

  /// Get [error] value, returns null when the value is actually [data]
  E? get error => fold<E?>((error) => error, (data) => null);

  /// Get [data] value, returns null when the value is actually [error]
  S? get data => fold<S?>((error) => null, (data) => data);

  /// Returns `true` if the object is of the `SuccessResult` type, which means
  /// `data` will return a valid result.
  bool get isSuccess => this is _SuccessResult<S, E>;

  /// Returns `true` if the object is of the `FailureResult` type, which means
  /// `error` will return a valid result.
  bool get isFailure => this is _FailureResult<S, E>;

  /// Returns `data` if `isSuccess` returns `true`, otherwise it returns
  /// `other`.
  S dataOrElse(S other) => isSuccess && data != null ? data! : other;

  /// Sugar syntax that calls `dataOrElse` under the hood. Returns left value if
  /// `isSuccess` returns `true`, otherwise it returns the right value.
  S operator |(S other) => dataOrElse(other);

  /// Transforms values of [error] and [data] in new a `DataResult` type. Only
  /// the matching function to the object type will be executed. For example,
  /// for a `SuccessResult` object only the [fnData] function will be executed.
  Result<T, E> either<T>(
      E Function(E error) fnFailure, T Function(S data) fnData);

  /// Transforms value of [data] allowing a new `DataResult` to be returned.
  /// A `SuccessResult` might return a `FailureResult` and vice versa.
  Result<T, E> then<T>(Result<T, E> Function(S data) fnData);

  /// Transforms value of [data] always keeping the original identity of the
  /// `DataResult`, meaning that a `SuccessResult` returns a `SuccessResult` and
  /// a `FailureResult` always returns a `FailureResult`.
  Result<T, E> map<T>(T Function(S data) fnData);

  /// Folds [error] and [data] into the value of one type. Only the matching
  /// function to the object type will be executed. For example, for a
  /// `SuccessResult` object only the [fnData] function will be executed.
  T fold<T>(T Function(E error) fnFailure, T Function(S data) fnData);

  @override
  bool operator ==(Object other) {
    if (other is! Result && runtimeType != other.runtimeType) return false;
    other as Result;
    if (isSuccess) {
      if (data == other.data) return true;
    } else {
      if (error == other.error) return true;
    }
    return false;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[
        runtimeType,
        if (isSuccess) data else error,
      ]);
}

/// Success implementation of `DataResult`. It contains `data`. It's abstracted
/// away by `DataResult`. It shouldn't be used directly in the app.
class _SuccessResult<S, E> extends Result<S, E> {
  _SuccessResult(this._value);
  final S _value;

  @override
  _SuccessResult<T, E> either<T>(
      E Function(E error) fnFailure, T Function(S data) fnData) {
    return _SuccessResult<T, E>(fnData(_value));
  }

  @override
  Result<T, E> then<T>(Result<T, E> Function(S data) fnData) {
    return fnData(_value);
  }

  @override
  _SuccessResult<T, E> map<T>(T Function(S data) fnData) {
    return _SuccessResult<T, E>(fnData(_value));
  }

  @override
  T fold<T>(T Function(E error) fnFailure, T Function(S data) fnData) {
    return fnData(_value);
  }
}

/// Exception implementation of `DataResult`. It contains `error`.  It's
/// abstracted away by `DataResult`. It shouldn't be used directly in the app.
class _FailureResult<S, E> extends Result<S, E> {
  _FailureResult(this._value);
  final E _value;

  @override
  _FailureResult<T, E> either<T>(
      E Function(E error) fnFailure, T Function(S data) fnData) {
    return _FailureResult<T, E>(fnFailure(_value));
  }

  @override
  _FailureResult<T, E> map<T>(T Function(S data) fnData) {
    return _FailureResult<T, E>(_value);
  }

  @override
  _FailureResult<T, E> then<T>(Result<T, E> Function(S data) fnData) {
    return _FailureResult<T, E>(_value);
  }

  @override
  T fold<T>(T Function(E error) fnFailure, T Function(S data) fnData) {
    return fnFailure(_value);
  }
}
