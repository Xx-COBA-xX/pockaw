part of '../screens/login_screen.dart';

class GetStartedDescription extends StatelessWidget {
  const GetStartedDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Text.rich(
      style: AppTextStyles.body3,
      textAlign: TextAlign.center,
      TextSpan(
        text: l10n.getStartedDescPart1,
        children: [
          TextSpan(
            text: l10n.getStartedDescPart2,
            style: const TextStyle(fontVariations: [FontVariation.weight(700)]),
          ),
          TextSpan(text: l10n.getStartedDescPart3),
          TextSpan(
            text: l10n.getStartedDescPart4,
            style: const TextStyle(fontVariations: [FontVariation.weight(700)]),
          ),
          TextSpan(text: l10n.getStartedDescPart5),
          TextSpan(
            text: l10n.getStartedDescPart6,
            style: const TextStyle(fontVariations: [FontVariation.weight(700)]),
          ),
          TextSpan(text: l10n.getStartedDescPart7),
        ],
      ),
    );
  }
}
