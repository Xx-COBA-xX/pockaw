part of '../../screens/category_form_screen.dart';

class CategoryTitleField extends ConsumerWidget {
  const CategoryTitleField({super.key, required this.titleController});

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context, ref) {
    final l10n = AppLocalizations.of(context);
    return CustomTextField(
      context: context,
      controller: titleController, // Use the controller
      label: l10n.titleMax25,
      hint: l10n.newCategoryTitle,
      isRequired: true,
      prefixIcon: HugeIcons.strokeRoundedTextSmallcaps,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      maxLength: 25,
      customCounterText: '',
    );
  }
}
