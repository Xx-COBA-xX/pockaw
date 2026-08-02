import 'package:flutter/material.dart';
import 'package:pockaw/core/constants/app_colors.dart';
import 'package:pockaw/core/constants/app_radius.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';
import 'package:pockaw/core/extensions/double_extension.dart';

import 'package:pockaw/l10n/app_localizations.dart';

class BudgetTotalCard extends StatelessWidget {
  final double totalAmount;
  const BudgetTotalCard({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spacing8),
      decoration: BoxDecoration(
        color: context.secondaryBackground,
        border: Border.all(color: context.secondaryBorderLighter),
        borderRadius: BorderRadius.circular(AppRadius.radius8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.totalBudget,
            style: AppTextStyles.body5.copyWith(
              color: context.incomeText,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(totalAmount.toPriceFormat(), style: AppTextStyles.numericMedium),
        ],
      ),
    );
  }
}
