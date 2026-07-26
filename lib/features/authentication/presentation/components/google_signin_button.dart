import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pockaw/core/components/buttons/custom_text_button.dart';
import 'package:pockaw/core/services/connectivity_service/connectivity_service.dart';
import 'package:pockaw/features/authentication/presentation/riverpod/auth_provider.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // use future builder to show button only if connection is available
    final connectionStatus = ref.watch(connectionStatusProvider);

    if (connectionStatus.value == ConnectionStatus.offline) {
      return const SizedBox.shrink();
    }

    final l10n = AppLocalizations.of(context);
    return CustomTextButton(
      label: l10n.signInWithGoogle,
      icon: Image.asset('assets/icon/search.png', width: 24, height: 24),
      onPressed: () => ref
          .read(authStateProvider.notifier)
          .signInWithGoogle(context: context),
    );
  }
}
