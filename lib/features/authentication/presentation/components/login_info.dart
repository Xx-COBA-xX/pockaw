part of '../screens/login_screen.dart';

class LoginInfo extends StatelessWidget {
  const LoginInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: l10n.localDataStorageNotice,
        style: AppTextStyles.body4,
        children: [
          TextSpan(
            text: l10n.readMore,
            style: AppTextStyles.body4.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: context.secondaryText,
              color: context.secondaryText,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                LinkLauncher.launch(AppConstants.privacyPolicyUrl);
              },
          ),
          TextSpan(text: l10n.toFindOut),
        ],
      ),
    );
  }
}
