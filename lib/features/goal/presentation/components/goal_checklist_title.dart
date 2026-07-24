part of '../screens/goal_details_screen.dart';

class GoalChecklistTitle extends ConsumerWidget {
  const GoalChecklistTitle({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final sort = ref.watch(goalChecklistSortProvider);
    final sortNotifier = ref.read(goalChecklistSortProvider.notifier);
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing2),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(l10n.goalChecklist, style: AppTextStyles.body3),
                Text(l10n.holdItemToShowOptions, style: AppTextStyles.body5),
              ],
            ),
          ),
          CustomIconButton(
            context,
            icon: _buildIcon(sort),
            onPressed: () {
              context.openBottomSheet(
                child: CustomBottomSheet(
                  title: l10n.filterChecklist,
                  child: Column(
                    spacing: AppSpacing.spacing8,
                    children: [
                      MenuTileButton(
                        label: l10n.titleAsc,
                        icon: HugeIcons.strokeRoundedSortingAZ02,
                        suffixIcon: sort == GoalChecklistSort.titleAsc
                            ? HugeIcons.strokeRoundedCheckmarkCircle01
                            : HugeIcons.strokeRoundedCircle,
                        onTap: () {
                          sortNotifier.setSort(GoalChecklistSort.titleAsc);
                          context.pop();
                        },
                      ),
                      MenuTileButton(
                        label: l10n.titleDesc,
                        icon: HugeIcons.strokeRoundedSortingZA01,
                        suffixIcon: sort == GoalChecklistSort.titleDesc
                            ? HugeIcons.strokeRoundedCheckmarkCircle01
                            : HugeIcons.strokeRoundedCircle,
                        onTap: () {
                          sortNotifier.setSort(GoalChecklistSort.titleDesc);
                          context.pop();
                        },
                      ),
                      MenuTileButton(
                        label: l10n.cheapest,
                        icon: HugeIcons.strokeRoundedSorting19,
                        suffixIcon: sort == GoalChecklistSort.priceAsc
                            ? HugeIcons.strokeRoundedCheckmarkCircle01
                            : HugeIcons.strokeRoundedCircle,
                        onTap: () {
                          sortNotifier.setSort(GoalChecklistSort.priceAsc);
                          context.pop();
                        },
                      ),
                      MenuTileButton(
                        label: l10n.mostExpensive,
                        icon: HugeIcons.strokeRoundedSorting91,
                        suffixIcon: sort == GoalChecklistSort.priceDesc
                            ? HugeIcons.strokeRoundedCheckmarkCircle01
                            : HugeIcons.strokeRoundedCircle,
                        onTap: () {
                          sortNotifier.setSort(GoalChecklistSort.priceDesc);
                          context.pop();
                        },
                      ),
                      MenuTileButton(
                        label: l10n.completedChecklist,
                        icon: HugeIcons.strokeRoundedSortByDown02,
                        suffixIcon: sort == GoalChecklistSort.completed
                            ? HugeIcons.strokeRoundedCheckmarkCircle01
                            : HugeIcons.strokeRoundedCircle,
                        onTap: () {
                          sortNotifier.setSort(GoalChecklistSort.completed);
                          context.pop();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<List<dynamic>> _buildIcon(GoalChecklistSort sort) {
    switch (sort) {
      case GoalChecklistSort.titleAsc:
        return HugeIcons.strokeRoundedSortingAZ02;
      case GoalChecklistSort.titleDesc:
        return HugeIcons.strokeRoundedSortingZA01;
      case GoalChecklistSort.priceAsc:
        return HugeIcons.strokeRoundedSorting19;
      case GoalChecklistSort.priceDesc:
        return HugeIcons.strokeRoundedSorting91;
      case GoalChecklistSort.completed:
        return HugeIcons.strokeRoundedSortByDown02;
      case GoalChecklistSort.none:
        return HugeIcons.strokeRoundedSorting05;
    }
  }
}
