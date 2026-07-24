import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';
import 'package:pockaw/features/goal/presentation/components/goal_card.dart';
import 'package:pockaw/features/goal/presentation/riverpod/goals_list_provider.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class GoalPinnedHolder extends ConsumerWidget {
  const GoalPinnedHolder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncGoals = ref.watch(
      pinnedGoalsProvider,
    ); // <-- Use pinnedGoalsProvider
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spacing16,
            ),
            child: Text(l10n.pinnedGoals, style: AppTextStyles.heading6),
          ),
          const Gap(AppSpacing.spacing16),
          asyncGoals.when(
            data: (data) {
              if (data.isEmpty) {
                return Center(
                  child: Text(l10n.noPinnedGoals, style: AppTextStyles.body3),
                );
              }

              if (data.length == 1) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing16,
                  ),
                  width: double.infinity,
                  child: GoalCard(goal: data.first),
                );
              }

              return SizedBox(
                height: 150,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing8,
                  ),
                  itemCount: data.take(5).length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return AspectRatio(
                      aspectRatio: 6 / 3,
                      child: GoalCard(goal: data[index]),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      Gap(AppSpacing.spacing12),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) =>
                Center(child: Text('Error: $e', style: AppTextStyles.body3)),
          ),
        ],
      ),
    );
  }
}
