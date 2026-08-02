import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pockaw/core/components/form_fields/custom_select_field.dart';
import 'package:pockaw/core/database/database_provider.dart';
import 'package:pockaw/core/database/tables/category_table.dart';
import 'package:pockaw/core/router/routes.dart';
import 'package:pockaw/core/utils/logger.dart';
import 'package:pockaw/features/category/data/model/category_model.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class TransactionCategorySelector extends HookConsumerWidget {
  final TextEditingController controller;
  final Function(CategoryModel? parentCategory, CategoryModel? category)
  onCategorySelected;

  const TransactionCategorySelector({
    super.key,
    required this.controller,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return CustomSelectField(
      context: context,
      controller: controller,
      label: l10n.category,
      hint: l10n.categories,
      isRequired: true,
      prefixIcon: HugeIcons.strokeRoundedStructure01,
      onTap: () async {
        final category = await context.push<CategoryModel>(Routes.categoryList);
        Log.d(category?.toJson(), label: 'category selected via text field');
        if (category != null) {
          final db = ref.read(databaseProvider);
          if (category.hasParent) {
            db.categoryDao.getCategoryById(category.parentId!).then((
              parentCat,
            ) {
              onCategorySelected.call(parentCat?.toModel(), category);
            });
          } else {
            onCategorySelected.call(null, category);
          }
        }
      },
    );
  }
}
