import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pockaw/core/components/tabs/custom_tab.dart';
import 'package:pockaw/core/components/tabs/custom_tab_bar.dart';
import 'package:pockaw/core/extensions/date_time_extension.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class TransactionTabBar extends HookConsumerWidget {
  final List<DateTime> monthsForTabs;

  const TransactionTabBar({super.key, required this.monthsForTabs});

  @override
  Widget build(BuildContext context, ref) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final now = DateTime.now(); // To pass to toMonthTabLabel

    return CustomTabBar(
      tabs: monthsForTabs
          .map(
            (monthDate) => CustomTab(
              label: monthDate.toMonthTabLabel(now, l10n, locale),
            ),
          )
          .toList(),
    );
  }
}
