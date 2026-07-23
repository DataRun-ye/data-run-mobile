import 'package:collection/collection.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';

enum RepeatRowBackAction {
  close,
  discard,
  confirm,
}

class RepeatRowEditSession {
  RepeatRowEditSession({
    required this.formInstance,
    required this.parent,
    required this.item,
    required this.isNew,
    bool? formWasDirtyBeforeEdit,
    bool? formWasTouchedBeforeEdit,
  })  : _initialValue = _copyMap(item.retainedValue),
        _wasDirty = item.elementControl.dirty,
        _wasTouched = item.elementControl.touched,
        _formWasDirty = formWasDirtyBeforeEdit ?? formInstance.form.dirty,
        _formWasTouched = formWasTouchedBeforeEdit ?? formInstance.form.touched;

  static const _equality = DeepCollectionEquality();

  final FormInstance formInstance;
  final RepeatSection parent;
  final RepeatItemInstance item;
  final bool isNew;
  final Map<String, Object?> _initialValue;
  final bool _wasDirty;
  final bool _wasTouched;
  final bool _formWasDirty;
  final bool _formWasTouched;

  bool get hasChanges => !_equality.equals(_initialValue, item.retainedValue);

  bool get isValid => item.elementControl.valid && !item.hasErrors;

  bool get canSave => isValid && (isNew || hasChanges);

  RepeatRowBackAction get backAction {
    if (hasChanges) {
      return RepeatRowBackAction.confirm;
    }
    return isNew ? RepeatRowBackAction.discard : RepeatRowBackAction.close;
  }

  Future<void> save({RepeatRowEditSession? enclosingSession}) async {
    parent.elementControl.markAsTouched();
    if (enclosingSession == null) {
      await formInstance.saveFormData();
    }
  }

  RepeatItemInstance? discard() {
    RepeatItemInstance? restoredItem;
    if (isNew) {
      formInstance.removeRepeatedItem(item, parent);
    } else {
      restoredItem = formInstance.restoreRepeatedItem(
        item,
        parent,
        _initialValue,
        dirty: _wasDirty,
        touched: _wasTouched,
      );
    }

    if (!_formWasDirty) {
      formInstance.form.markAsPristine();
    }
    if (!_formWasTouched) {
      formInstance.form.markAsUntouched();
    }
    return restoredItem;
  }

  static Map<String, Object?> _copyMap(Map<String, Object?> value) =>
      value.map((key, item) => MapEntry(key, _copyValue(item)));

  static Object? _copyValue(Object? value) {
    if (value is Map) {
      return value.map(
        (key, item) => MapEntry(key.toString(), _copyValue(item)),
      );
    }
    if (value is List) {
      return value.map(_copyValue).toList();
    }
    return value;
  }
}
