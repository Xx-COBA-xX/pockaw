import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pockaw/core/components/buttons/custom_icon_button.dart';
import 'package:pockaw/core/constants/app_colors.dart';
import 'package:pockaw/core/constants/app_radius.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';
import 'package:pockaw/core/extensions/date_time_extension.dart';
import 'package:pockaw/core/extensions/double_extension.dart';
import 'package:pockaw/core/extensions/text_style_extensions.dart';
import 'package:pockaw/features/debt/data/model/debt_payment_model.dart';
import 'package:pockaw/features/wallet/data/model/wallet_model.dart';
import 'package:pockaw/features/wallet/riverpod/wallet_providers.dart';

class DebtPaymentTile extends ConsumerWidget {
  final DebtPaymentModel payment;
  final VoidCallback? onDelete;

  const DebtPaymentTile({
    super.key,
    required this.payment,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context).languageCode;
    final wallet = ref.watch(activeWalletProvider).asData?.value;
    final currency = wallet?.currencyByIsoCode(ref).symbol ?? '';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.spacing12),
      decoration: BoxDecoration(
        color: context.secondaryBackground,
        borderRadius: BorderRadius.circular(AppRadius.radius8),
        border: Border.all(color: context.secondaryBorderLighter),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.green200.withValues(alpha: 0.15),
            child: const HugeIcon(
              icon: HugeIcons.strokeRoundedCheckmarkCircle02,
              color: AppColors.green200,
              size: 18,
            ),
          ),
          const Gap(AppSpacing.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$currency ${payment.amount.toPriceFormat()}',
                  style: AppTextStyles.body3.bold,
                ),
                Text(
                  payment.paymentDate.toDayShortMonthYear(locale),
                  style: AppTextStyles.body5.copyWith(
                    color: context.secondaryText,
                  ),
                ),
                if (payment.notes != null && payment.notes!.isNotEmpty) ...[
                  const Gap(AppSpacing.spacing2),
                  Text(
                    payment.notes!,
                    style: AppTextStyles.body5.copyWith(
                      color: context.secondaryText,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onDelete != null)
            CustomIconButton(
              context,
              onPressed: onDelete!,
              icon: HugeIcons.strokeRoundedDelete02,
              themeMode: context.themeMode,
            ),
        ],
      ),
    );
  }
}
