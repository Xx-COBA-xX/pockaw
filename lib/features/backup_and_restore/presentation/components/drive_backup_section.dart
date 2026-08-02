part of '../../../settings/presentation/screens/backup_restore_screen.dart';

class DriveBackupSection extends ConsumerWidget {
  const DriveBackupSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(backupControllerProvider);
    final notifier = ref.read(backupControllerProvider.notifier);
    final connectionStatus = ref.watch(connectionStatusProvider);
    final l10n = AppLocalizations.of(context);

    return Column(
      spacing: AppSpacing.spacing8,
      children: [
        MenuTileButton(
          label: l10n.backupData,
          subtitle: Text(l10n.backupData),
          icon: HugeIcons.strokeRoundedCloudUpload,
          disabled: connectionStatus.value == ConnectionStatus.offline,
          onTap: () {
            if (state.status == BackupStatus.loading ||
                connectionStatus.value == ConnectionStatus.offline) {
              return;
            }

            context.openBottomSheet(
              isScrollControlled: false,
              child: AlertBottomSheet(
                title: l10n.backupData,
                context: context,
                confirmText: l10n.save,
                showCancelButton: false,
                content: SizedBox(
                  width: context.screenSize.width * 0.7,
                  child: Text(
                    l10n.backupNoticeFormat,
                    style: AppTextStyles.body3,
                  ),
                ),
                onConfirm: () async {
                  context.pop();
                  await notifier.backupToDrive();
                },
              ),
            );
          },
        ),
        MenuTileButton(
          label: l10n.restoreData,
          icon: HugeIcons.strokeRoundedCloudDownload,
          subtitle: Text(l10n.restoreData),
          disabled: connectionStatus.value == ConnectionStatus.offline,
          onTap: () {
            if (state.status == BackupStatus.loading ||
                connectionStatus.value == ConnectionStatus.offline) {
              return;
            }

            context.openBottomSheet(
              isScrollControlled: false,
              child: AlertBottomSheet(
                title: l10n.restoreData,
                context: context,
                confirmText: l10n.restoreData,
                showCancelButton: false,
                content: SizedBox(
                  width: context.screenSize.width * 0.7,
                  child: Text(
                    l10n.restoreNoticeFormat,
                    style: AppTextStyles.body3,
                  ),
                ),
                onConfirm: () async {
                  context.pop();
                  await notifier.fetchDriveBackups();
                  if (context.mounted) {
                    context.openBottomSheet(
                      isScrollControlled: false,
                      child: AlertBottomSheet(
                        title: l10n.restoreData,
                        context: context,
                        confirmText: l10n.restoreData,
                        showCancelButton: false,
                        content: SizedBox(
                          width: context.screenSize.height * 0.7,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.driveBackups.length,
                            itemBuilder: (context, index) {
                              final backup = state.driveBackups[index];
                              return ListTile(
                                title: Text(
                                  l10n.backupFromDate(
                                    backup.modifiedTime
                                            ?.toLocal()
                                            .toString()
                                            .split('.')
                                            .first ??
                                        l10n.unknownDate,
                                  ),
                                ),
                                subtitle: Text(
                                  l10n.backupSizeLabel(
                                    (backup.size > 0)
                                        ? '${(backup.size / (1024 * 1024)).toStringAsFixed(2)} MB'
                                        : l10n.unknownSize,
                                  ),
                                ),
                                onTap: () async {
                                  context.pop();
                                  await notifier.restoreFromDrive(backup.id);
                                },
                              );
                            },
                          ),
                        ),
                        onConfirm: () async {
                          context.pop();
                        },
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
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
                l10n.googleDriveBackupInfo,
                style: AppTextStyles.body4.bold,
              ),
              const Gap(AppSpacing.spacing8),
              Text(
                l10n.backupFileLabel(state.driveDirectory ?? l10n.notSet),
                style: AppTextStyles.body4,
              ),
              const Gap(AppSpacing.spacing4),
              Text(
                l10n.lastBackupTimeLabel(state.lastDriveBackupTime != null
                    ? state.lastDriveBackupTime!.toDayMonthYearTime12Hour()
                    : l10n.noBackupsYet),
                style: AppTextStyles.body4,
              ),
              // last restore time
              const Gap(AppSpacing.spacing4),
              Text(
                l10n.lastRestoreTimeLabel(state.lastDriveRestoreTime != null
                    ? state.lastDriveRestoreTime!.toDayMonthYearTime12Hour()
                    : l10n.noRestoresYet),
                style: AppTextStyles.body4,
              ),

              if (state.status == BackupStatus.loading)
                LinearProgressIndicator(
                  value: null,
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.radius12),
                  minHeight: 6.0,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
