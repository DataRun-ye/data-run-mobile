import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

/// Holds a map of elementPath → GlobalKey
@injectable
class FieldContextRegistry {
  final Map<String, GlobalKey> _keys = {};
  final Map<String, FocusNode> _focusNodes = {};

  /// Get an existing key or create & register a new one
  GlobalKey getOrCreateKey(String elementPath) {
    return _keys.putIfAbsent(elementPath, () => GlobalKey());
  }
  FocusNode getOrCreateFocusNode(String elementPath) =>
      _focusNodes.putIfAbsent(elementPath, () => FocusNode());

  FocusNode? getFocusNode(String elementPath) => _focusNodes[elementPath];

  /// Just lookup (might be null if never requested)
  GlobalKey? getKey(String elementPath) => _keys[elementPath];

  void dispose() {
    for (var node in _focusNodes.values) {
      node.dispose();
    }
  }
}
