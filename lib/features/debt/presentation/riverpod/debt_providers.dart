import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pockaw/core/database/daos/debt_dao.dart';
import 'package:pockaw/core/database/database_provider.dart';
import 'package:pockaw/features/debt/data/enum/debt_type.dart';
import 'package:pockaw/features/debt/data/model/debt_model.dart';
import 'package:pockaw/features/debt/data/model/debt_payment_model.dart';

final debtDaoProvider = Provider<DebtDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.debtDao;
});

final debtListProvider = StreamProvider.autoDispose<List<DebtModel>>((ref) {
  final debtDao = ref.watch(debtDaoProvider);
  return debtDao.watchAllDebts();
});

final debtDetailsProvider = StreamProvider.autoDispose
    .family<DebtModel?, int>((ref, debtId) {
  final debtDao = ref.watch(debtDaoProvider);
  return debtDao.watchDebtById(debtId);
});

final debtPaymentsProvider = StreamProvider.autoDispose
    .family<List<DebtPaymentModel>, int>((ref, debtId) {
  final debtDao = ref.watch(debtDaoProvider);
  return debtDao.watchPaymentsForDebt(debtId);
});

class DebtSummaryData {
  final double totalIOwe;
  final double totalIAmOwed;
  final double netBalance;

  const DebtSummaryData({
    required this.totalIOwe,
    required this.totalIAmOwed,
    required this.netBalance,
  });
}

final debtSummaryProvider = Provider.autoDispose<DebtSummaryData>((ref) {
  final debtsAsync = ref.watch(debtListProvider);

  return debtsAsync.maybeWhen(
    data: (debts) {
      double totalIOwe = 0.0;
      double totalIAmOwed = 0.0;

      for (final debt in debts) {
        if (!debt.isCompleted) {
          if (debt.debtType == DebtType.iOwe) {
            totalIOwe += debt.remainingAmount;
          } else {
            totalIAmOwed += debt.remainingAmount;
          }
        }
      }

      return DebtSummaryData(
        totalIOwe: totalIOwe,
        totalIAmOwed: totalIAmOwed,
        netBalance: totalIAmOwed - totalIOwe,
      );
    },
    orElse: () => const DebtSummaryData(
      totalIOwe: 0.0,
      totalIAmOwed: 0.0,
      netBalance: 0.0,
    ),
  );
});
