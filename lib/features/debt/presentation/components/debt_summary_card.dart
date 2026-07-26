import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pockaw/core/constants/app_colors.dart';
import 'package:pockaw/core/constants/app_radius.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';
import 'package:pockaw/core/extensions/double_extension.dart';
import 'package:pockaw/features/debt/presentation/riverpod/debt_providers.dart';
import 'package:pockaw/features/wallet/data/model/wallet_model.dart';
import 'package:pockaw/features/wallet/riverpod/wallet_providers.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class DebtSummaryCard extends ConsumerWidget {
  const DebtSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final summary = ref.watch(debtSummaryProvider);
    final wallet = ref.watch(activeWalletProvider).asData?.value;
    final currency = wallet?.currencyByIsoCode(ref).symbol ?? '';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.spacing16),
      decoration: BoxDecoration(
        color: context.secondaryBackground,
        border: Border.all(color: context.secondaryBorderLighter),
        borderRadius: BorderRadius.circular(AppRadius.radius12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.spacing12,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.netDebtBalance,
                style: AppTextStyles.body4.copyWith(
                  color: context.secondaryText,
                  height: 1,
                ),
              ),
              const Gap(AppSpacing.spacing4),
              Text(
                '$currency ${summary.netBalance.toPriceFormat()}',
                style: AppTextStyles.numericHeading.copyWith(
                  height: 1.12,
                  color: summary.netBalance >= 0
                      ? AppColors.green200
                      : AppColors.red,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.spacing8),
                  decoration: BoxDecoration(
                    color: context.expenseBackground,
                    border: Border.all(color: context.expenseLine),
                    borderRadius: BorderRadius.circular(AppRadius.radius8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.totalIOwe,
                        style: AppTextStyles.body5.copyWith(
                          color: context.expenseText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '$currency ${summary.totalIOwe.toPriceFormat()}',
                        style: AppTextStyles.numericMedium.copyWith(
                          color: context.expenseText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(AppSpacing.spacing12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.spacing8),
                  decoration: BoxDecoration(
                    color: context.incomeBackground,
                    border: Border.all(color: context.incomeLine),
                    borderRadius: BorderRadius.circular(AppRadius.radius8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.totalIAmOwed,
                        style: AppTextStyles.body5.copyWith(
                          color: context.incomeText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '$currency ${summary.totalIAmOwed.toPriceFormat()}',
                        style: AppTextStyles.numericMedium.copyWith(
                          color: context.incomeText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
