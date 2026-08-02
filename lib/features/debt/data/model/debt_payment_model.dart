import 'package:pockaw/features/wallet/data/model/wallet_model.dart';

class DebtPaymentModel {
  final int? id;
  final int debtId;
  final double amount;
  final DateTime paymentDate;
  final String? notes;
  final WalletModel wallet;
  final DateTime? createdAt;

  const DebtPaymentModel({
    this.id,
    required this.debtId,
    required this.amount,
    required this.paymentDate,
    this.notes,
    required this.wallet,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'debtId': debtId,
      'amount': amount,
      'paymentDate': paymentDate.toIso8601String(),
      'notes': notes,
      'walletId': wallet.id,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
