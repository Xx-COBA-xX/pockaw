import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pockaw/core/components/buttons/button_state.dart';
import 'package:pockaw/core/components/buttons/primary_button.dart';
import 'package:pockaw/core/components/scaffolds/custom_scaffold.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/extensions/popup_extension.dart';
import 'package:pockaw/features/category/presentation/riverpod/category_providers.dart';
import 'package:pockaw/features/category/presentation/screens/category_form_screen.dart';
import 'package:pockaw/features/category_picker/presentation/components/category_dropdown.dart';

import 'package:pockaw/l10n/app_localizations.dart';

class CategoryPickerScreen extends ConsumerWidget {
  final bool isManageCategories;
  final bool isPickingParent;
  const CategoryPickerScreen({
    super.key,
    this.isManageCategories = false,
    this.isPickingParent = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return CustomScaffold(
      title: isManageCategories ? l10n.manageCategories : l10n.categories,
      showBalance: false,
      body: Column(
        children: [
          /* if (!isManageCategories)
            Container(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.spacing20,
                AppSpacing.spacing0,
                AppSpacing.spacing20,
                AppSpacing.spacing12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: ButtonChip(label: 'Expense', active: true)),
                  Gap(AppSpacing.spacing12),
                  Expanded(child: ButtonChip(label: 'Income')),
                ],
              ),
            ), */
          Expanded(
            child: ref
                .watch(hierarchicalCategoriesProvider)
                .when(
                  data: (categories) {
                    if (categories.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.spacing20),
                          child: Text(l10n.noCategoriesFound),
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: EdgeInsets.fromLTRB(
                        AppSpacing.spacing16,
                        0,
                        AppSpacing.spacing16,
                        150,
                      ),
                      shrinkWrap: true,
                      itemCount: categories.length,
                      itemBuilder: (context, index) => CategoryDropdown(
                        category: categories[index],
                        isManageCategory: isManageCategories,
                      ),
                      separatorBuilder: (context, index) =>
                          const Gap(AppSpacing.spacing12),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) =>
                      Center(child: Text('Error loading categories: $error')),
                ),
          ),
          if (!isPickingParent)
            PrimaryButton(
              label:  l10n.addAnewCategory,
              state: ButtonState.outlinedActive,
              onPressed: () {
                ref.read(selectedParentCategoryProvider.notifier).clear();
                context.openBottomSheet(child: CategoryFormScreen());
              },
            ).contained,
        ],
      ),
    );
  }
}
