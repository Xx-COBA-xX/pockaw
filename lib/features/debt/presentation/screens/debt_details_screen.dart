import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pockaw/core/components/bottom_sheets/alert_bottom_sheet.dart';
import 'package:pockaw/core/components/buttons/custom_icon_button.dart';
import 'package:pockaw/core/components/buttons/primary_button.dart';
import 'package:pockaw/core/components/dialogs/toast.dart';
import 'package:pockaw/core/components/scaffolds/custom_scaffold.dart';
import 'package:pockaw/core/constants/app_colors.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';
import 'package:pockaw/core/extensions/popup_extension.dart';
import 'package:pockaw/core/router/routes.dart';
import 'package:pockaw/features/debt/presentation/components/debt_card.dart';
import 'package:pockaw/features/debt/presentation/components/debt_payment_bottom_sheet.dart';
import 'package:pockaw/features/debt/presentation/components/debt_payment_tile.dart';
import 'package:pockaw/features/debt/presentation/riverpod/debt_providers.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class DebtDetailsScreen extends ConsumerWidget {
  final int debtId;
  const DebtDetailsScreen({super.key, required this.debtId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final debtAsync = ref.watch(debtDetailsProvider(debtId));
    final paymentsAsync = ref.watch(debtPaymentsProvider(debtId));

    return debtAsync.when(
      data: (debt) {
        if (debt == null) {
          return CustomScaffold(
            title: l10n.debts,
            showBackButton: true,
            body: Center(child: Text(l10n.noDebtsYet)),
          );
        }

        return CustomScaffold(
          title: debt.personName,
          showBackButton: true,
          actions: [
            CustomIconButton(
              context,
              onPressed: () {
                context.push('${Routes.debtForm}/edit/$debtId');
              },
              icon: HugeIcons.strokeRoundedEdit02,
              themeMode: context.themeMode,
            ),
            CustomIconButton(
              context,
              onPressed: () {
                context.openBottomSheet(
                  child: AlertBottomSheet(
                    title: l10n.deleteDebt,
                    content: Text(
                      l10n.confirmDeleteDebt,
                      style: AppTextStyles.body2,
                    ),
                    onConfirm: () async {
                      context.pop(); // close sheet
                      context.pop(); // close screen
                      await ref.read(debtDaoProvider).deleteDebt(debtId);
                      Toast.show(l10n.debtDeleted);
                    },
                  ),
                );
              },
              icon: HugeIcons.strokeRoundedDelete02,
              themeMode: context.themeMode,
            ),
          ],
          body: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.spacing16,
                  AppSpacing.spacing12,
                  AppSpacing.spacing16,
                  120,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DebtCard(debt: debt, editing: true),
                    const Gap(AppSpacing.spacing20),
                    Text(
                      l10n.paymentHistory,
                      style: AppTextStyles.body3,
                    ),
                    const Gap(AppSpacing.spacing12),
                    paymentsAsync.when(
                      data: (payments) {
                        if (payments.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.spacing20),
                              child: Text(
                                l10n.noPaymentsYet,
                                style: AppTextStyles.body4.copyWith(
                                  color: context.secondaryText,
                                ),
                              ),
                            ),
                          );
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: payments.length,
                          itemBuilder: (context, index) {
                            final payment = payments[index];
                            return DebtPaymentTile(
                              payment: payment,
                              onDelete: () async {
                                await ref
                                    .read(debtDaoProvider)
                                    .deleteDebtPayment(payment.id!, debt);
                                Toast.show(l10n.paymentDeleted);
                              },
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const Gap(AppSpacing.spacing8),
                        );
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (err, stack) =>
                          Center(child: Text('Error: $err')),
                    ),
                  ],
                ),
              ),
              if (!debt.isCompleted)
                PrimaryButton(
                  label: l10n.addPayment,
                  onPressed: () {
                    context.openBottomSheet(
                      child: DebtPaymentBottomSheet(debt: debt),
                    );
                  },
                ).floatingBottomContained,
            ],
          ),
        );
      },
      loading: () => CustomScaffold(
        title: l10n.debts,
        showBackButton: true,
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => CustomScaffold(
        title: l10n.debts,
        showBackButton: true,
        body: Center(child: Text(l10n.noDebtsYet)),
      ),
    );
  }
}
