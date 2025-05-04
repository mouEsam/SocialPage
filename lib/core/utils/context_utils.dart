import 'package:flutter/material.dart';
import 'package:test_app/core/extensions/theme_ext.dart';

extension ContextUtils on BuildContext {
  AppThemeExtension get appTheme {
    return AppThemeExtension.of(this);
  }

  ThemeData get theme {
    return Theme.of(this);
  }
}
