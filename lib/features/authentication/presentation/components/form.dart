part of '../screens/login_screen.dart';

class Form extends HookConsumerWidget {
  final TextEditingController nameField;
  const Form({super.key, required this.nameField});

  @override
  Widget build(BuildContext context, ref) {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          const Gap(AppSpacing.spacing56),
          const LoginImagePicker(),
          const Gap(AppSpacing.spacing20),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                l10n.getStarted,
                style: AppTextStyles.heading5,
                textAlign: TextAlign.center,
              ),
              const Gap(AppSpacing.spacing4),
              const GetStartedDescription(),
            ],
          ),
          const Gap(AppSpacing.spacing20),
          Column(
            spacing: AppSpacing.spacing16,
            children: [
              CustomTextField(
                context: context,
                controller: nameField,
                label: l10n.accountName,
                hint: 'John Doe',
                prefixIcon: HugeIcons.strokeRoundedTextSmallcaps,
              ),
              const CreateFirstWalletField(),
            ],
          ),
          const Gap(AppSpacing.spacing20),
          const LoginInfo(),
          const Gap(AppSpacing.spacing20),
          const GoogleSignInButton(),
          const Gap(AppSpacing.spacing56),
          const Gap(AppSpacing.spacing56),
        ],
      ),
    );
  }
}
