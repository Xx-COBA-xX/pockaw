import 'package:drift/drift.dart';
import 'package:pockaw/core/database/tables/wallet_table.dart';

@DataClassName('Debt')
class Debts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get personName => text().withLength(min: 1, max: 100)();
  TextColumn get phoneNumber => text().nullable()();
  TextColumn get debtType => text().withDefault(const Constant('iOwe'))(); // 'iOwe' or 'iAmOwed'
  RealColumn get totalAmount => real()();
  RealColumn get paidAmount => real().withDefault(const Constant(0.0))();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get walletId => integer().references(Wallets, #id)();
  TextColumn get status => text().withDefault(const Constant('active'))(); // 'active', 'completed', 'overdue'
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
