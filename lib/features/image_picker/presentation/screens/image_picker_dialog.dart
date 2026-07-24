import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pockaw/core/components/buttons/secondary_button.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';

import 'package:pockaw/l10n/app_localizations.dart';

class ImagePickerDialog extends ConsumerWidget {
  final Function? onTakePhoto;
  final Function? onPickImage;
  const ImagePickerDialog({super.key, this.onTakePhoto, this.onPickImage});

  @override
  Widget build(BuildContext context, ref) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        HugeIcon(icon: HugeIcons.strokeRoundedInformationSquare),
        Gap(AppSpacing.spacing12),
        Text(
          l10n.imagePickerPrivacyNote,
          style: AppTextStyles.body3,
          textAlign: TextAlign.center,
        ),
        Gap(AppSpacing.spacing48),
        Row(
          children: [
            if (Platform.isAndroid || Platform.isIOS)
              Expanded(
                child: SecondaryButton(
                  context: context,
                  onPressed: () async {
                    onTakePhoto?.call();
                  },
                  label: l10n.camera,
                  icon: HugeIcons.strokeRoundedCamera01,
                ),
              ),
            if (Platform.isAndroid || Platform.isIOS)
              const Gap(AppSpacing.spacing8),
            Expanded(
              child: SecondaryButton(
                context: context,
                onPressed: () {
                  onPickImage?.call();
                },
                label: l10n.gallery,
                icon: HugeIcons.strokeRoundedImage01,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
