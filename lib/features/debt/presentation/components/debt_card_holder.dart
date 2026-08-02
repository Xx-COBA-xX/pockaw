import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';
import 'package:pockaw/features/debt/data/enum/debt_type.dart';
import 'package:pockaw/features/debt/data/model/debt_model.dart';
import 'package:pockaw/features/debt/presentation/components/debt_card.dart';
import 'package:pockaw/features/debt/presentation/riverpod/debt_providers.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class DebtCardHolder extends ConsumerWidget {
  final int tabIndex; // 0: All, 1: I Owe, 2: I Am Owed, 3: Completed

  const DebtCardHolder({super.key, this.tabIndex = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final debtsAsync = ref.watch(debtListProvider);

    return debtsAsync.when(
      data: (allDebts) {
        List<DebtModel> filteredDebts = [];
        if (tabIndex == 0) {
          filteredDebts = allDebts.where((d) => !d.isCompleted).toList();
        } else if (tabIndex == 1) {
          filteredDebts = allDebts
              .where((d) => d.debtType == DebtType.iOwe && !d.isCompleted)
              .toList();
        } else if (tabIndex == 2) {
          filteredDebts = allDebts
              .where((d) => d.debtType == DebtType.iAmOwed && !d.isCompleted)
              .toList();
        } else if (tabIndex == 3) {
          filteredDebts = allDebts.where((d) => d.isCompleted).toList();
        }

        if (filteredDebts.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.spacing20),
              child: Text(
                l10n.noDebtsYet,
                style: AppTextStyles.body2,
              ),
            ),
          );
        }

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spacing16,
          ),
          shrinkWrap: true,
          itemBuilder: (context, index) => DebtCard(debt: filteredDebts[index]),
          separatorBuilder: (context, index) => const Gap(AppSpacing.spacing12),
          itemCount: filteredDebts.length,
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text(l10n.noDebtsYet)),
    );
  }
}
