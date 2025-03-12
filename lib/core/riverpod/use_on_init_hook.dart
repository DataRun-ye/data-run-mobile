import 'package:flutter/material.dart';

void useOnInit(Function() action) {
  WidgetsBinding.instance.addPostFrameCallback(
    (_) => action(),
  );
}
