import 'package:drift/drift.dart';
import 'package:pockaw/core/database/pockaw_database.dart';
import 'package:pockaw/core/database/tables/debt_payment_table.dart';
import 'package:pockaw/core/database/tables/debt_table.dart';
import 'package:pockaw/core/database/tables/wallet_table.dart';
import 'package:pockaw/features/debt/data/enum/debt_type.dart';
import 'package:pockaw/features/debt/data/model/debt_model.dart';
import 'package:pockaw/features/debt/data/model/debt_payment_model.dart';

part 'debt_dao.g.dart';

@DriftAccessor(tables: [Debts, DebtPayments, Wallets])
class DebtDao extends DatabaseAccessor<AppDatabase> with _$DebtDaoMixin {
  DebtDao(super.db);

  Future<DebtModel> _mapDebt(Debt debtData) async {
    final wallet = await db.walletDao.getWalletById(debtData.walletId);
    if (wallet == null) {
      throw Exception('Wallet not found for debt ID ${debtData.id}');
    }

    return DebtModel(
      id: debtData.id,
      personName: debtData.personName,
      phoneNumber: debtData.phoneNumber,
      debtType: DebtType.fromDbValue(debtData.debtType),
      totalAmount: debtData.totalAmount,
      paidAmount: debtData.paidAmount,
      startDate: debtData.startDate,
      dueDate: debtData.dueDate,
      notes: debtData.notes,
      wallet: wallet.toModel(),
      status: debtData.status,
      createdAt: debtData.createdAt,
      updatedAt: debtData.updatedAt,
    );
  }

  Future<List<DebtModel>> _mapDebts(List<Debt> debtDataList) async {
    final walletIds = debtDataList.map((d) => d.walletId).toSet().toList();
    final walletsMap = {
      for (var w in await db.walletDao.getWalletsByIds(walletIds)) w.id: w,
    };

    List<DebtModel> result = [];
    for (var debtData in debtDataList) {
      final wallet = walletsMap[debtData.walletId];
      if (wallet != null) {
        result.add(
          DebtModel(
            id: debtData.id,
            personName: debtData.personName,
            phoneNumber: debtData.phoneNumber,
            debtType: DebtType.fromDbValue(debtData.debtType),
            totalAmount: debtData.totalAmount,
            paidAmount: debtData.paidAmount,
            startDate: debtData.startDate,
            dueDate: debtData.dueDate,
            notes: debtData.notes,
            wallet: wallet.toModel(),
            status: debtData.status,
            createdAt: debtData.createdAt,
            updatedAt: debtData.updatedAt,
          ),
        );
      }
    }
    return result;
  }

  Stream<List<DebtModel>> watchAllDebts() {
    return select(debts).watch().asyncMap(_mapDebts);
  }

  Stream<DebtModel?> watchDebtById(int id) {
    return (select(debts)..where((t) => t.id.equals(id)))
        .watchSingleOrNull()
        .asyncMap((debtData) async {
      if (debtData == null) return null;
      return _mapDebt(debtData);
    });
  }

  Future<int> addDebt(DebtModel debtModel) async {
    final companion = DebtsCompanion.insert(
      personName: debtModel.personName,
      phoneNumber: Value(debtModel.phoneNumber),
      debtType: Value(debtModel.debtType.toDbValue()),
      totalAmount: debtModel.totalAmount,
      paidAmount: Value(debtModel.paidAmount),
      startDate: debtModel.startDate,
      dueDate: Value(debtModel.dueDate),
      notes: Value(debtModel.notes),
      walletId: debtModel.wallet.id!,
      status: Value(debtModel.status),
      createdAt: Value(debtModel.createdAt ?? DateTime.now()),
      updatedAt: Value(DateTime.now()),
    );
    return into(debts).insert(companion);
  }

  Future<bool> updateDebt(DebtModel debtModel) async {
    if (debtModel.id == null) return false;
    final companion = DebtsCompanion(
      id: Value(debtModel.id!),
      personName: Value(debtModel.personName),
      phoneNumber: Value(debtModel.phoneNumber),
      debtType: Value(debtModel.debtType.toDbValue()),
      totalAmount: Value(debtModel.totalAmount),
      paidAmount: Value(debtModel.paidAmount),
      startDate: Value(debtModel.startDate),
      dueDate: Value(debtModel.dueDate),
      notes: Value(debtModel.notes),
      walletId: Value(debtModel.wallet.id!),
      status: Value(debtModel.status),
      updatedAt: Value(DateTime.now()),
    );
    return update(debts).replace(companion);
  }

  Future<int> deleteDebt(int id) async {
    // Delete payments first
    await (delete(debtPayments)..where((p) => p.debtId.equals(id))).go();
    return (delete(debts)..where((d) => d.id.equals(id))).go();
  }

  Stream<List<DebtPaymentModel>> watchPaymentsForDebt(int debtId) {
    return (select(debtPayments)..where((p) => p.debtId.equals(debtId)))
        .watch()
        .asyncMap((payments) async {
      final walletIds = payments.map((p) => p.walletId).toSet().toList();
      final walletsMap = {
        for (var w in await db.walletDao.getWalletsByIds(walletIds)) w.id: w,
      };

      List<DebtPaymentModel> result = [];
      for (var payment in payments) {
        final wallet = walletsMap[payment.walletId];
        if (wallet != null) {
          result.add(
            DebtPaymentModel(
              id: payment.id,
              debtId: payment.debtId,
              amount: payment.amount,
              paymentDate: payment.paymentDate,
              notes: payment.notes,
              wallet: wallet.toModel(),
              createdAt: payment.createdAt,
            ),
          );
        }
      }
      return result;
    });
  }

  Future<int> addDebtPayment(DebtPaymentModel payment, DebtModel debt) async {
    return transaction(() async {
      final paymentId = await into(debtPayments).insert(
        DebtPaymentsCompanion.insert(
          debtId: payment.debtId,
          amount: payment.amount,
          paymentDate: payment.paymentDate,
          notes: Value(payment.notes),
          walletId: payment.wallet.id!,
          createdAt: Value(payment.createdAt ?? DateTime.now()),
        ),
      );

      final newPaidAmount = debt.paidAmount + payment.amount;
      final newStatus =
          newPaidAmount >= debt.totalAmount ? 'completed' : debt.status;

      await (update(debts)..where((d) => d.id.equals(debt.id!))).write(
        DebtsCompanion(
          paidAmount: Value(newPaidAmount),
          status: Value(newStatus),
          updatedAt: Value(DateTime.now()),
        ),
      );

      return paymentId;
    });
  }

  Future<int> deleteDebtPayment(int paymentId, DebtModel debt) async {
    final payment = await (select(debtPayments)
          ..where((p) => p.id.equals(paymentId)))
        .getSingleOrNull();
    if (payment == null) return 0;

    return transaction(() async {
      final deletedCount =
          await (delete(debtPayments)..where((p) => p.id.equals(paymentId))).go();

      final newPaidAmount = (debt.paidAmount - payment.amount).clamp(0.0, double.infinity);
      final newStatus = newPaidAmount < debt.totalAmount ? 'active' : 'completed';

      await (update(debts)..where((d) => d.id.equals(debt.id!))).write(
        DebtsCompanion(
          paidAmount: Value(newPaidAmount),
          status: Value(newStatus),
          updatedAt: Value(DateTime.now()),
        ),
      );

      return deletedCount;
    });
  }
}
