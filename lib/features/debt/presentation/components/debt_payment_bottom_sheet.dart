import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pockaw/core/components/buttons/primary_button.dart';
import 'package:pockaw/core/components/dialogs/toast.dart';
import 'package:pockaw/core/components/form_fields/custom_confirm_checkbox.dart';
import 'package:pockaw/core/components/form_fields/custom_numeric_field.dart';
import 'package:pockaw/core/components/form_fields/custom_select_field.dart';
import 'package:pockaw/core/components/form_fields/custom_text_field.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';
import 'package:pockaw/core/database/database_provider.dart';
import 'package:pockaw/core/database/tables/category_table.dart';
import 'package:pockaw/core/extensions/double_extension.dart';
import 'package:pockaw/core/extensions/popup_extension.dart';
import 'package:pockaw/core/extensions/string_extension.dart';
import 'package:pockaw/core/extensions/text_style_extensions.dart';
import 'package:pockaw/features/debt/data/enum/debt_type.dart';
import 'package:pockaw/features/debt/data/model/debt_model.dart';
import 'package:pockaw/features/debt/data/model/debt_payment_model.dart';
import 'package:pockaw/features/debt/presentation/riverpod/debt_providers.dart';
import 'package:pockaw/features/transaction/data/model/transaction_model.dart';
import 'package:pockaw/features/wallet/data/model/wallet_model.dart';
import 'package:pockaw/features/wallet/riverpod/wallet_providers.dart';
import 'package:pockaw/features/wallet_switcher/presentation/components/wallet_picker_bottom_sheet.dart';
import 'package:pockaw/l10n/app_localizations.dart';
import 'package:toastification/toastification.dart';

class DebtPaymentBottomSheet extends HookConsumerWidget {
  final DebtModel debt;

  const DebtPaymentBottomSheet({super.key, required this.debt});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final activeWallet = ref.watch(activeWalletProvider).asData?.value;

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final amountController = useTextEditingController(
      text: debt.remainingAmount.toPriceFormat(),
    );
    final notesController = useTextEditingController();
    final walletController = useTextEditingController(text: debt.wallet.name);

    final selectedWallet = useState<WalletModel>(debt.wallet);
    final recordTransaction = useState(true);

    final isIOwe = debt.debtType == DebtType.iOwe;
    final promptTitle = isIOwe
        ? l10n.whichAccountDeductRepaymentFrom
        : l10n.whichAccountReceiveRepayment;

    void submitPayment() async {
      if (!(formKey.currentState?.validate() ?? false)) return;

      final paymentAmount = amountController.text.takeNumericAsDouble();
      if (paymentAmount <= 0) {
        Toast.show(
          l10n.amount,
          type: ToastificationType.warning,
        );
        return;
      }

      final walletToUse = selectedWallet.value;
      final payment = DebtPaymentModel(
        debtId: debt.id!,
        amount: paymentAmount,
        paymentDate: DateTime.now(),
        notes: notesController.text.trim().isEmpty
            ? null
            : notesController.text.trim(),
        wallet: walletToUse,
      );

      final debtDao = ref.read(debtDaoProvider);
      final db = ref.read(databaseProvider);

      try {
        await debtDao.addDebtPayment(payment, debt);

        // Record transaction & update wallet balance if enabled
        if (recordTransaction.value) {
          final txType = isIOwe ? TransactionType.expense : TransactionType.income;
          
          // Calculate new wallet balance:
          // If iOwe (repaying borrowed debt) -> Expense -> deduct from wallet
          // If iAmOwed (receiving repayment of loan user gave) -> Income -> add to original deducted wallet
          final balanceChange = isIOwe ? -paymentAmount : paymentAmount;
          final newBalance = walletToUse.balance + balanceChange;
          final updatedWallet = walletToUse.copyWith(balance: newBalance);
          await db.walletDao.updateWallet(updatedWallet);

          if (activeWallet?.id == walletToUse.id) {
            ref.read(activeWalletProvider.notifier).setActiveWallet(updatedWallet);
          }

          final categories = await db.categoryDao.getAllCategories();
          final targetCategory = categories.firstWhere(
            (c) {
              final title = c.title.toLowerCase();
              return title == 'debts' ||
                  title.contains('debt') ||
                  c.title.contains('ديون') ||
                  c.title.contains('قرض');
            },
            orElse: () => categories.firstWhere(
              (c) => c.title.toLowerCase().contains('finance'),
              orElse: () => categories.first,
            ),
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
              wallet: updatedWallet,
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
            Text(
              promptTitle,
              style: AppTextStyles.body4.bold,
            ),
            CustomSelectField(
              context: context,
              controller: walletController,
              label: l10n.selectAccount,
              hint: l10n.selectAccount,
              prefixIcon: HugeIcons.strokeRoundedWallet01,
              onTap: () async {
                final picked = await context.openBottomSheet<WalletModel?>(
                  child: WalletPickerBottomSheet(
                    selectedWallet: selectedWallet.value,
                    title: promptTitle,
                  ),
                );
                if (picked != null) {
                  selectedWallet.value = picked;
                  walletController.text = picked.name;
                }
              },
            ),
            CustomTextField(
              controller: notesController,
              label: l10n.writeSimpleDescription,
              hint: l10n.writeSimpleDescription,
              prefixIcon: HugeIcons.strokeRoundedNote01,
            ),
            CustomConfirmCheckbox(
              title: l10n.recordTransactionInWallet,
              subtitle: selectedWallet.value.name,
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
