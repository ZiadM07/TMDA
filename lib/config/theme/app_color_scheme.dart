import '../../core/constants/exports.dart';

class AppColorScheme {
  /// Light Theme
  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,

    // Primary (Cyan)
    primary: Color(0xFF00FFFF),
    onPrimary: Color(0xFF003333),
    primaryContainer: Color(0xFFCFFFFF),
    onPrimaryContainer: Color(0xFF003F3F),

    // Secondary (Pink)
    secondary: Color(0xFFFE53BB),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFD6EC),
    onSecondaryContainer: Color(0xFF4A002B),

    // Tertiary (Soft Violet for balance)
    tertiary: Color(0xFF8B7CFF),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFE3DFFF),
    onTertiaryContainer: Color(0xFF1E114A),

    // Error
    error: Color(0xFFB81717),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),

    // Surface
    surface: Color(0xFFF7FAFC),
    onSurface: Color(0xFF121418),
    onSurfaceVariant: Color(0xFF4B4F56),

    // Outline
    outline: Color(0xFFB7BCC4),
    outlineVariant: Color(0xFFE3E6EB),

    // Shadows
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),

    // Inverse
    inverseSurface: Color(0xFF121418),
    onInverseSurface: Color(0xFFE6E8EB),
    inversePrimary: Color(0xFF00CFCF),

    // Tint
    surfaceTint: Color(0xFF00FFFF),

    // Surface levels
    surfaceBright: Color(0xFFFFFFFF),
    surfaceDim: Color(0xFFF0F3F6),

    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFF8FAFC),
    surfaceContainer: Color(0xFFF2F5F9),
    surfaceContainerHigh: Color(0xFFECEFF4),
    surfaceContainerHighest: Color(0xFFE3E7ED),

    // Fixed
    primaryFixed: Color(0xFFCFFFFF),
    primaryFixedDim: Color(0xFF9AFFFF),

    secondaryFixed: Color(0xFFFFD6EC),
    secondaryFixedDim: Color(0xFFFFA3D6),

    tertiaryFixed: Color(0xFFE3DFFF),
    tertiaryFixedDim: Color(0xFFC7C0FF),
  );

  /// Dark Theme
  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,

    // Primary (Cyan)
    primary: Color(0xFF00FFFF),
    onPrimary: Color(0xFF003333),
    primaryContainer: Color(0xFF003F3F),
    onPrimaryContainer: Color(0xFFCFFFFF),

    // Secondary (Pink)
    secondary: Color(0xFFFE53BB),
    onSecondary: Color(0xFF3A001F),
    secondaryContainer: Color(0xFF4A002B),
    onSecondaryContainer: Color(0xFFFFD6EC),

    // Tertiary
    tertiary: Color(0xFF8B7CFF),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFF2A235F),
    onTertiaryContainer: Color(0xFFE3DFFF),

    // Error
    error: Color(0xFFFF6B6B),
    onError: Color(0xFF2D0000),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),

    // Surface
    surface: Color(0xFF0E1116),
    onSurface: Color(0xFFE6E8EB),
    onSurfaceVariant: Color(0xFFB3B8C2),

    // Outline
    outline: Color(0xFF3A3F47),
    outlineVariant: Color(0xFF23272F),

    // Shadows
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),

    // Inverse
    inverseSurface: Color(0xFFF2F5F9),
    onInverseSurface: Color(0xFF121418),
    inversePrimary: Color(0xFF00CFCF),

    // Tint
    surfaceTint: Color(0xFF00FFFF),

    // Surface levels
    surfaceBright: Color(0xFF1B1F26),
    surfaceDim: Color(0xFF0A0D12),

    surfaceContainerLowest: Color(0xFF0A0D12),
    surfaceContainerLow: Color(0xFF0E1116),
    surfaceContainer: Color(0xFF141821),
    surfaceContainerHigh: Color(0xFF1C212C),
    surfaceContainerHighest: Color(0xFF262C38),

    // Fixed
    primaryFixed: Color(0xFF003F3F),
    primaryFixedDim: Color(0xFF002828),

    secondaryFixed: Color(0xFF4A002B),
    secondaryFixedDim: Color(0xFF2E001A),

    tertiaryFixed: Color(0xFF2A235F),
    tertiaryFixedDim: Color(0xFF1B1742),
  );
}

extension ColorSchemeExt on ColorScheme {
  bool isLightMode() => brightness == Brightness.light;

  // Success Colors
  Color get success => const Color(0xFF27AE60);
  Color get onSuccess => const Color(0xFFFEFEFE);
  Color get successContainer => const Color(0xFFBFE9D1);
  Color get onSuccessContainer => const Color(0xFFC1FFEC);

  // Warning Colors
  Color get warning => const Color(0xFFFF9933);
  Color get onWarning => const Color(0xFFFEFEFE);
  Color get warningContainer => const Color(0xFFFFF4D6);
  Color get onWarningContainer => const Color(0xFFDC6803);

  // Disabled
  Color get surfaceDisabled =>
      isLightMode() ? const Color(0xFFD8D8D8) : const Color(0xFF2F2F2F);

  Color get onSurfaceDisabled =>
      isLightMode() ? const Color(0xFFB3B3B3) : const Color(0xFF717178);

  // Borders
  Color get border =>
      isLightMode() ? const Color(0xFFD5D5D5) : const Color(0xFF414141);

  Color get lightBorder =>
      isLightMode() ? const Color(0xFFE8E8E8) : const Color(0xFF363636);

  // Surface Variant
  Color get surfaceVariant =>
      isLightMode() ? const Color(0xFFF8F8F8) : const Color(0xFF1B1C1D);

  Color get textPrimary => onSurface;
  Color get textSecondary => onSurface.withValues(alpha: 0.85);
  Color get textTertiary => onSurfaceVariant.withValues(alpha: 0.7);
  Color get textDisabled => onSurfaceDisabled;
}
