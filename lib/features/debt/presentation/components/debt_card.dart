import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pockaw/core/components/progress_indicators/progress_bar.dart';
import 'package:pockaw/core/constants/app_colors.dart';
import 'package:pockaw/core/constants/app_radius.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';
import 'package:pockaw/core/extensions/date_time_extension.dart';
import 'package:pockaw/core/extensions/double_extension.dart';
import 'package:pockaw/core/extensions/text_style_extensions.dart';
import 'package:pockaw/core/router/routes.dart';
import 'package:pockaw/features/debt/data/enum/debt_type.dart';
import 'package:pockaw/features/debt/data/model/debt_model.dart';
import 'package:pockaw/features/wallet/data/model/wallet_model.dart';
import 'package:pockaw/features/wallet/riverpod/wallet_providers.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class DebtCard extends ConsumerWidget {
  final DebtModel debt;
  final bool editing;

  const DebtCard({super.key, required this.debt, this.editing = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final wallet = ref.watch(activeWalletProvider).asData?.value;
    final currency = wallet?.currencyByIsoCode(ref).symbol ?? '';

    final isIOwe = debt.debtType == DebtType.iOwe;
    final statusColor = isIOwe ? AppColors.red : AppColors.green200;
    final typeLabel = isIOwe ? l10n.iOwe : l10n.iAmOwed;

    return InkWell(
      onTap: () {
        if (!editing) {
          context.push('${Routes.debtDetails}/${debt.id}');
        }
      },
      borderRadius: BorderRadius.circular(AppRadius.radius8),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.spacing12),
        decoration: BoxDecoration(
          color: context.secondaryBackground,
          borderRadius: BorderRadius.circular(AppRadius.radius12),
          border: Border.all(
            color: debt.isOverdue
                ? AppColors.red
                : context.secondaryBorderLighter,
            width: debt.isOverdue ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: isIOwe
                      ? context.expenseBackground
                      : context.incomeBackground,
                  child: HugeIcon(
                    icon: isIOwe
                        ? HugeIcons.strokeRoundedArrowUpRight01
                        : HugeIcons.strokeRoundedArrowDownLeft01,
                    color: isIOwe ? context.expenseText : context.incomeText,
                    size: 20,
                  ),
                ),
                const Gap(AppSpacing.spacing12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        debt.personName,
                        style: AppTextStyles.body3.bold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        typeLabel,
                        style: AppTextStyles.body5.copyWith(color: statusColor),
                      ),
                    ],
                  ),
                ),
                if (debt.isOverdue)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.spacing8,
                      vertical: AppSpacing.spacing2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.red.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppRadius.radius4),
                    ),
                    child: Text(
                      l10n.overdue,
                      style: AppTextStyles.body5.bold.copyWith(
                        color: AppColors.red,
                      ),
                    ),
                  )
                else if (debt.isCompleted)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.spacing8,
                      vertical: AppSpacing.spacing2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.green200.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppRadius.radius4),
                    ),
                    child: Text(
                      l10n.completedDebts,
                      style: AppTextStyles.body5.bold.copyWith(
                        color: AppColors.green200,
                      ),
                    ),
                  )
                else if (!editing)
                  HugeIcon(
                    icon: Directionality.of(context) == TextDirection.rtl
                        ? HugeIcons.strokeRoundedArrowLeft01
                        : HugeIcons.strokeRoundedArrowRight01,
                    color: context.secondaryText,
                    size: 20,
                  ),
              ],
            ),
            const Gap(AppSpacing.spacing12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$currency ${debt.remainingAmount.toPriceFormat()} ${l10n.left}',
                  style: AppTextStyles.body4.bold.copyWith(color: statusColor),
                ),
                Text(
                  '$currency ${debt.paidAmount.toPriceFormat()} ${l10n.ofTotal} ${debt.totalAmount.toPriceFormat()}',
                  style: AppTextStyles.body4.bold,
                ),
              ],
            ),
            const Gap(AppSpacing.spacing8),
            ProgressBar(
              value: debt.progress,
              foreground: isIOwe ? AppColors.red : AppColors.green200,
            ),
            if (debt.dueDate != null) ...[
              const Gap(AppSpacing.spacing8),
              Text(
                '${l10n.dueDate}: ${debt.dueDate!.toDayShortMonthYear(locale)}',
                style: AppTextStyles.body5.copyWith(
                  color: debt.isOverdue
                      ? AppColors.red
                      : context.secondaryText,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
