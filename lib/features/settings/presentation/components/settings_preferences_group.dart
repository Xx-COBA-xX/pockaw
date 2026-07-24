part of '../screens/settings_screen.dart';

class SettingsPreferencesGroup extends ConsumerWidget {
  const SettingsPreferencesGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeNotifierProvider);
    final l10n = AppLocalizations.of(context);
    final langText = currentLocale == null
        ? l10n.systemDefault
        : (currentLocale.languageCode == 'ar' ? l10n.arabic : l10n.english);

    return SettingsGroupHolder(
      title: l10n.settings,
      settingTiles: [
        MenuTileButton(
          label: '${l10n.language} ($langText)',
          icon: HugeIcons.strokeRoundedGlobal,
          onTap: () => LanguageSelectorDialog.show(context),
        ),
        MenuTileButton(
          label: 'Notifications',
          icon: HugeIcons.strokeRoundedNotification01,
          onTap: () => context.push(Routes.comingSoon),
        ),
      ],
    );
  }
}
