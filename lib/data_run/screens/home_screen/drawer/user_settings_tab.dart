import 'package:datarunmobile/app/app.locator.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/core/services/auth.service.dart';
import 'package:datarunmobile/core/auth/user_session_manager.service.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:datarunmobile/data/preference.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserSettingsTab extends ConsumerWidget {
  const UserSettingsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoAsync = ref.watch(userInfoProvider);
    final authService = locator<AuthService>();
    return AsyncValueWidget(
      value: userInfoAsync,
      valueBuilder: (user) => ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Account Information Section
          Text(
            S.of(context).accountInformation,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(
                MdiIcons.accountArrowLeft,
              ),
              title: Text(S.of(context).loginUsername),
              subtitle: Text(user!.username ?? '-'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(
                MdiIcons.faceMan,
              ),
              title: Text(S.of(context).personInformation),
              subtitle: Text(user.firstName ?? '-'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // TODO(Hamza) Implement user info editing
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(
                MdiIcons.phoneSettings,
              ),
              title: Text(S.of(context).mobile),
              subtitle: Text(user.phoneNumber ?? '-'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // TODO(Hamza) Implement user info editing
                },
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
                onPressed: () {
                  // TODO(Hamza) Implement password change
                },
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
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.language,
              ),
              title: Text(S.of(context).language),
              subtitle: Text(
                  ref.watch(preferenceNotifierProvider(Preference.language))),
              trailing: DropdownButton<String>(
                value:
                    ref.watch(preferenceNotifierProvider(Preference.language)),
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
            ),
          ),

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
                await authService.logout();
                // await ref.read(authServiceProvider).logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
