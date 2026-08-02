import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pockaw/core/components/form_fields/custom_text_field.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class TransactionTitleField extends HookConsumerWidget {
  final TextEditingController controller;
  final bool isEditing;

  const TransactionTitleField({
    super.key,
    required this.controller,
    this.isEditing = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return CustomTextField(
      context: context,
      controller: controller,
      label: l10n.titleMax50,
      hint: l10n.lunchWithMyFriends,
      prefixIcon: HugeIcons.strokeRoundedArrangeByLettersAZ,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      isRequired: true,
      autofocus: !isEditing,
      maxLength: 50,
      customCounterText: '',
    );
  }
}
