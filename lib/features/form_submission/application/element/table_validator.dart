import 'package:reactive_forms/reactive_forms.dart';

class MaxRowsValidator extends Validator<dynamic> {
  MaxRowsValidator({
    required this.maxRows,
  }) : super();
  final int maxRows;

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final formArray = control as FormArray;
    final error = {
      ValidationMessage.min: <String, dynamic>{
        'max': maxRows,
        'actual': formArray.controls.length,
      },
    };
    if (formArray.controls.length > maxRows) {
      formArray.setErrors({'maxRows': error});

      // force messages to show up as soon as possible
      formArray.markAsTouched();
    } else {
      formArray.removeError('maxRows');
    }

    return null;
  }
}

class MinRowsValidator extends Validator<dynamic> {
  MinRowsValidator({
    required this.maxRows,
    required this.minRows,
  }) : super();
  final int maxRows;
  final int minRows;

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final formArray = control as FormArray;
    final error = {
      ValidationMessage.min: <String, dynamic>{
        'min': minRows,
        'actual': formArray.controls.length,
      },
    };
    if (formArray.controls.length < minRows) {
      formArray.setErrors({'minRows': error});

      // force messages to show up as soon as possible
      formArray.markAsTouched();
    } else {
      formArray.removeError('minRows');
    }

    return null;
  }
}
