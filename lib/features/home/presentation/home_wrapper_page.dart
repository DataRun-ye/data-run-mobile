import 'package:datarunmobile/data/app_about_info.provider.dart';
import 'package:datarunmobile/features/activity/presentation/activity_list_view.dart';
import 'package:datarunmobile/features/home/presentation/drawer/app_drawer.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeWrapperPage extends ConsumerWidget {
  const HomeWrapperPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final majorVersion = ref.watch(appAboutInfoProvider).when(
          data: (appInfo) => appInfo.version.split('.').first,
          error: (_, __) => null,
          loading: () => null,
        );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.of(context).home),
            if (majorVersion != null) ...[
              const SizedBox(width: 8),
              Badge(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                textColor: Theme.of(context).colorScheme.onTertiary,
                label: Text('v$majorVersion'),
              ),
            ],
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(child: const ActivityListView()),
    );
  }
}
