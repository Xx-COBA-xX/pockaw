part of '../screens/settings_screen.dart';

class SettingsSessionGroup extends ConsumerWidget {
  const SettingsSessionGroup({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final l10n = AppLocalizations.of(context);
    return SettingsGroupHolder(
      title: l10n.session,
      settingTiles: [
        MenuTileButton(
          label: 'الذهاب لشاشة البداية (مؤقت)',
          icon: HugeIcons.strokeRoundedPlay,
          onTap: () {
            context.go(Routes.getStarted);
          },
        ),
        MenuTileButton(
          label: l10n.logout,
          icon: HugeIcons.strokeRoundedLogout01,
          onTap: () {
            // show confirm dialog then perform logout
            context.openBottomSheet(
              child: AlertBottomSheet(
                context: context,
                title: l10n.logout,
                confirmText: l10n.logout,
                content: Text(
                  l10n.continueLogoutDevice,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body2,
                ),
                onConfirm: () {
                  context.pop(); // close this dialog
                  ref.read(authStateProvider.notifier).logout();
                  context.go(Routes.getStarted);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
