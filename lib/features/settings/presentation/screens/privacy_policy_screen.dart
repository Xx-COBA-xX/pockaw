import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pockaw/core/components/scaffolds/custom_scaffold.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';
import 'package:pockaw/core/services/url_launcher/url_launcher.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomScaffold(
      title: l10n.privacyPolicy,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacing16,
          vertical: AppSpacing.spacing20,
        ),
        child: MarkdownBody(
          data: l10n.privacyPolicyContent,
          selectable: true,
          onTapLink: (text, href, title) {
            if (href != null && href.isNotEmpty) {
              LinkLauncher.launch(href);
            }
          },
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
            p: AppTextStyles.body2,
            h3: AppTextStyles.heading5.copyWith(
              color: isDark ? Colors.white : Colors.black,
            ),
            h4: AppTextStyles.heading6.copyWith(
              color: isDark ? Colors.white70 : Colors.black87,
            ),
            listBullet: AppTextStyles.body2,
            a: AppTextStyles.body2.copyWith(
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}
