part of '../screens/dashboard_screen.dart';

class AnalyticChartReports extends ConsumerWidget {
  const AnalyticChartReports({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.spacing16,
        children: [
          Text(l10n.reports, style: AppTextStyles.heading6),
          const MoneyInsiderChart(),
          const SixMonthsIncomeExpenseChart(),
        ],
      ),
    );
  }
}
