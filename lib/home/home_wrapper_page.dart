import 'package:auto_route/auto_route.dart';
import 'package:datarunmobile/home/home_viewmodel.dart';
import 'package:datarunmobile/home/dashboard/presentation/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class HomeWrapperPage extends StatefulWidget {
  const HomeWrapperPage({super.key});

  @override
  State<HomeWrapperPage> createState() => _HomeShellPageState();
}

class _HomeShellPageState extends State<HomeWrapperPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard'),
          ),
          onDrawerChanged: (isOpen) {
            isOpen ? viewModel.checkOnline() : viewModel.cancelToken();
          },
          drawer: const AppDrawer(),
          body: const AutoRouter(),
        );
      },
    );
  }
}
