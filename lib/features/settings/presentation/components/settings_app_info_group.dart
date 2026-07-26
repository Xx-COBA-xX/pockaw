part of '../screens/settings_screen.dart';

final logoutKey = GlobalKey<NavigatorState>();

class SettingsAppInfoGroup extends ConsumerWidget {
  const SettingsAppInfoGroup({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final l10n = AppLocalizations.of(context);
    return SettingsGroupHolder(
      title: l10n.appInfo,
      settingTiles: [
        MenuTileButton(
          label: l10n.privacyPolicy,
          icon: HugeIcons.strokeRoundedLegalHammer,
          suffixIcon: HugeIcons.strokeRoundedSquareArrowUpRight,
          onTap: () {
            LinkLauncher.launch(AppConstants.privacyPolicyUrl);
          },
        ),
        MenuTileButton(
          label: l10n.termsAndConditions,
          icon: HugeIcons.strokeRoundedFileExport,
          suffixIcon: HugeIcons.strokeRoundedSquareArrowUpRight,
          onTap: () {
            LinkLauncher.launch(AppConstants.termsAndConditionsUrl);
          },
        ),
        MenuTileButton(
          label: l10n.reportLogFile,
          icon: HugeIcons.strokeRoundedFileCorrupt,
          onTap: () => context.openBottomSheet(child: ReportLogFileDialog()),
          onLongPress: () {
            ref.read(userActivityServiceProvider).shareLogActivities();
          },
        ),
        if (kDebugMode)
          MenuTileButton(
            label: l10n.developerPortal,
            icon: HugeIcons.strokeRoundedCode,
            onTap: () => context.push(Routes.developerPortal),
          ),
      ],
    );
  }
}
