part of '../screens/goal_details_screen.dart';

class GoalChecklist extends StatelessWidget {
  final List<ChecklistItemModel> items;
  const GoalChecklist({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (items.isEmpty) {
      return Center(child: Text(l10n.noChecklistItems));
    }
    return ListView.separated(
      itemCount: items.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => GoalChecklistItem(item: items[index]),
      separatorBuilder: (context, index) => const Gap(AppSpacing.spacing8),
    );
  }
}
