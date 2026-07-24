import 'package:pockaw/features/wallet/data/model/wallet_model.dart';

const List<WalletModel> defaultWallets = [
  WalletModel(
    name: 'محفظتي الرئيسية',
    balance: 0,
    currency: 'IQD',
    iconName: 'HugeIcons.strokeRoundedBank', // Example icon name
    colorHex: 'FF4CAF50', // Green
  ),
];

const List<WalletModel> wallets = [
  WalletModel(
    id: 1,
    name: 'المحفظة الرئيسية',
    balance: 250000,
    currency: 'IQD',
    iconName: 'HugeIcons.strokeRoundedBank', // Example icon name
    colorHex: 'FF4CAF50', // Green
  ),
  WalletModel(
    id: 2,
    name: 'حساب الدولار',
    balance: 1500.00,
    currency: 'USD',
    iconName: 'HugeIcons.strokeRoundedPiggyBank', // Example icon name
    colorHex: 'FF2196F3', // Blue
  ),
];
