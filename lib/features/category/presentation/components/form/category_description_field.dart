part of '../../screens/category_form_screen.dart';

class CategoryDescriptionField extends StatelessWidget {
  const CategoryDescriptionField({
    super.key,
    required this.descriptionController,
  });

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CustomTextField(
      context: context,
      label: l10n.descriptionMax50,
      hint: l10n.writeSimpleDescription,
      controller: descriptionController, // Use the controller
      prefixIcon: HugeIcons.strokeRoundedNote,
      minLines: 1,
      maxLines: 3,
      maxLength: 50,
      customCounterText: '',
    );
  }
}
