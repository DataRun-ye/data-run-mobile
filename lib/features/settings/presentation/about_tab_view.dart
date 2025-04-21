import 'package:datarunmobile/data/app_about_info.provider.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AboutTabView extends ConsumerWidget {
  const AboutTabView({super.key, required this.appAbout});

  final AppAbout appAbout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        SectionHeader(title: S.of(context).appInformation),
        AppInfoCard(
          icon: Icons.info_outline,
          title: S.of(context).appVersion,
          subtitle: '${appAbout.version} (${appAbout.buildNumber})',
        ),
        const SizedBox(height: 24),
        SectionHeader(title: S.of(context).developerInformation),
        AppInfoCard(
          icon: Icons.developer_mode,
          title: S.of(context).developer,
          subtitle: S.of(context).developerInfoText,
        ),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

class AppInfoCard extends StatelessWidget {
  const AppInfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
