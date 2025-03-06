import 'package:d2_remote/core/datarun/exception/exception.dart';
import 'package:flutter/material.dart';

class CircularDependencyException extends FormElementException {
  CircularDependencyException(String message, Object? source)
      : super(
            'CircularDependencyException: element ${(source?.runtimeType) ?? ''} has circular dependency.');
}

class FormElementException extends DException {
  FormElementException(String? message, {Object? cause})
      : super(message ?? 'FormElementException: element error.', cause);
}

class FormElementNotFoundException extends FormElementException {
  FormElementNotFoundException(Object? source)
      : super('FormElementNotFoundException', cause: source);
}

class FormRepeatElementInvalidIndexException extends FormElementException {
  FormRepeatElementInvalidIndexException({Object? source, required this.index})
      : super(
            'FormRepeatElementInvalidIndexException: Index \'$index\' is not a valid index for FormRepeatElement',
            cause: source);

  /// The invalid index that was the cause of this exception.
  final String index;
}

/// This exception is thrown by Reactive Widgets that doesn't find a
/// parent widget [ReactiveForm] or [ReactiveFormArray] in the widgets tree.
class FormElementParentNotFoundException extends DException {
  /// Creates an instance of the exception
  /// passing the [widget] that throws the exception.
  FormElementParentNotFoundException(this.widget)
      : super(
            'FormElementParentNotFoundException: couldn\'t find a parent widget. An instance of ${widget.runtimeType.toString()} widget must be under a FormElement Widget in the widgets tree.',
            widget);

  /// The widget that throws this exception.
  Widget widget;
}

/// This exception is thrown by Reactive Widgets that doesn't find a
/// parent widget [ReactiveForm] or [ReactiveFormArray] in the widgets tree.
class FormSectionParentNotFoundException extends DException {
  /// Creates an instance of the exception
  /// passing the [widget] that throws the exception.
  FormSectionParentNotFoundException(this.widget)
      : super(
            'FormSectionParentNotFoundException: couldn\'t find a parent widget. An instance of ${widget.runtimeType.toString()} widget must be under a SectionElement Widget in the widgets tree.',
            widget);

  /// The widget that throws this exception.
  Widget widget;
}

/// This exception is thrown by Reactive Widgets that doesn't find a
/// parent widget [ReactiveForm] or [ReactiveFormArray] in the widgets tree.
class FormRepeatedParentNotFoundException extends DException {
  /// Creates an instance of the exception
  /// passing the [widget] that throws the exception.
  FormRepeatedParentNotFoundException(this.widget)
      : super(
            'FormRepeatedParentNotFoundException: couldn\'t find a parent widget. An instance of ${widget.runtimeType.toString()} widget must be under a Repeat Element type Widget in the widgets tree.',
            widget);

  /// The widget that throws this exception.
  Widget widget;
}
