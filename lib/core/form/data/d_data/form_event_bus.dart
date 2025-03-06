import 'dart:async';

import 'package:datarun/core/form/ui/intent/form_intent_sealed.dart';

class FormPendingIntentBus {
  final _controller = StreamController<FormIntent>.broadcast();

  void publish(FormIntent event) => _controller.add(event);

  Stream<FormIntent> subscribe() => _controller.stream;
}
