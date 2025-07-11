import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/data/app_about_info.provider.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerAppVersionItem extends ConsumerWidget {
  const DrawerAppVersionItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appAboutAsync = ref.watch(appAboutInfoProvider);

    return AsyncValueWidget(
      value: appAboutAsync,
      valueBuilder: (AppAbout appInfo) {
        return ListTile(
          leading: const Icon(Icons.info),
          title: Text(S.of(context).appVersion),
          subtitle: Text('${appInfo.version} (${appInfo.buildNumber})'),
        );
      },
    );
  }
}
