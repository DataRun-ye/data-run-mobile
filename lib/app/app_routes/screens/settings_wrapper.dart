import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class SettingsWrapperPage extends StatelessWidget {
  const SettingsWrapperPage({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext c) => Scaffold(
        appBar: AppBar(title: Text('Settings')),
        body: child,
        bottomNavigationBar: SettingsTabBar(),
      );
}

class SettingsTabBar extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(label: 'User', icon: Icon(Icons.person)),
        BottomNavigationBarItem(label: 'Appearance', icon: Icon(Icons.palette)),
        BottomNavigationBarItem(label: 'Sync', icon: Icon(Icons.sync)),
      ],
      // currentIndex: selectedIndex.value,
      currentIndex: _calculateSelectedIndex(context),
      onTap: (int idx) => _onItemTapped(idx, context),
      // onTap: (i) {
      //   selectedIndex.value = i;
      //   final tabs = ['user', 'appearance', 'sync'];
      //   GoRouter.of(c).push('/${tabs[i]}');
      // },
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/settings/user')) {
      return 0;
    }
    if (location.startsWith('/settings/appearance')) {
      return 1;
    }
    if (location.startsWith('/settings/sync')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).replace('/settings/user');
      case 1:
        GoRouter.of(context).replace('/settings/appearance');
      case 2:
        GoRouter.of(context).replace('/settings/sync');
    }
  }
}

class SettingsUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Center(child: Text('User Settings'));
}

class SettingsAppearancePage extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Center(child: Text('Appearance Settings'));
}

class SettingsSyncPage extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Center(child: Text('Sync Settings'));
}
