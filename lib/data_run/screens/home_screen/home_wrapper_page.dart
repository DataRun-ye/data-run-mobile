import 'package:datarunmobile/data_run/d_activity/activity_list_view.dart';
import 'package:datarunmobile/data_run/screens/home_screen/drawer/app_drawer.dart';
import 'package:flutter/material.dart';

class HomeWrapperPage extends StatelessWidget {
  const HomeWrapperPage({super.key, this.langKey = 'ar'});

  final String langKey;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      onDrawerChanged: (isOpen) {
        // isOpen ? model.checkOnline(isOpen) : model.cancelToken(isOpen);
      },
      drawer: const AppDrawer(),
      body: const ActivityListView(),
    );
    // return ViewModelBuilder<AppDrawerViewModel>.nonReactive(
    //   builder: (context, model, child) => Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Home'),
    //     ),
    //     onDrawerChanged: (isOpen) {
    //       isOpen ? model.checkOnline(isOpen) : model.cancelToken(isOpen);
    //     },
    //     drawer: const AppDrawer(),
    //     body: const ActivityListView(),
    //   ),
    //   viewModelBuilder: () => AppDrawerViewModel(),
    // );
  }
}
