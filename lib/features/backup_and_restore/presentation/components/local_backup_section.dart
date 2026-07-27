part of '../../../settings/presentation/screens/backup_restore_screen.dart';

class LocalBackupSection extends HookConsumerWidget {
  const LocalBackupSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(backupControllerProvider);
    final l10n = AppLocalizations.of(context);

    return Column(
      spacing: AppSpacing.spacing8,
      children: [
        MenuTileButton(
          label: l10n.backupData,
          subtitle: Text(l10n.creatingLocalBackup),
          icon: HugeIcons.strokeRoundedDatabaseExport,
          suffixIcon: null,
          onTap: () {
            context.openBottomSheet(
              isScrollControlled: false,
              child: AlertBottomSheet(
                context: context,
                title: l10n.backupData,
                confirmText: l10n.save,
                onConfirm: () async {
                  Toast.show(
                    l10n.creatingLocalBackup,
                    type: ToastificationType.info,
                  );

                  ref.read(backupControllerProvider.notifier).backupLocally();

                  context.pop();
                },
                showCancelButton: false,
                content: BackupDialog(),
              ),
            );
          },
        ),
        MenuTileButton(
          label: l10n.restoreData,
          subtitle: Text(l10n.restoringFromZip),
          icon: HugeIcons.strokeRoundedDatabaseImport,
          onTap: () {
            context.openBottomSheet(
              isScrollControlled: false,
              child: AlertBottomSheet(
                title: l10n.restoreData,
                context: context,
                confirmText: l10n.restoreData,
                onConfirm: () async {
                  final success = await ref
                      .read(backupControllerProvider.notifier)
                      .restoreFromLocalFile();

                  if (success) {
                    if (context.mounted) {
                      context.pop();
                      context.replace(Routes.main);
                    }
                  }
                },
                showCancelButton: false,
                content: RestoreDialog(),
              ),
            );
          },
        ),
        // show local backup and restore info card. card contains backup directory and last action date time
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.spacing16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.radius12),
            border: Border.all(color: context.breakLineColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.localBackupInfo,
                style: AppTextStyles.body4.bold,
              ),
              const Gap(AppSpacing.spacing8),
              Text(
                l10n.backupDirectoryLabel(state.localDirectory ?? l10n.notSet),
                style: AppTextStyles.body4,
              ),
              const Gap(AppSpacing.spacing4),
              Text(
                l10n.lastBackupTimeLabel(state.lastLocalBackupTime != null
                    ? state.lastLocalBackupTime!.toDayMonthYearTime12Hour()
                    : l10n.noBackupsYet),
                style: AppTextStyles.body4,
              ),
              // last restore time
              const Gap(AppSpacing.spacing4),
              Text(
                l10n.lastRestoreTimeLabel(state.lastLocalRestoreTime != null
                    ? state.lastLocalRestoreTime!.toDayMonthYearTime12Hour()
                    : l10n.noRestoresYet),
                style: AppTextStyles.body4,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
