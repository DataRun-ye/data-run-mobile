import 'package:flutter/widgets.dart';

/// A mock authentication service.
class DatarunAuth extends ChangeNotifier {
  bool _signedIn = false;

  /// Whether user has signed in.
  bool get signedIn => _signedIn;

  /// Signs out the current user.
  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    // Sign out.
    _signedIn = false;
    notifyListeners();
  }

  /// Signs in a user.
  Future<bool> signIn(String username, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    // Sign in. Allow any password.
    _signedIn = true;
    notifyListeners();
    return _signedIn;
  }
}

/// An inherited notifier to host [DatarunAuth] for the subtree.
class DatarunAuthScope extends InheritedNotifier<DatarunAuth> {
  /// Creates a [DatarunAuthScope].
  const DatarunAuthScope({
    required DatarunAuth super.notifier,
    required super.child,
    super.key,
  });

  /// Gets the [DatarunAuth] above the context.
  static DatarunAuth of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DatarunAuthScope>()!.notifier!;
}
