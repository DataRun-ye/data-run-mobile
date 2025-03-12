// import 'package:d2_remote/core/common/value_type/validators/value_type_validator.dart';
// import 'package:d2_remote/core/mp/helpers/result.dart';
// import 'package:datarunmobile/core/form/ui/validation/failures/field_mask_failure.data.dart';
// import 'package:datarunmobile/sdk/core/mp/helpers/result.dart';
// import 'package:mass_pro/form/ui/validation/failures/field_mask_failure.data.dart';
//
// class FieldMaskValidator extends ValueTypeValidator<FieldMaskFailure> {
//   String? fieldMask;
//
//   FieldMaskValidator(this.fieldMask);
//
//   String? get formattedFieldMask => null; //fieldMask?.removeSurrounding("\'")
//
//   Result<String?, FieldMaskFailure> validateNullSafe(String? value) {
//     return value != null ? validate(value) : Result.success(value);
//   }
//
//   @override
//   Result<String, FieldMaskFailure> validate(String value) {
//     return Result.success(value);
//     // implement later
//     // if (formattedFieldMask?.isNullOrEmpty() == true || value.isEmpty) {
//     //   return right(value);
//     // } else if (value == '1') {
//     //       return left(const BooleanFailure.oneIsNotTrueException());
//     //     } else if (value == 'true' || value == 'false') {
//     //       return right(value);
//     //     } else {
//     //       return left(const BooleanFailure.booleanMalformedException());
//     //     }
//   }
// }
