import 'package:pockaw/features/debt/data/enum/debt_type.dart';
import 'package:pockaw/features/wallet/data/model/wallet_model.dart';

class DebtModel {
  final int? id;
  final String personName;
  final String? phoneNumber;
  final DebtType debtType;
  final double totalAmount;
  final double paidAmount;
  final DateTime startDate;
  final DateTime? dueDate;
  final String? notes;
  final WalletModel wallet;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const DebtModel({
    this.id,
    required this.personName,
    this.phoneNumber,
    required this.debtType,
    required this.totalAmount,
    this.paidAmount = 0.0,
    required this.startDate,
    this.dueDate,
    this.notes,
    required this.wallet,
    this.status = 'active',
    this.createdAt,
    this.updatedAt,
  });

  double get remainingAmount => (totalAmount - paidAmount).clamp(0.0, double.infinity);

  double get progress => totalAmount > 0
      ? (paidAmount / totalAmount).clamp(0.0, 1.0)
      : 0.0;

  bool get isCompleted => paidAmount >= totalAmount || status == 'completed';

  bool get isOverdue =>
      !isCompleted && dueDate != null && DateTime.now().isAfter(dueDate!);

  DebtModel copyWith({
    int? id,
    String? personName,
    String? phoneNumber,
    DebtType? debtType,
    double? totalAmount,
    double? paidAmount,
    DateTime? startDate,
    DateTime? dueDate,
    String? notes,
    WalletModel? wallet,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DebtModel(
      id: id ?? this.id,
      personName: personName ?? this.personName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      debtType: debtType ?? this.debtType,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      startDate: startDate ?? this.startDate,
      dueDate: dueDate ?? this.dueDate,
      notes: notes ?? this.notes,
      wallet: wallet ?? this.wallet,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'personName': personName,
      'phoneNumber': phoneNumber,
      'debtType': debtType.toDbValue(),
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'startDate': startDate.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'notes': notes,
      'walletId': wallet.id,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
