import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pockaw/core/utils/logger.dart';
import 'package:pockaw/features/currency_picker/data/models/currency.dart';

class CurrencyLocalDataSource {
  Future<List<dynamic>> getCurrencies() async {
    final jsonString = await rootBundle.loadString(
      'assets/data/currencies.json',
    );
    final jsonList = jsonDecode(jsonString);
    Log.d(jsonList, label: 'currencies', logToFile: false);
    // Log.d('currencies: ${jsonList.runtimeType}');
    return jsonList['currencies'];
  }

  static const Currency dummy = Currency(
    symbol: 'د.ع',
    name: 'Iraqi Dinar',
    decimalDigits: 0,
    rounding: 0,
    isoCode: 'IQD',
    namePlural: 'Iraqi Dinars',
    country: 'Iraq',
    countryCode: 'IQ',
  );

  List<String> getAvailableCurrencies() {
    return ['IQ', 'US'];
  }
}
