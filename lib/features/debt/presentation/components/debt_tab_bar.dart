import 'package:flutter/material.dart';
import 'package:pockaw/core/components/tabs/custom_tab.dart';
import 'package:pockaw/core/components/tabs/custom_tab_bar.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class DebtTabBar extends StatelessWidget {
  const DebtTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return CustomTabBar(
      tabs: [
        CustomTab(label: l10n.allDebts),
        CustomTab(label: l10n.iOwe),
        CustomTab(label: l10n.iAmOwed),
        CustomTab(label: l10n.completedDebts),
      ],
    );
  }
}
