import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pockaw/core/components/bottom_sheets/custom_bottom_sheet.dart';
import 'package:pockaw/core/constants/app_colors.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';
import 'package:pockaw/core/extensions/double_extension.dart';
import 'package:pockaw/core/extensions/text_style_extensions.dart';
import 'package:pockaw/features/wallet/data/model/wallet_model.dart';
import 'package:pockaw/features/wallet/riverpod/wallet_providers.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class WalletPickerBottomSheet extends ConsumerWidget {
  final WalletModel? selectedWallet;
  final String? title;

  const WalletPickerBottomSheet({
    super.key,
    this.selectedWallet,
    this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allWalletsAsync = ref.watch(allWalletsStreamProvider);
    final l10n = AppLocalizations.of(context);

    return CustomBottomSheet(
      title: title ?? l10n.selectAccount,
      child: allWalletsAsync.when(
        data: (wallets) {
          if (wallets.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.spacing16),
                child: Text(l10n.noWalletSelected),
              ),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: AppSpacing.spacing16),
            itemCount: wallets.length,
            itemBuilder: (context, index) {
              final wallet = wallets[index];
              final bool isSelected = selectedWallet?.id == wallet.id;

              return ListTile(
                title: Text(
                  wallet.name,
                  style: AppTextStyles.body2.bold.copyWith(
                    color: context.secondaryText,
                  ),
                ),
                dense: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.spacing12),
                  side: BorderSide(color: context.secondaryBorderLighter),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.spacing16,
                ),
                subtitle: Text(
                  '${wallet.currencyByIsoCode(ref).symbol} ${wallet.balance.toPriceFormat()}',
                  style: AppTextStyles.body3,
                ),
                trailing: HugeIcon(
                  icon: isSelected
                      ? HugeIcons.strokeRoundedCheckmarkCircle01
                      : HugeIcons.strokeRoundedCircle,
                  color: isSelected ? Colors.green : Colors.grey,
                ),
                onTap: () {
                  context.pop(wallet);
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 1),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
