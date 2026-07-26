import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pockaw/core/components/buttons/custom_icon_button.dart';
import 'package:pockaw/core/components/scaffolds/custom_scaffold.dart';
import 'package:pockaw/core/constants/app_colors.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/router/routes.dart';
import 'package:pockaw/features/debt/presentation/components/debt_card_holder.dart';
import 'package:pockaw/features/debt/presentation/components/debt_summary_card.dart';
import 'package:pockaw/features/debt/presentation/components/debt_tab_bar.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class DebtScreen extends HookConsumerWidget {
  const DebtScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return CustomScaffold(
      title: l10n.debts,
      showBackButton: true,
      actions: [
        CustomIconButton(
          context,
          onPressed: () {
            context.push(Routes.debtForm);
          },
          icon: HugeIcons.strokeRoundedPlusSign,
          themeMode: context.themeMode,
        ),
      ],
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.spacing16,
                vertical: AppSpacing.spacing12,
              ),
              child: DebtSummaryCard(),
            ),
            const DebtTabBar(),
            const Gap(AppSpacing.spacing12),
            Expanded(
              child: TabBarView(
                children: const [
                  ListViewHolder(tabIndex: 0),
                  ListViewHolder(tabIndex: 1),
                  ListViewHolder(tabIndex: 2),
                  ListViewHolder(tabIndex: 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListViewHolder extends StatelessWidget {
  final int tabIndex;
  const ListViewHolder({super.key, required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DebtCardHolder(tabIndex: tabIndex),
        const Gap(100),
      ],
    );
  }
}
