// part of 'form_intent_sealed.dart';
//
// sealed class RepeatGroupIntent implements FormIntent {
//   const factory RepeatGroupIntent.addRow(String groupUid) = AddRowIntent;
//
//   const factory RepeatGroupIntent.loadMore(String groupUid) = LoadMoreIntent;
//
//   const factory RepeatGroupIntent.cellEdit(
//       String uid, String? value, ValueType valueType,
//       {required String groupUid, required String rowUid}) = CellEditIntent;
// }
//
// final class AddRowIntent implements RepeatGroupIntent {
//   const AddRowIntent(this.groupUid);
//
//   final String groupUid;
//
//   @override
//   List<Object?> get props => [groupUid];
//
//   @override
//   bool? get stringify => true;
// }
//
// final class LoadMoreIntent implements RepeatGroupIntent {
//   const LoadMoreIntent(this.groupUid);
//
//   final String groupUid;
//
//   @override
//   List<Object?> get props => [groupUid];
//
//   @override
//   bool? get stringify => true;
// }
//
// final class CellEditIntent implements RepeatGroupIntent {
//   const CellEditIntent(
//     this.uid,
//     this.value,
//     this.valueType, {
//     required this.groupUid,
//     required this.rowUid,
//   });
//
//   final String uid;
//   final String? value;
//   final ValueType? valueType;
//   final String groupUid;
//   final String rowUid;
//
//   @override
//   List<Object?> get props => [uid, value, valueType, groupUid, rowUid];
//
//   @override
//   bool? get stringify => true;
// }
