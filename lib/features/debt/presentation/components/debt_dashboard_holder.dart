import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pockaw/core/constants/app_colors.dart';
import 'package:pockaw/core/constants/app_radius.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';
import 'package:pockaw/core/router/routes.dart';
import 'package:pockaw/features/debt/presentation/components/debt_card.dart';
import 'package:pockaw/features/debt/presentation/riverpod/debt_providers.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class DebtDashboardHolder extends ConsumerWidget {
  const DebtDashboardHolder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final asyncDebts = ref.watch(debtListProvider);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.spacing12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spacing16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.debts, style: AppTextStyles.heading6),
                InkWell(
                  onTap: () => context.push(Routes.debtList),
                  borderRadius: BorderRadius.circular(AppRadius.radius4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.spacing8,
                      vertical: AppSpacing.spacing4,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.viewAll,
                          style: AppTextStyles.body4.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const Gap(AppSpacing.spacing4),
                        HugeIcon(
                          icon: Directionality.of(context) == TextDirection.rtl
                              ? HugeIcons.strokeRoundedArrowLeft01
                              : HugeIcons.strokeRoundedArrowRight01,
                          color: AppColors.primary,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(AppSpacing.spacing12),
          asyncDebts.when(
            data: (debts) {
              final activeDebts = debts.where((d) => !d.isCompleted).toList();

              if (activeDebts.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing16,
                  ),
                  child: InkWell(
                    onTap: () => context.push(Routes.debtForm),
                    borderRadius: BorderRadius.circular(AppRadius.radius12),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.spacing16),
                      decoration: BoxDecoration(
                        color: context.secondaryBackground,
                        borderRadius: BorderRadius.circular(AppRadius.radius12),
                        border: Border.all(
                          color: context.secondaryBorderLighter,
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: context.purpleBackground,
                            child: HugeIcon(
                              icon: HugeIcons.strokeRoundedPlusSign,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                          const Gap(AppSpacing.spacing12),
                          Expanded(
                            child: Text(
                              l10n.noDebtsFoundCreateOne,
                              style: AppTextStyles.body4.copyWith(
                                color: context.secondaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              if (activeDebts.length == 1) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing16,
                  ),
                  width: double.infinity,
                  child: DebtCard(debt: activeDebts.first),
                );
              }

              return SizedBox(
                height: 155,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing16,
                  ),
                  itemCount: activeDebts.take(5).length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 280,
                      child: DebtCard(debt: activeDebts[index]),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const Gap(AppSpacing.spacing12),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.spacing16,
              ),
              child: Text('Error: $e', style: AppTextStyles.body3),
            ),
          ),
        ],
      ),
    );
  }
}
