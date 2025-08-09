/// Represents a generic pair of two values.
///
/// There is no meaning attached to values in this class, it can be used for any purpose.
/// Pair exhibits value semantics, i.e. two pairs are equal if both components are equal.
///
/// @param A type of the first value.
/// @param B type of the second value.
/// @property first First value.
/// @property second Second value.
// ignore_for_file: strict_raw_type

class Pair<A, B> {
  const Pair(this.first, this.second);

  final A first;
  final B second;

  @override
  String toString() => '($first, $second)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pair &&
          runtimeType == other.runtimeType &&
          first == other.first &&
          second == other.second;

  @override
  int get hashCode => first.hashCode ^ second.hashCode;
}

extension PairDeconstruction<T> on Pair<T, T> {
  /// Converts this pair into a list.
  List<T> toList() => [first, second];
}

/// Represents a tuple of objects.
/// It is useful for implementing a function returning a trio of objects.
class Trio<F, S, T> {
  const Trio(this.first, this.second, this.third);

  Trio.fromJson(List json) : this(json[0] as F, json[1] as S, json[2] as T);
  final F first;
  final S second;
  final T third;

  T get last => third;

  Trio<F, S, T> copyWith({F? first, S? second, T? third}) {
    return Trio<F, S, T>(
        first ?? this.first, second ?? this.second, third ?? this.third);
  }

  List toJson() => [first, second, third];

  @override
  int get hashCode => Object.hash(first, second, third);

  @override
  bool operator ==(Object o) =>
      o is Trio && first == o.first && second == o.second && third == o.third;

  @override
  String toString() => toJson().toString();
}

/// The [repeat] method allows you to easily call a lambda a certain number of
/// times.
///
/// The simplest form of a [repeat] method:
///
/// ```dart
/// repeat(3, (it) => print('Hello $it!'));
/// ```
///
/// This is simply equivalent to a for loop that repeats 3 times
/// (starts at zero, increments by one).
///
/// Much simpler than dealing with iterators for most of scenarios where you
/// don't care about start, end, increment values. If you want more
/// flexibility, check the [range] function.
///
/// It also returns a list of results in case you need it:
///
/// ```dart
/// final evens = repeat(10, (e) => 2 * e);
/// ```
List<T> repeat<T>(int iterations, T Function(int index) lambda) {
  if (iterations == 0) {
    return [];
  }
  return range(0, until: iterations).map(lambda).toList();
}

/// Creates [progression](https://en.wikipedia.org/wiki/Arithmetic_progression)
/// ranges of given type value.
///
/// Generally used in `for` loops:
///
/// ```dart
/// for (var i in range(1, to: 4)) {
///   print(i);
/// }
/// ```
///
/// To iterate in a reverse order, use the [downTo] argument:
///
/// ```dart
/// for (var i in range(4, downTo: 1)) {
///   print(1);
/// }
/// ```
///
/// To iterate with an arbitrary step, use the [step] argument:
///
/// ```dart
/// for (var i in range(1, to: 8, step: 2)) {
///   print(i);
/// }
///
/// for (var i in range(8, downTo: 1, step: 2)) {
///   print(i);
/// }
/// ```
///
/// To iterate a range which does not include the end element, use the [until]
/// argument:
///
/// ```dart
/// for (var i in range(1, until: 10)) {
///   print(i);
/// }
/// ```
List<T> range<T extends num>(T value, {T? to, T? until, T? downTo, T? step}) {
  assert(
    (to != null && until == null && downTo == null) ||
        (to == null && until != null && downTo == null) ||
        (to == null && until == null && downTo != null),
    'Either the `to`, `until` or `downTo` argument is required',
  );
  assert(
    step != null && !step.isNegative || step == null,
    'The `step` should be a positive number',
  );
  assert(
    (to != null && value <= to) ||
        (until != null && value < until) ||
        (downTo != null && value >= downTo),
    'Range out of bound',
  );

  step ??= 1 as T;
  num val = value;
  final list = <T>[];

  if (downTo != null) {
    for (; val >= downTo; val -= step) {
      list.add(val as T);
    }
  } else if (until != null) {
    for (; val < until; val += step) {
      list.add(val as T);
    }
  } else if (to != null) {
    for (; val <= to; val += step) {
      list.add(val as T);
    }
  }

  return list;
}

extension IterableSumBy<E> on Iterable<E> {
  /// Returns the sum of all values produced by [selector] function applied to
  /// each element in the collection.
  T sumBy<T extends num>(T Function(E element) selector) {
    var sum = T == double ? 0.0 : 0;
    for (final current in this) {
      sum += selector(current);
    }
    return sum as T;
  }
}
