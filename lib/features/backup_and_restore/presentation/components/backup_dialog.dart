import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';
import 'package:pockaw/core/extensions/text_style_extensions.dart';

import 'package:pockaw/l10n/app_localizations.dart';

class BackupDialog extends StatelessWidget {
  final Function? onStart;
  final Function? onSuccess;
  final Function? onFailed;
  const BackupDialog({super.key, this.onStart, this.onSuccess, this.onFailed});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        HugeIcon(icon: HugeIcons.strokeRoundedInformationSquare),
        Gap(AppSpacing.spacing12),
        Text(
          l10n.backupNoticeFormat,
          style: AppTextStyles.body3,
          textAlign: TextAlign.center,
        ),
        Gap(AppSpacing.spacing8),
        Text(
          '"Pockaw_Backup_[DateTime]"',
          style: AppTextStyles.body3.bold,
          textAlign: TextAlign.center,
        ),
        Gap(AppSpacing.spacing8),
        Text(
          l10n.backupSecurityNote,
          style: AppTextStyles.body3,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
