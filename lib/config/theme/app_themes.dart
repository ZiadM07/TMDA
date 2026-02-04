// ignore_for_file: depend_on_referenced_packages

import 'package:flash/flash.dart';
import 'package:flutter/scheduler.dart';

import '../../../../core/constants/exports.dart';
import 'app_color_scheme.dart';

class AppThemes {
  static ThemeData get light {
    final cs = AppColorScheme.light;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      fontFamily: AppConstants.enFontFamily,
      colorScheme: cs,

      scaffoldBackgroundColor: cs.surface,

      textTheme: _textTheme(cs),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: cs.surfaceContainer,
        selectedItemColor: cs.primary,
        unselectedItemColor: cs.onSurfaceVariant,
        selectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: cs.textPrimary,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    ).extendsOptions;
  }

  static ThemeData get dark {
    final cs = AppColorScheme.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      fontFamily: AppConstants.enFontFamily,
      colorScheme: cs,

      scaffoldBackgroundColor: cs.surface,

      textTheme: _textTheme(cs),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: cs.surfaceContainer,
        selectedItemColor: cs.primary,
        unselectedItemColor: cs.onSurfaceVariant,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
      ),
    ).extendsOptions;
  }

  /// Material 3–aligned typography
  static TextTheme _textTheme(ColorScheme cs) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w600,
        color: cs.textPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w600,
        color: cs.textPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: cs.textPrimary,
      ),

      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: cs.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: cs.textPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: cs.textPrimary,
      ),

      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: cs.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: cs.textPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: cs.textSecondary,
      ),

      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: cs.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: cs.textSecondary,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: cs.textTertiary,
      ),

      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: cs.textSecondary,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: cs.textSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: cs.textSecondary,
      ),
    );
  }
}

extension OnTheme on ThemeData {
  ThemeData get extendsOptions {
    return copyWith(
      extensions: [const FlashToastTheme(), const FlashBarTheme()],
    );
  }
}

enum AppThemeMode { light, dark, system }

extension AppThemeModeExtension on AppThemeMode {
  int get index {
    switch (this) {
      case AppThemeMode.light:
        return 0;
      case AppThemeMode.dark:
        return 1;
      case AppThemeMode.system:
        return 2;
    }
  }

  ThemeData get data {
    switch (this) {
      case AppThemeMode.light:
        return AppThemes.light;
      case AppThemeMode.dark:
        return AppThemes.dark;
      case AppThemeMode.system:
        return _getThemeBySystemDefaults();
    }
  }

  IconData get icon {
    switch (this) {
      case AppThemeMode.light:
        return SolarIconsOutline.sun2;
      case AppThemeMode.dark:
        return SolarIconsOutline.moon;
      case AppThemeMode.system:
        return SolarIconsOutline.settings;
    }
  }

  ThemeData _getThemeBySystemDefaults() {
    final Brightness systemBrightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    if (systemBrightness == Brightness.dark) return AppThemes.dark;
    return AppThemes.light;
  }

  bool get isDarkTheme => data.brightness == Brightness.dark;
}

AppThemeMode getAppThemeModeFromIndex(int index) {
  switch (index) {
    case 0:
      return AppThemeMode.light;
    case 1:
      return AppThemeMode.dark;
    case 2:
      return AppThemeMode.system;
    default:
      return AppThemeMode.light;
  }
}
