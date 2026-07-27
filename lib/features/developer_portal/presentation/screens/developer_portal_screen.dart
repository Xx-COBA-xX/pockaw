import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pockaw/core/components/bottom_sheets/alert_bottom_sheet.dart';
import 'package:pockaw/core/components/buttons/menu_tile_button.dart';
import 'package:pockaw/core/components/loading_indicators/loading_indicator.dart';
import 'package:pockaw/core/components/scaffolds/custom_scaffold.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';
import 'package:pockaw/core/database/database_provider.dart';
import 'package:pockaw/core/extensions/popup_extension.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class DeveloperPortalScreen extends HookConsumerWidget {
  const DeveloperPortalScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    final l10n = AppLocalizations.of(context);

    return CustomScaffold(
      title: l10n.developerPortal,
      body: isLoading.value
          ? const Center(child: LoadingIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.spacing16,
                vertical: AppSpacing.spacing20,
              ),
              child: Column(
                spacing: AppSpacing.spacing16,
                children: [
                  Text(
                    l10n.developerPortalWarning,
                    style: AppTextStyles.body2.copyWith(color: Colors.orange),
                  ),
                  MenuTileButton(
                    label: l10n.resetCategories,
                    icon: HugeIcons.strokeRoundedStructure01,
                    onTap: () async {
                      context.openBottomSheet(
                        isScrollControlled: false,
                        child: AlertBottomSheet(
                          title: l10n.resetCategories,
                          content: Text(
                            l10n.confirmResetCategories,
                            style: AppTextStyles.body2,
                          ),
                          onConfirm: () async {
                            isLoading.value = true;
                            context.pop();
                            final db = ref.read(databaseProvider);
                            await db.resetCategories();
                            isLoading.value = false;
                          },
                        ),
                      );
                    },
                  ),
                  MenuTileButton(
                    label: l10n.resetWallets,
                    icon: HugeIcons.strokeRoundedWallet02,
                    onTap: () async {
                      context.openBottomSheet(
                        isScrollControlled: false,
                        child: AlertBottomSheet(
                          title: l10n.resetWallets,
                          content: Text(
                            l10n.confirmResetWallets,
                            style: AppTextStyles.body2,
                          ),
                          onConfirm: () async {
                            isLoading.value = true;
                            context.pop();
                            final db = ref.read(databaseProvider);
                            await db.resetWallets();
                            isLoading.value = false;
                          },
                        ),
                      );
                    },
                  ),
                  MenuTileButton(
                    label: l10n.resetDatabase,
                    icon: HugeIcons.strokeRoundedDeletePutBack,
                    onTap: () {
                      context.openBottomSheet(
                        isScrollControlled: false,
                        child: AlertBottomSheet(
                          title: l10n.resetDatabase,
                          content: Text(
                            l10n.confirmResetDatabase,
                            style: AppTextStyles.body2,
                          ),
                          onConfirm: () async {
                            isLoading.value = true;
                            context.pop();
                            final db = ref.read(databaseProvider);
                            await db.clearAllDataAndReset();
                            await db.populateData();
                            isLoading.value = false;
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
