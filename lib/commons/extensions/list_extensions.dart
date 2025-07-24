// // ignore_for_file: strict_raw_type, unused_element
// typedef Condition = bool Function();
//
// extension IterableMinBy<E> on Iterable<E> {
//   /// Returns the first element yielding the smallest value of the given
//   /// [selector] or `null` if there are no elements.
//   E? minBy(Comparable Function(E element) selector) => _minMaxBy(-1, selector);
//
//   /// Returns the first element yielding the smallest value of the given
//   /// [selector] or `null` if there are no elements.
//   E? maxBy(Comparable Function(E element) selector) => _minMaxBy(-1, selector);
// }
//
// extension IterableMinWith<E> on Iterable<E> {
//   /// Returns the first element having the smallest value according to the
//   /// provided [comparator] or `null` if there are no elements.
//   E? minWith(Comparator<E> comparator) => _minMaxWith(-1, comparator);
// }
//
// extension _MinMaxHelper<E> on Iterable<E> {
//   E? _minMax(int order) {
//     final Iterator<E> it = iterator;
//     if (!it.moveNext()) {
//       return null;
//     }
//     var currentMin = it.current;
//
//     if (order < 0) {
//       while (it.moveNext()) {
//         if ((it.current as Comparable).compareTo(currentMin) <= order) {
//           currentMin = it.current;
//         }
//       }
//     } else {
//       while (it.moveNext()) {
//         if ((it.current as Comparable).compareTo(currentMin) >= order) {
//           currentMin = it.current;
//         }
//       }
//     }
//
//     return currentMin;
//   }
//
//   E? _minMaxBy(int order, Comparable Function(E element) selector) {
//     final Iterator it = iterator;
//     if (!it.moveNext()) {
//       return null;
//     }
//
//     var currentMin = it.current;
//     Comparable currentMinValue = selector(it.current);
//     while (it.moveNext()) {
//       final Comparable comp = selector(it.current);
//       if (comp.compareTo(currentMinValue) == order) {
//         currentMin = it.current;
//         currentMinValue = comp;
//       }
//     }
//
//     return currentMin;
//   }
//
//   E? _minMaxWith(int order, Comparator<E> comparator) {
//     final Iterator it = iterator;
//     if (!it.moveNext()) {
//       return null;
//     }
//     var currentMin = it.current;
//
//     while (it.moveNext()) {
//       if (comparator(it.current, currentMin) == order) {
//         currentMin = it.current;
//       }
//     }
//
//     return currentMin;
//   }
// }
//
// extension NullOrEmpty<T> on List<T>? {
//   bool get isNullOrEmpty => this?.isEmpty ?? true;
// }
//
// extension IterableFirstOrNullWhere<E> on Iterable<E> {
//   /// Returns the first element matching the given [predicate], or `null` if no
//   /// such element was found.
//   ///
//   /// ```dart
//   /// final list = ['a', 'Test'];
//   /// final firstLong= list.firstOrNullWhere((e) => e.length > 1); // 'Test'
//   /// final firstVeryLong = list.firstOrNullWhere((e) => e.length > 5); // null
//   /// ```
//   E? firstOrNullWhere(bool Function(E element) predicate) {
//     for (final element in this) {
//       if (predicate(element)) return element;
//     }
//     return null;
//   }
// }
//
// extension ListExtension<E> on List<E> {
//   /// Add [item] to [List<E>] only if [item] is not null.
//   void addNonNull(E item) {
//     if (item != null) add(item);
//   }
//
//   /// Add [item] to List<E> only if [condition] is true.
//   void addIf(dynamic condition, E item) {
//     if (condition is Condition) condition = condition();
//     if (condition is bool && condition) add(item);
//   }
//
//   /// Adds [Iterable<E>] to [List<E>] only if [condition] is true.
//   void addAllIf(dynamic condition, Iterable<E> items) {
//     if (condition is Condition) condition = condition();
//     if (condition is bool && condition) addAll(items);
//   }
//
//   /// Replaces all existing items of this list with [item]
//   void assign(E item) {
//     clear();
//     add(item);
//   }
//
//   /// Replaces all existing items of this list with [items]
//   void assignAll(Iterable<E> items) {
//     clear();
//     addAll(items);
//   }
// }
