// abstract class IdentifiableModel {
//   String? get id;
//
//   String? get code;
//
//   String? get name;
//
//   String? get displayName;
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is IdentifiableModel &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           code == other.code &&
//           name == other.name &&
//           displayName == other.displayName);
//
//   @override
//   int get hashCode =>
//       id.hashCode ^
//       code.hashCode ^
//       name.hashCode ^
//       displayName.hashCode;
//
//   @override
//   String toString() {
//     return 'IdentifiableModel{' +
//         ' id: $id,' +
//         ' code: $code,' +
//         ' name: $name,' +
//         ' displayName: $displayName,' +
//         '}';
//   }
// }
