import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pockaw/core/components/bottom_sheets/alert_bottom_sheet.dart';
import 'package:pockaw/core/components/buttons/primary_button.dart';
import 'package:pockaw/core/components/form_fields/custom_text_field.dart';
import 'package:pockaw/core/components/loading_indicators/loading_indicator.dart';
import 'package:pockaw/core/components/scaffolds/custom_scaffold.dart';
import 'package:pockaw/core/constants/app_colors.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';
import 'package:pockaw/core/extensions/popup_extension.dart';
import 'package:pockaw/core/extensions/text_style_extensions.dart';
import 'package:pockaw/core/router/routes.dart';
import 'package:pockaw/core/services/keyboard_service/virtual_keyboard_service.dart';
import 'package:pockaw/core/utils/logger.dart';
import 'package:pockaw/l10n/app_localizations.dart';
import 'package:pockaw/features/authentication/presentation/riverpod/auth_provider.dart';
import 'package:toastification/toastification.dart';

class AccountDeletionLoadingNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setLoading(bool v) => state = v;
}

final accountDeletionLoadingProvider =
    NotifierProvider.autoDispose<AccountDeletionLoadingNotifier, bool>(
      AccountDeletionLoadingNotifier.new,
    );

class AccountDeletionScreen extends HookConsumerWidget {
  const AccountDeletionScreen({super.key});

  Future<void> _showConfirmationSheet(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final l10n = AppLocalizations.of(context);
    KeyboardService.closeKeyboard();
    context.openBottomSheet(
      child: AlertBottomSheet(
        context: context,
        title: l10n.confirmAccountDeletion,
        confirmText: l10n.deleteAccount,
        content: Text(
          l10n.actionCannotBeUndone,
          textAlign: TextAlign.center,
          style: AppTextStyles.body2,
        ),
        onConfirm: () {
          context.pop(); // close this dialog
          _performAccountDeletion(ref, context);
        },
      ),
    );
  }

  Future<void> _performAccountDeletion(
    WidgetRef ref,
    BuildContext context,
  ) async {
    ref.read(accountDeletionLoadingProvider.notifier).setLoading(true);
    await Future.delayed(Duration(milliseconds: 1200));

    try {
      await ref.read(authStateProvider.notifier).deleteData();
      Log.i('User logged out.');

      // Dismiss loading dialog
      if (context.mounted) Navigator.of(context, rootNavigator: true).pop();

      // Navigate to login screen
      if (context.mounted) context.go(Routes.getStarted);
      Log.i('Navigated to login screen.');
    } catch (e) {
      Log.e('Error during account deletion', label: 'delete account');
      // Show error message
      if (context.mounted) {
        toastification.show(
          description: Text('Error deleting account: ${e.toString()}'),
        );
      }
    } finally {
      // Ensure loading state is reset.
      // If the widget is disposed (e.g. due to navigation), autoDispose handles the provider.
      // If still mounted (e.g. error occurred), this hides the overlay.
      ref.read(accountDeletionLoadingProvider.notifier).setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isLoading = ref.watch(accountDeletionLoadingProvider);
    final currentUser = ref.read(authStateProvider);

    final userName = currentUser.name;
    final isChallengeMet = useState(false); // Initialize to false

    return Stack(
      children: [
        CustomScaffold(
          title: l10n.deleteAccount,
          showBalance: false,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spacing16,
              vertical: AppSpacing.spacing20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.accountDeletionWarning,
                  style: AppTextStyles.body3.bold.copyWith(
                    color: AppColors.red500,
                  ),
                ),
                const Gap(AppSpacing.spacing12),
                Text(
                  l10n.accountDeletionDescription,
                  style: AppTextStyles.body3,
                ),
                const Gap(AppSpacing.spacing16),
                Text(
                  l10n.typeYourNameToContinue(userName),
                  style: AppTextStyles.body3,
                ),
                const Gap(AppSpacing.spacing8),
                CustomTextField(
                  context: context,
                  hint: l10n.enterYourUsername,
                  label: l10n.challengeConfirmation,
                  onChanged: (value) {
                    isChallengeMet.value = value == userName;
                  },
                ),
                const Spacer(),
                PrimaryButton(
                  label: l10n.deleteMyData,
                  onPressed: isChallengeMet.value
                      ? () => _showConfirmationSheet(context, ref)
                      : null,
                ),
              ],
            ),
          ),
        ),
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withAlpha(150), // Semi-transparent overlay
              child: Center(child: LoadingIndicator(color: Colors.white)),
            ),
          ),
      ],
    );
  }
}
