import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pockaw/core/components/buttons/button_chip.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/features/transaction/data/model/transaction_model.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class TransactionTypeSelector extends HookConsumerWidget {
  final TransactionType selectedType;
  final ValueChanged<TransactionType> onTypeSelected;

  const TransactionTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: AppSpacing.spacing4,
      children: TransactionType.values.map((type) {
        String label;
        switch (type) {
          case TransactionType.income:
            label = l10n.income;
            break;
          case TransactionType.expense:
            label = l10n.expense;
            break;
          case TransactionType.transfer:
            label = l10n.transfer;
            break;
        }
        return Expanded(
          child: ButtonChip(
            label: label,
            active: selectedType == type,
            onTap: () => onTypeSelected(type),
          ),
        );
      }).toList(),
    );
  }
}
