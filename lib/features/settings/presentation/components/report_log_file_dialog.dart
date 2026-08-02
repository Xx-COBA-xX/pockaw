import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pockaw/core/components/bottom_sheets/custom_bottom_sheet.dart';
import 'package:pockaw/core/components/buttons/primary_button.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';
import 'package:pockaw/core/utils/share_service.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class ReportLogFileDialog extends StatelessWidget {
  const ReportLogFileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CustomBottomSheet(
      title: l10n.reportLogFile,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.reportLogFileNotice,
            textAlign: TextAlign.center,
            style: AppTextStyles.body3,
          ),
          Gap(AppSpacing.spacing32),
          PrimaryButton(
            label: l10n.understandAndContinue,
            onPressed: () async {
              await ShareService.shareLogFile();
              if (context.mounted) context.pop();
            },
          ),
        ],
      ),
    );
  }
}
