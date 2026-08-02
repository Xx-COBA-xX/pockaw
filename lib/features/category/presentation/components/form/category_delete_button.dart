part of '../../screens/category_form_screen.dart';

class CategoryDeleteButton extends ConsumerWidget {
  const CategoryDeleteButton({
    super.key,
    required this.categoryFuture,
    required this.categoryId,
  });

  final AsyncSnapshot<Category?> categoryFuture;
  final int? categoryId;

  @override
  Widget build(BuildContext context, ref) {
    final l10n = AppLocalizations.of(context);
    return TextButton(
      child: Text(
        l10n.delete,
        style: AppTextStyles.body2.copyWith(color: AppColors.red),
      ),
      onPressed: () {
        context.openBottomSheet(
          child: AlertBottomSheet(
            title: l10n.deleteCategory,
            content: Text(
              l10n.deleteCategoryContent,
              style: AppTextStyles.body2,
              textAlign: TextAlign.center,
            ),
            confirmText: l10n.delete,
            onConfirm: () {
              final categories = ref.read(hierarchicalCategoriesProvider).value;

              CategoryModel categoryModel = categoryFuture.data!.toModel();

              if (categories != null) {
                categoryModel = categories.firstWhere(
                  (e) => e.id == categoryId,
                );

                Log.d(
                  categoryModel.subCategories
                      ?.map((e) => '${e.id} => ${e.title}')
                      .toList(),
                  label: 'sub categories',
                );
              }

              CategoryFormService().delete(
                context,
                ref,
                categoryModel: categoryModel,
              );
              context.pop();
              context.pop();
            },
          ),
        );
      },
    );
  }
}
