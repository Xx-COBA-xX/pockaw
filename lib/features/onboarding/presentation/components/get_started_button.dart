part of '../screens/onboarding_screen.dart';

class GetStartedButton extends ConsumerWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final l10n = AppLocalizations.of(context);
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: PrimaryButton(
          label: l10n.getStarted,
          onPressed: () {
            if (context.mounted) context.push(Routes.getStarted); // route '/'
          },
        ),
      ),
    );
  }
}
