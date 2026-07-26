enum DebtType {
  iOwe,    // Debt user owes to someone else (payable)
  iAmOwed;  // Debt someone else owes to user (receivable)

  bool get isIOwe => this == DebtType.iOwe;
  bool get isIAmOwed => this == DebtType.iAmOwed;

  String toDbValue() {
    return name;
  }

  static DebtType fromDbValue(String value) {
    if (value == 'iAmOwed') return DebtType.iAmOwed;
    return DebtType.iOwe;
  }
}
