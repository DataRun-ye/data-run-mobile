import 'package:datarunmobile/features/activity/presentation/activity_list_view.dart';
import 'package:datarunmobile/features/home/presentation/drawer/app_drawer.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class HomeWrapperPage extends StatelessWidget {
  const HomeWrapperPage({super.key, this.langKey = 'ar'});

  final String langKey;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).home),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(child: const ActivityListView()),
    );
  }
}
