import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pockaw/core/components/buttons/primary_button.dart';
import 'package:pockaw/core/components/scaffolds/custom_scaffold.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';
import 'package:pockaw/core/router/routes.dart';
import 'package:pockaw/features/theme_switcher/presentation/components/theme_mode_switcher.dart';
import 'package:pockaw/l10n/app_localizations.dart';

part '../components/get_started_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CustomScaffold(
      showBackButton: false,
      showBalance: false,
      actions: [ThemeModeSwitcher()],
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            // color: Colors.yellow,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icon/icon.png',
                  width: 250,
                ),
                const Gap(16),
                Text(
                  l10n.welcomeTo,
                  style: AppTextStyles.heading2,
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${l10n.appName}!',
                  style: AppTextStyles.heading2,
                  textAlign: TextAlign.center,
                ),
                const Gap(16),
                Text(
                  l10n.onboardingDescription,
                  style: AppTextStyles.body1.copyWith(
                    fontVariations: [const FontVariation.weight(500)],
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(150),
              ],
            ),
          ),
          const GetStartedButton(),
        ],
      ),
    );
  }
}
