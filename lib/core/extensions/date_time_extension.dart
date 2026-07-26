import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pockaw/l10n/app_localizations.dart';

extension DateTimeExtension on DateTime {
  /// Format: March / آذار
  String toMonthName([String? locale]) {
    return DateFormat('MMMM', locale).format(this);
  }

  /// Format: 13 March 2025
  String toDayMonthYear([String? locale]) {
    return DateFormat('d MMMM yyyy', locale).format(this);
  }

  /// Format: 12 Nov 2024
  String toDayShortMonth([String? locale]) {
    return DateFormat('d MMM', locale).format(this);
  }

  /// Format: 12 Nov 2024
  String toDayShortMonthYear([String? locale]) {
    return DateFormat('d MMM yyyy', locale).format(this);
  }

  /// Format: March 13, 2025
  String toMonthDayYear([String? locale]) {
    return DateFormat('MMMM d, yyyy', locale).format(this);
  }

  /// Format: 13/03/2025
  String toDayMonthYearNumeric() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  /// Format: 03/2025
  String toMonthYearNumeric() {
    return DateFormat('MM/yyyy').format(this);
  }

  /// Format: Oct 2024
  String toMonthYear([String? locale]) {
    return DateFormat('MMM yyyy', locale).format(this);
  }

  DateTime get toMidnightStart {
    return DateTime(year, month, day);
  }

  DateTime get toMidnightEnd {
    return DateTime(year, month, day, 23, 59, 59);
  }

  /// Returns date in relative format with optional time.
  /// Examples:
  /// - "Today, 10:22" (with showTime: true, use24Hours: true)
  /// - "Today, 10:22 AM" (with showTime: true, use24Hours: false)
  /// - "Yesterday, 15:23" (with showTime: true, use24Hours: true)
  /// - "Yesterday, 03:23 PM" (with showTime: true, use24Hours: false)
  /// - "13 June 2025, 10:22" (with showTime: true, use24Hours: true)
  /// - "13 June 2025, 10:22 AM" (with showTime: true, use24Hours: false)
  /// - "Today" (with showTime: false)
  String toRelativeDayFormatted({
    BuildContext? context,
    String? locale,
    bool showTime = false,
    bool use24Hours = true,
  }) {
    final effectiveLocale =
        locale ?? (context != null ? Localizations.localeOf(context).languageCode : null);
    final l10n = context != null ? AppLocalizations.of(context) : null;

    final now = DateTime.now();
    // Normalize dates to midnight for accurate day difference
    final thisDateAtMidnight = DateTime(year, month, day);
    final nowDateAtMidnight = DateTime(now.year, now.month, now.day);

    final differenceInDays = nowDateAtMidnight
        .difference(thisDateAtMidnight)
        .inDays;

    String baseText;
    bool useComma = differenceInDays == 0 || differenceInDays == 1;
    if (differenceInDays == 0) {
      baseText = l10n?.today ?? 'Today';
    } else if (differenceInDays == 1) {
      baseText = l10n?.yesterday ?? 'Yesterday';
    } else {
      baseText = toDayMonthYear(effectiveLocale);
    }

    if (showTime) {
      final time = use24Hours
          ? DateFormat('HH:mm', effectiveLocale).format(this)
          : DateFormat('hh:mm a', effectiveLocale).format(this);

      if (useComma) {
        return '$baseText, $time';
      }

      return '$baseText $time';
    }
    return baseText;
  }

  /// Returns "This Month", "Last Month", or "Oct 2024" for tab labels.
  /// Compares `this` month to the `currentDate` month.
  String toMonthTabLabel(DateTime currentDate, [AppLocalizations? l10n, String? locale]) {
    final thisMonthStart = DateTime(year, month, 1);
    final currentMonthStart = DateTime(currentDate.year, currentDate.month, 1);
    final lastMonthStart = DateTime(currentDate.year, currentDate.month - 1, 1);

    if (thisMonthStart.year == currentMonthStart.year &&
        thisMonthStart.month == currentMonthStart.month) {
      return l10n?.thisMonth ?? 'This Month';
    }
    if (thisMonthStart.year == lastMonthStart.year &&
        thisMonthStart.month == lastMonthStart.month) {
      return l10n?.lastMonth ?? 'Last Month';
    }
    return DateFormat('MMM yyyy', locale).format(this); // e.g., "Oct 2024" / "أكتوبر ٢٠٢٤"
  }

  /// Format: 13 March 2025 05.44 am / 13 March 2025 05.44 pm
  String toDayMonthYearTime12Hour() {
    return DateFormat('d MMMM yyyy hh.mm a').format(this);
  }

  /// Format: 13 March 2025 17.44
  String toDayMonthYearTime24Hour() {
    return DateFormat('d MMMM yyyy HH.mm').format(this);
  }
}
