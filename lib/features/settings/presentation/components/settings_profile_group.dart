part of '../screens/settings_screen.dart';

class SettingsProfileGroup extends StatelessWidget {
  const SettingsProfileGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SettingsGroupHolder(
      title: l10n.profile,
      settingTiles: [
        MenuTileButton(
          label: l10n.personalDetails,
          icon: HugeIcons.strokeRoundedUser,
          onTap: () => context.push(Routes.personalDetails),
        ),
      ],
    );
  }
}
