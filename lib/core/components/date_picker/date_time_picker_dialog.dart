import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pockaw/core/components/bottom_sheets/custom_bottom_sheet.dart';
import 'package:pockaw/core/components/buttons/primary_button.dart';
import 'package:pockaw/core/constants/app_colors.dart';
import 'package:pockaw/core/constants/app_spacing.dart';
import 'package:pockaw/core/constants/app_text_styles.dart';
import 'package:pockaw/core/extensions/text_style_extensions.dart';
import 'package:pockaw/l10n/app_localizations.dart';

class DateTimePickerDialog extends StatelessWidget {
  final String title;
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onDateTimeChanged;
  final ValueChanged<DateTime>? onDateSelected;

  const DateTimePickerDialog({
    super.key,
    this.title = '',
    this.initialDate,
    this.onDateTimeChanged,
    this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeColor = context.purpleIcon;

    return CustomBottomSheet(
      title: title.isEmpty ? l10n.transactionDateTime : title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.spacing20,
        children: [
          CupertinoCalendar(
            mainColor: themeColor,
            minimumDateTime: DateTime.now().subtract(const Duration(days: 365 * 10)),
            initialDateTime: initialDate,
            maximumDateTime: DateTime.now().add(const Duration(days: 365 * 10)),
            timeLabel: l10n.time,
            mode: CupertinoCalendarMode.dateTime,
            onDateTimeChanged: onDateTimeChanged,
            onDateSelected: onDateSelected,
            weekdayDecoration: CalendarWeekdayDecoration(
              textStyle: AppTextStyles.body3.extraBold.copyWith(
                color: context.colors.onSurface,
              ),
            ),
            headerDecoration: CalendarHeaderDecoration(
              monthDateStyle: AppTextStyles.body3.extraBold.copyWith(
                color: themeColor,
              ),
              monthDateArrowColor: themeColor,
              backwardButtonColor: themeColor,
              forwardButtonColor: themeColor,
              backwardDisabledButtonColor: context.disabledText,
              forwardDisabledButtonColor: context.disabledText,
            ),
            footerDecoration: CalendarFooterDecoration(
              timeLabelStyle: AppTextStyles.body3.extraBold.copyWith(
                color: context.colors.onSurface,
              ),
              timeStyle: AppTextStyles.body3.extraBold.copyWith(
                color: themeColor,
              ),
            ),
            monthPickerDecoration: CalendarMonthPickerDecoration(
              defaultDayStyle: CalendarMonthPickerDefaultDayStyle(
                textStyle: AppTextStyles.body3.copyWith(
                  color: context.colors.onSurface,
                ),
              ),
              disabledDayStyle: CalendarMonthPickerDisabledDayStyle(
                textStyle: AppTextStyles.body3.copyWith(
                  color: context.disabledText,
                ),
              ),
              selectedDayStyle: CalendarMonthPickerSelectedDayStyle(
                textStyle: AppTextStyles.body3.extraBold.copyWith(
                  color: Colors.white,
                ),
                backgroundCircleColor: themeColor,
              ),
              currentDayStyle: CalendarMonthPickerCurrentDayStyle(
                textStyle: AppTextStyles.body3.extraBold.copyWith(
                  color: themeColor,
                ),
              ),
              selectedCurrentDayStyle:
                  CalendarMonthPickerSelectedCurrentDayStyle(
                    textStyle: AppTextStyles.body3.extraBold.copyWith(
                      color: Colors.white,
                    ),
                    backgroundCircleColor: themeColor,
                  ),
            ),
          ),
          PrimaryButton(
            label: l10n.confirm,
            onPressed: () {
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
