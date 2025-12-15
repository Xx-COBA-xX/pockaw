import 'package:flutter/widgets.dart';

extension MediaQueryExtension on BuildContext {
  double get bottomPadding => MediaQuery.of(this).padding.bottom;
  double get bottomViewInset => MediaQuery.of(this).viewInsets.bottom;
}
