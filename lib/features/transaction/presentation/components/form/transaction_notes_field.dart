import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pockaw/core/components/form_fields/custom_text_field.dart';

import 'package:pockaw/l10n/app_localizations.dart';

class TransactionNotesField extends HookConsumerWidget {
  final TextEditingController controller;

  const TransactionNotesField({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return CustomTextField(
      context: context,
      controller: controller,
      label: l10n.writeNoteHint,
      hint: l10n.writeHere,
      prefixIcon: HugeIcons.strokeRoundedNote02,
      minLines: 1,
      maxLines: 3,
      maxLength: 500,
      customCounterText: '',
    );
  }
}
