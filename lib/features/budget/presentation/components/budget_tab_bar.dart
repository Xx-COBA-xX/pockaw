import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pockaw/core/components/tabs/custom_tab.dart';
import 'package:pockaw/core/components/tabs/custom_tab_bar.dart';
import 'package:pockaw/core/extensions/date_time_extension.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class BudgetTabBar extends HookConsumerWidget {
  final List<DateTime> budgetPeriods;
  const BudgetTabBar({super.key, required this.budgetPeriods});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final now = DateTime.now();

    return CustomTabBar(
      tabs: budgetPeriods
          .map(
            (period) => CustomTab(
              label: period.toMonthTabLabel(now, l10n, locale),
            ),
          )
          .toList(),
    );
  }
}
