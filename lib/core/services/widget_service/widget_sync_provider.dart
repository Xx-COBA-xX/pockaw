import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pockaw/core/database/database_provider.dart';
import 'package:pockaw/core/database/pockaw_database.dart';
import 'package:pockaw/core/localization/locale_provider.dart';
import 'package:pockaw/core/services/widget_service/widget_service.dart';
import 'package:pockaw/features/wallet/riverpod/wallet_providers.dart';

final widgetSyncProvider = Provider<WidgetSyncService>((ref) {
  final db = ref.watch(databaseProvider);
  return WidgetSyncService(db, ref);
});

/// Reactive provider that automatically triggers widget sync on data/locale changes
final autoWidgetSyncProvider = Provider<void>((ref) {
  final syncService = ref.watch(widgetSyncProvider);

  // Watch locale changes
  ref.watch(localeNotifierProvider);

  // Watch active wallet & visibility changes
  ref.watch(activeWalletProvider);
  ref.watch(walletAmountVisibilityProvider);
  ref.watch(allWalletsStreamProvider);

  // Listen to transaction & budget stream updates from database
  final db = ref.watch(databaseProvider);
  final sub1 = db.transactionDao.watchAllTransactionsWithDetails().listen((_) {
    syncService.syncWidgetData();
  });
  final sub2 = db.budgetDao.watchAllBudgets().listen((_) {
    syncService.syncWidgetData();
  });
  final sub3 = db.walletDao.watchAllWallets().listen((_) {
    syncService.syncWidgetData();
  });

  ref.onDispose(() {
    sub1.cancel();
    sub2.cancel();
    sub3.cancel();
  });

  // Execute initial sync
  syncService.syncWidgetData();
});

class WidgetSyncService {
  final AppDatabase db;
  final Ref ref;

  WidgetSyncService(this.db, this.ref);

  /// Synchronize app budget & transaction data with native Android & iOS Widgets
  Future<void> syncWidgetData() async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

      // Fetch all wallets & compute total balance + wallet balances map
      final wallets = await db.walletDao.watchAllWallets().first;
      double totalBalance = 0;
      final Map<String, double> walletsBalances = {};
      for (final w in wallets) {
        totalBalance += w.balance;
        walletsBalances[w.name] = w.balance;
      }

      // Fetch all transactions with details
      final allTransactions = await db.transactionDao.watchAllTransactionsWithDetails().first;

      // Calculate today's spent
      double todaySpent = 0;
      for (final tx in allTransactions) {
        if (tx.transactionType.name.toLowerCase() == 'expense' &&
            !tx.date.isBefore(startOfDay) &&
            !tx.date.isAfter(endOfDay)) {
          todaySpent += tx.amount;
        }
      }

      // Extract recent 5 transactions
      final List<Map<String, dynamic>> recentTransactions = [];
      for (final tx in allTransactions.take(5)) {
        recentTransactions.add({
          'id': tx.id,
          'title': tx.title.isNotEmpty ? tx.title : tx.category.title,
          'amount': tx.amount,
          'type': tx.transactionType.name,
          'category': tx.category.title,
          'date': tx.date.toIso8601String(),
        });
      }

      // Fetch all budgets
      final budgetModels = await db.budgetDao.watchAllBudgets().first;
      double totalBudgetLimit = 0;
      double totalBudgetSpent = 0;

      for (final b in budgetModels) {
        totalBudgetLimit += b.amount;
        final spent = await db.budgetDao.getSpentAmountForBudget(b);
        totalBudgetSpent += spent;
      }

      double remainingBudget = totalBudgetLimit - totalBudgetSpent;
      if (remainingBudget < 0) remainingBudget = 0;

      final budgetProgress = totalBudgetLimit > 0
          ? (totalBudgetSpent / totalBudgetLimit).clamp(0.0, 1.0)
          : 0.0;

      final activeWallet = ref.read(activeWalletProvider).asData?.value;
      final walletCurrency = activeWallet?.currency ?? 'IQD';
      final currencySymbol = (walletCurrency == 'IQD' || walletCurrency == 'د.ع') ? 'د.ع' : walletCurrency;

      final isVisible = ref.read(walletAmountVisibilityProvider);

      final locale = ref.read(localeNotifierProvider);
      final isArabic = locale?.languageCode != 'en';

      final widgetTitle = isArabic ? 'صُـرّة' : 'Pockaw';
      final remainingBudgetLabel = isArabic ? 'الميزانية المتبقية' : 'Remaining Budget';
      final todaySpentLabel = isArabic ? 'مصاريف اليوم' : 'Today\'s Spent';
      final quickAddLabel = isArabic ? 'إضافة' : 'Add';

      await WidgetService.updateWidgetData(
        totalBalance: totalBalance,
        todaySpent: todaySpent,
        remainingBudget: remainingBudget,
        budgetLimit: totalBudgetLimit,
        budgetSpent: totalBudgetSpent,
        budgetProgress: budgetProgress,
        currencySymbol: currencySymbol,
        widgetTitle: widgetTitle,
        remainingBudgetLabel: remainingBudgetLabel,
        todaySpentLabel: todaySpentLabel,
        quickAddLabel: quickAddLabel,
        hideBalance: !isVisible,
        recentTransactions: recentTransactions,
        walletsBalances: walletsBalances,
      );
    } catch (e) {
      debugPrint('Error syncing widget data: $e');
    }
  }
}
