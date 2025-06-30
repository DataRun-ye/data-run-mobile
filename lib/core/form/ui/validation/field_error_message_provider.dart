import 'package:d2_remote/core/datarun/exception/d_exception.dart';
import 'package:d2_remote/core/value_type_validator/value_type/failures/boolean_failure.dart';
import 'package:d2_remote/core/value_type_validator/value_type/failures/coordinate_failure.dart';
import 'package:d2_remote/core/value_type_validator/value_type/failures/date_failure.dart';
import 'package:d2_remote/core/value_type_validator/value_type/failures/date_time_failure.dart';
import 'package:d2_remote/core/value_type_validator/value_type/failures/email_failure.dart';
import 'package:d2_remote/core/value_type_validator/value_type/failures/integer_failure.dart'
    as iif;
import 'package:d2_remote/core/value_type_validator/value_type/failures/integer_negative_failure.dart'
    as inf;
import 'package:d2_remote/core/value_type_validator/value_type/failures/integer_positive_failure.dart'
    as ipf;
import 'package:d2_remote/core/value_type_validator/value_type/failures/integer_zero_or_positive_failure.dart'
    as izf;
import 'package:d2_remote/core/value_type_validator/value_type/failures/letter_failure.dart';
import 'package:d2_remote/core/value_type_validator/value_type/failures/number_failure.dart'
    as nf;
import 'package:d2_remote/core/value_type_validator/value_type/failures/percentage_failure.dart'
    as pf;
import 'package:d2_remote/core/value_type_validator/value_type/failures/phone_number_failure.dart'
    as pnf;
import 'package:d2_remote/core/value_type_validator/value_type/failures/text_failure.dart';
import 'package:d2_remote/core/value_type_validator/value_type/failures/time_failure.dart';
import 'package:d2_remote/core/value_type_validator/value_type/failures/true_only_failure.dart'
    as tf;
import 'package:d2_remote/core/value_type_validator/value_type/failures/unit_interval_failure.dart'
    as uf;
import 'package:d2_remote/core/value_type_validator/value_type/failures/url_failure.dart';
import 'package:datarunmobile/core/form/ui/validation/failures/field_mask_failure.data.dart'
    as fmf;
import 'package:intl/intl.dart';

class FieldErrorMessageProvider {
  const FieldErrorMessageProvider();

  String getFriendlyErrorMessage(DException error) {
    return Intl.message(_parseErrorToMessage(error));
  }

  String _parseErrorToMessage(DException error) {
    if (error is BooleanFailure) return _getBooleanError(error);
    if (error is DateFailure) return _getDateError(error);
    if (error is DateTimeFailure) return _getDateTimeError(error);
    if (error is LetterFailure) return _getLetterError(error);
    if (error is TextFailure) return _getTextError(error);
    if (error is TimeFailure) return _getTimeError(error);
    if (error is tf.TrueOnlyFailure) return _getTrueOnlyError(error);
    if (error is pnf.PhoneNumberFailure) return _getPhoneNumberError(error);
    if (error is EmailFailure) return _getEmailError(error);
    if (error is inf.IntegerNegativeFailure)
      return _getIntegerNegativeError(error);
    if (error is izf.IntegerZeroOrPositiveFailure)
      return _getIntegerZeroOrPositiveError(error);
    if (error is ipf.IntegerPositiveFailure)
      return _getIntegerPositiveError(error);
    if (error is uf.UnitIntervalFailure) return _getUnitIntervalFailure(error);
    if (error is pf.PercentageFailure) return _getPercentageError(error);
    if (error is UrlFailure) return _getUrlError(error);
    if (error is iif.IntegerFailure) return _getIntegerError(error);
    if (error is nf.NumberFailure) return _getNumberError(error);
    if (error is fmf.FieldMaskFailure) return _getFieldMaskError(error);
    if (error is CoordinateFailure) return _getCoordinateError(error);

    // send error.message  as argument
    return 'invalid_field';
  }

  String _getTrueOnlyError(tf.TrueOnlyFailure error) => switch (error) {
        tf.OneIsNotTrueException() => 'error_true_only_one_is_not_true',
        tf.FalseIsNotAValidValueException() =>
          'error_true_only_false_not_valid',
        tf.BooleanMalformedException() => 'error_true_only_malformed',
      };

  String _getTextError(TextFailure error) => switch (error) {
        TooLargeTextException() => 'error_text_too_long',
      };

