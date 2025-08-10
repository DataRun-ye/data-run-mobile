import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/common/confirmation_service.dart';
import 'package:datarunmobile/core/user_session/preference.provider.dart';
import 'package:datarunmobile/features/settings/presentation/settings_viewmodel.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';

class UserSettingsTabView extends ViewModelWidget<SettingsViewmodel> {
  const UserSettingsTabView({super.key}) : super(reactive: true);

  @override
  Widget build(BuildContext context, SettingsViewmodel model) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final currentAuthUser = appLocator<AuthManager>().activeUserSession;
        // final currentAuthUser = model.user;
        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text(
              S.of(context).accountInformation,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: Icon(MdiIcons.accountArrowLeft),
                title: Text(S.of(context).loginUsername),
                subtitle: Text(currentAuthUser?.username ?? '-'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(MdiIcons.faceMan),
                title: Text(S.of(context).personInformation),
                subtitle: Text(currentAuthUser?.firstName ?? '-'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(MdiIcons.phoneSettings),
                title: Text(S.of(context).mobile),
                subtitle: Text(currentAuthUser?.mobile ?? '-'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.lock_outline,
                ),
                title: Text(S.of(context).changePassword),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                ),
              ),
            ),

            // Preferences Section
            const SizedBox(height: 24),
            Text(
              S.of(context).preferences,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            const _SettingsLanguageItem(),

            // Logout Button
            const SizedBox(height: 20),
            Card(
              color: Theme.of(context).colorScheme.errorContainer,
              child: ListTile(
                leading: Icon(MdiIcons.logout,
                    color: Theme.of(context).colorScheme.onErrorContainer),
                title: Text(
                  S.of(context).logout,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer),
                ),
                subtitle: Text(
                  S.of(context).logoutNote,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer),
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () async {
                  appLocator<ConfirmationService>().confirmAndExecute(
                      context: context,
                      title: S.of(context).logOut,
                      body: S.of(context).signingOutWarning,
                      confirmLabel: S.of(context).logOutAnyway,
                      action: () => model.logout());
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SettingsLanguageItem extends ConsumerWidget {
  const _SettingsLanguageItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String prefLang =
        ref.watch(preferenceNotifierProvider(Preference.language)) as String;
    String language = prefLang == 'NA' ? 'en' : prefLang;

    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.language,
        ),
        title: Text(S.of(context).language),
        subtitle: DropdownButton<String>(
          value: language,
          onChanged: (String? newValue) {
            if (newValue != null) {
              {
                ref
                    .read(preferenceNotifierProvider(Preference.language)
                        .notifier)
                    .update(newValue);
              }
            }
          },
          items: <String>['ar', 'en']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        // trailing:
      ),
    );
  }
}
