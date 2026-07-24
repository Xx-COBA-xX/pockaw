part of '../screens/settings_screen.dart';

class AppVersionInfo extends ConsumerWidget {
  const AppVersionInfo({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final packageInfo = ref.read(packageInfoServiceProvider);
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(l10n.version, style: AppTextStyles.body3),
          Text(
            '${packageInfo.version} • Build ${packageInfo.buildNumber}',
            style: AppTextStyles.body4,
          ),
        ],
      ),
    );
  }
}
