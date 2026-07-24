import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pockaw/core/localization/locale_provider.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class LanguageSelectorDialog extends ConsumerWidget {
  const LanguageSelectorDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeNotifierProvider);
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(l10n.selectLanguage),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<String?>(
            title: Text(l10n.systemDefault),
            value: null,
            groupValue: currentLocale?.languageCode,
            onChanged: (val) {
              ref.read(localeNotifierProvider.notifier).setLocale(null);
              Navigator.of(context).pop();
            },
          ),
          RadioListTile<String?>(
            title: Text(l10n.english),
            value: 'en',
            groupValue: currentLocale?.languageCode,
            onChanged: (val) {
              ref.read(localeNotifierProvider.notifier).setLocale(const Locale('en'));
              Navigator.of(context).pop();
            },
          ),
          RadioListTile<String?>(
            title: Text(l10n.arabic),
            value: 'ar',
            groupValue: currentLocale?.languageCode,
            onChanged: (val) {
              ref.read(localeNotifierProvider.notifier).setLocale(const Locale('ar'));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const LanguageSelectorDialog(),
    );
  }
}
