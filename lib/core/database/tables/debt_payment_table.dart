import 'package:drift/drift.dart';
import 'package:pockaw/core/database/tables/debt_table.dart';
import 'package:pockaw/core/database/tables/wallet_table.dart';

@DataClassName('DebtPayment')
class DebtPayments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get debtId => integer().references(Debts, #id, onDelete: KeyAction.cascade)();
  RealColumn get amount => real()();
  DateTimeColumn get paymentDate => dateTime()();
  TextColumn get notes => text().nullable()();
  IntColumn get walletId => integer().references(Wallets, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
