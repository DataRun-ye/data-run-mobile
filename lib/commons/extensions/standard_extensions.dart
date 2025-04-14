// // extension StandardAsyncExt<T> on Future<T> {
// //   /// Async calls the specified function [block] with `this` value as its argument and returns its result as Future.
// //   Future<R> aaLet<R>(Future<R> Function(T it) block) {
// //     return then((T value) => block(value));
// //   }
// // }
//
// typedef _WhenCheck = bool Function<T>(T value);
//
// extension StandardExt<T> on T {
//   /// Calls the specified function [block] with `this` value as its argument and returns its result.
//   Future<R> aLet<R>(Future<R> Function(T it) block) {
//     return block(this);
//   }
//
//   /// Calls the specified function [block] with `this` value as its argument and returns its result.
//   R let<R>(R Function(T it) block) {
//     return block(this);
//   }
//
//   /// Calls the specified function [block] with `this` value as its argument and returns `this` value.
//   T also(void Function(T it) block) {
//     block(this);
//     return this;
//   }
//
//   /// Returns `this` value if it satisfies the given [predicate] or `null`, if it doesn't.
//   T? takeIf(bool Function(T it) predicate) {
//     if (predicate(this)) {
//       return this;
//     }
//     return null;
//   }
//
//   /// Returns `this` value if it _does not_ satisfy the given [predicate] or `null`, if it does.
//   T? takeUnless(bool Function(T it) predicate) {
//     if (!predicate(this)) return this;
//     return null;
//   }
//
//   /// Calls the specified function [block] with this value as its receiver and returns this value.
//   T apply<R>(R Function(T it) block) {
//     block(this);
//     return this;
//   }
//
//   /// Calls the specified function [block] with this value as its receiver and returns this value.
//   Future<T> aApply<R>(Future<R> Function(T it) block) async {
//     await block(this);
//     return this;
//   }
// }
//
// extension OrElse<T> on T? {
//   T orElse(T Function() branch) {
//     return this ?? branch();
//   }
// }
//
// V? when<T, V>(T value, Map<T, V Function()> branches) {
//   assert(branches.isNotEmpty);
//
//   for (final key in branches.keys) {
//     if ((key == value) ||
//         (key is List && key.contains(value)) ||
//         (key is _WhenCheck && key(value))) {
//       final V Function()? branch = branches[key];
//       if (branch != null) {
//         return branch();
//       }
//     }
//   }
//   return null;
// }
