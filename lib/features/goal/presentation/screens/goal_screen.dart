import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pockaw/core/components/buttons/custom_icon_button.dart';
import 'package:pockaw/core/components/scaffolds/custom_scaffold.dart';
import 'package:pockaw/core/constants/app_colors.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/extensions/popup_extension.dart';
import 'package:pockaw/features/goal/presentation/components/goal_card.dart';
import 'package:pockaw/features/goal/presentation/riverpod/goals_list_provider.dart';
import 'package:pockaw/features/goal/presentation/screens/goal_form_dialog.dart';

import 'package:pockaw/l10n/app_localizations.dart';

class GoalScreen extends ConsumerWidget {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncGoals = ref.watch(goalsListProvider);
    final l10n = AppLocalizations.of(context);

    return CustomScaffold(
      showBackButton: false,
      title: l10n.savingsGoals,
      actions: [
        CustomIconButton(
          context,
          onPressed: () {
            context.openBottomSheet(child: GoalFormDialog());
          },
          icon: HugeIcons.strokeRoundedPlusSign,
          themeMode: context.themeMode,
        ),
      ],
      body: asyncGoals.when(
        data: (goals) {
          if (goals.isEmpty) {
            return Center(child: Text(l10n.noSavingsGoalsSetUp));
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spacing16,
            ),
            itemCount: goals.length,
            itemBuilder: (_, i) => GoalCard(goal: goals[i]),
            separatorBuilder: (_, _) => const Gap(AppSpacing.spacing12),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
