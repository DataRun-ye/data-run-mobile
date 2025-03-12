import 'package:datarunmobile/data/form_notifier.provider.dart';
import 'package:datarunmobile/core/form/ui/intent/form_intent_sealed.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Usage in UI:
/// ```dart
/// final intentHandler = ref.read(formIntentHandlerProvider);
/// intentHandler.dispatch(OnSave(...));
/// ```
class FormIntentHandler {
  final Ref ref;

  FormIntentHandler(this.ref);

  void dispatch(FormIntent intent) {
    ref.read(formNotifierProvider.notifier).handleIntent(intent);
  }
}