  String _getLetterError(LetterFailure error) => switch (error) {
        StringIsNotALetterException() => 'error_letter_not_a_letter',
        MoreThanOneLetterException() => 'error_letter_more_than_one',
        EmptyStringException() => 'error_letter_empty',
      };

  String _getTimeError(TimeFailure error) =>
      switch (error) { TimeParseException() => 'error_time_parsing' };

  String _getDateTimeError(DateTimeFailure error) => switch (error) {
        DateTimeParseException() => 'error_date_time_parsing',
      };

  String _getDateError(DateFailure error) => switch (error) {
        DateParseException() => 'error_date_parsing',
      };

  String _getBooleanError(BooleanFailure error) => switch (error) {
        OneIsNotTrueException() => 'error_boolean_one_is_not_true',
        ZeroIsNotFalseException() => 'error_boolean_zero_is_not_false',
        BooleanMalformedException() => 'error_boolean_malformed',
      };

  String _getCoordinateError(CoordinateFailure error) => switch (error) {
        CoordinateMalformedException() => 'wrong_pattern',
      };

  String _getFieldMaskError(fmf.FieldMaskFailure error) => switch (error) {
        fmf.WrongPatternException() => 'pattern_error',
        fmf.FieldMaskFailure() => 'wrong_pattern',
      };

  String _getPhoneNumberError(pnf.PhoneNumberFailure error) => switch (error) {
        pnf.MalformedPhoneNumberException() => 'invalid_phone_number',
      };

  String _getEmailError(EmailFailure error) => switch (error) {
        MalformedEmail() => 'invalid_email',
      };

  String _getIntegerNegativeError(inf.IntegerNegativeFailure error) =>
      switch (error) {
        inf.MalformedNumber() => 'formatting_error',
        inf.ValueIsZero() => 'invalid_negative_number',
        inf.ValueIsPositive() => 'invalid_negative_number',
        inf.IntegerOverflow() => 'formatting_error',
        inf.LeadingZero() => 'leading_zero_error',
      };

  String _getIntegerZeroOrPositiveError(
          izf.IntegerZeroOrPositiveFailure error) =>
      switch (error) {
        izf.ValueIsNegative() => 'invalid_positive_zero',
        izf.MalformedNumber() => 'formatting_error',
        izf.IntegerOverflow() => 'formatting_error',
        izf.LeadingZero() => 'leading_zero_error',
      };

  String _getIntegerPositiveError(ipf.IntegerPositiveFailure error) =>
      switch (error) {
        ipf.MalformedNumber() => 'formatting_error',
        ipf.ValueIsZero() => 'invalid_positive',
        ipf.ValueIsNegative() => 'invalid_positive',
        ipf.IntegerOverflow() => 'formatting_error',
        ipf.LeadingZero() => 'leading_zero_error',
      };

  String _getUnitIntervalFailure(uf.UnitIntervalFailure error) =>
      switch (error) {
        uf.ScientificNotationExceptionUnitInterval() => 'formatting_error',
        uf.UnitIntervalNumberFormatException() => 'formatting_error',
        uf.GreaterThanOneException() => 'invalid_interval',
        uf.SmallerThanZeroException() => 'invalid_interval',
      };

  String _getPercentageError(pf.PercentageFailure error) => switch (error) {
        pf.PercentageNumberFormatException() => 'formatting_error',
        pf.ValueGreaterThan100() => 'invalid_percentage',
        pf.ValueIsNegative() => 'invalid_positive',
      };

  String _getUrlError(UrlFailure error) => switch (error) {
        MalformedUrlException() => 'validation_url',
      };

  String _getIntegerError(iif.IntegerFailure error) => switch (error) {
        iif.MalformedNumber() => 'formatting_error',
        iif.IntegerOverflow() => 'invalid_integer',
        iif.LeadingZero() => 'leading_zero_error',
      };

  String _getNumberError(nf.NumberFailure error) => switch (error) {
        nf.MalformedNumberException() => 'formatting_error',
        nf.LeadingZeroException() => 'leading_zero_error',
        nf.ScientificNotationException() => 'formatting_error',
        nf.NumberFailure() => 'invalid_number',
      };

  String mandatoryWarning() {
    return Intl.message('fieldIsMandatory');
  }

  String defaultValidationErrorMessage() {
    return Intl.message('validationErrorMessage');
  }
}
