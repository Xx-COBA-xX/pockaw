import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pockaw/core/components/buttons/primary_button.dart';
import 'package:pockaw/core/components/dialogs/toast.dart';
import 'package:pockaw/core/components/form_fields/custom_confirm_checkbox.dart';
import 'package:pockaw/core/components/form_fields/custom_numeric_field.dart';
import 'package:pockaw/core/components/form_fields/custom_text_field.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';
import 'package:pockaw/core/database/database_provider.dart';
import 'package:pockaw/core/database/tables/category_table.dart';
import 'package:pockaw/core/extensions/double_extension.dart';
import 'package:pockaw/core/extensions/string_extension.dart';
import 'package:pockaw/features/debt/data/enum/debt_type.dart';
import 'package:pockaw/features/debt/data/model/debt_model.dart';
import 'package:pockaw/features/debt/data/model/debt_payment_model.dart';
import 'package:pockaw/features/debt/presentation/riverpod/debt_providers.dart';
import 'package:pockaw/features/transaction/data/model/transaction_model.dart';
import 'package:pockaw/l10n/app_localizations.dart';
import 'package:toastification/toastification.dart';

class DebtPaymentBottomSheet extends HookConsumerWidget {
  final DebtModel debt;

  const DebtPaymentBottomSheet({super.key, required this.debt});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final amountController = useTextEditingController(
      text: debt.remainingAmount.toPriceFormat(),
    );
    final notesController = useTextEditingController();
    final recordTransaction = useState(true);

    void submitPayment() async {
      if (!(formKey.currentState?.validate() ?? false)) return;

      final paymentAmount = amountController.text.takeNumericAsDouble();
      if (paymentAmount <= 0) {
        Toast.show(
          'Please enter a valid amount',
          type: ToastificationType.warning,
        );
        return;
      }

      final payment = DebtPaymentModel(
        debtId: debt.id!,
        amount: paymentAmount,
        paymentDate: DateTime.now(),
        notes: notesController.text.trim().isEmpty
            ? null
            : notesController.text.trim(),
        wallet: debt.wallet,
      );

      final debtDao = ref.read(debtDaoProvider);
      final db = ref.read(databaseProvider);

      try {
        await debtDao.addDebtPayment(payment, debt);

        // Record automatic transaction in wallet if checked
        if (recordTransaction.value) {
          final isIOwe = debt.debtType == DebtType.iOwe;
          // Paying an 'iOwe' debt is an Expense. Receiving an 'iAmOwed' debt payment is Income.
          final txType = isIOwe ? TransactionType.expense : TransactionType.income;
          final categories = await db.categoryDao.getAllCategories();
          final targetCategory = categories.firstWhere(
            (c) => c.title.toLowerCase().contains('debt') || c.title.contains('ديون'),
            orElse: () => categories.first,
          );

          await db.transactionDao.addTransaction(
            TransactionModel(
              transactionType: txType,
              amount: paymentAmount,
              date: DateTime.now(),
              title: isIOwe
                  ? '${l10n.addPayment} - ${debt.personName}'
                  : '${l10n.paymentHistory} - ${debt.personName}',
              category: targetCategory.toModel(),
              wallet: debt.wallet,
              notes: notesController.text.trim().isEmpty
                  ? null
                  : notesController.text.trim(),
            ),
          );
        }

        Toast.show(l10n.paymentAdded, type: ToastificationType.success);
        if (context.mounted) context.pop();
      } catch (e) {
        Toast.show('Error: $e', type: ToastificationType.error);
      }
    }

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.spacing16,
        right: AppSpacing.spacing16,
        top: AppSpacing.spacing16,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.spacing24,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.spacing16,
          children: [
            Text(
              l10n.addPayment,
              style: AppTextStyles.heading4,
            ),
            CustomNumericField(
              controller: amountController,
              label: l10n.amount,
              icon: HugeIcons.strokeRoundedCoins01,
              appendCurrencySymbolToHint: true,
              isRequired: true,
            ),
            CustomTextField(
              controller: notesController,
              label: l10n.writeSimpleDescription,
              hint: l10n.writeSimpleDescription,
              prefixIcon: HugeIcons.strokeRoundedNote01,
            ),
            CustomConfirmCheckbox(
              title: l10n.recordTransactionInWallet,
              subtitle: debt.wallet.name,
              checked: recordTransaction.value,
              onChanged: () =>
                  recordTransaction.value = !recordTransaction.value,
            ),
            PrimaryButton(
              label: l10n.confirm,
              onPressed: submitPayment,
            ),
          ],
        ),
      ),
    );
  }
}
