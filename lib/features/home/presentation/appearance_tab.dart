import 'package:datarunmobile/core/main_constants.dart';
import 'package:datarunmobile/core/user_session/preference.provider.dart';
import 'package:datarunmobile/features/settings/presentation/settings_viewmodel.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class AppearanceTab extends StackedHookView<SettingsViewmodel> {
  const AppearanceTab({super.key}) : super(reactive: false);

  @override
  Widget builder(BuildContext context, SettingsViewmodel model) {
    return Consumer(
      builder: (context, ref, child) {
        final useMaterial3 =
            ref.watch(preferenceNotifierProvider(Preference.useMaterial3));

        return ListView(
          children: [
            ListTile(
              title: Text(S.of(context).toggleBrightness),
              trailing: Switch(
                value: Theme.of(context).brightness == Brightness.light,
                onChanged: (value) {
                  ref
                      .read(preferenceNotifierProvider(Preference.themeMode)
                          .notifier)
                      .update(
                          value ? ThemeMode.light.index : ThemeMode.dark.index);
                },
              ),
            ),
            ListTile(
              title: Text(S.of(context).materialVersion),
              trailing: IconButton(
                icon: useMaterial3
                    ? const Icon(
                        Icons.filter_3,
                      )
                    : const Icon(
                        Icons.filter_2,
                      ),
                onPressed: () => ref
                    .read(preferenceNotifierProvider(Preference.useMaterial3)
                        .notifier)
                    .update(!useMaterial3),
              ),
            ),
            ListTile(
              title: Text(S.of(context).selectColorTheme),
              trailing: const _ColorSeedButton(),
            ),
            // ListTile(
            //   title: Text(S.of(context).selectImageForColorExtraction),
            //   trailing: const _ColorImageButton(),
            // ),
          ],
        );
      },
    );
  }
}

class _ColorSeedButton extends ConsumerWidget {
  const _ColorSeedButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorSeed = ColorSeed.values[
        ref.watch(preferenceNotifierProvider(Preference.colorSeed)) as int];

    return PopupMenuButton(
      icon: const Icon(
        Icons.palette_outlined,
      ),
      tooltip: S.of(context).selectASeedColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        return List.generate(ColorSeed.values.length, (index) {
          ColorSeed currentColor = ColorSeed.values[index];

          return PopupMenuItem(
            value: index,
            enabled: currentColor != colorSeed,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    currentColor == colorSeed
                        ? Icons.color_lens
                        : Icons.color_lens_outlined,
                    color: currentColor.color,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(currentColor.label),
                ),
              ],
            ),
          );
        });
      },
      onSelected: (value) => ref
          .read(preferenceNotifierProvider(Preference.colorSeed).notifier)
          .update(value),
    );
  }
}

