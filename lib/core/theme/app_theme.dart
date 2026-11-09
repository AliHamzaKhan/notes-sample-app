


import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_size.dart';
import 'app_radius.dart';

abstract final class AppTheme {
  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final light = brightness == Brightness.light;
    var scheme = ColorScheme.fromSeed(seedColor: AppColors.seed, brightness: brightness);
    if (light) {
      scheme = scheme.copyWith(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        surface: AppColors.card,
        outlineVariant: AppColors.border,
      );
    }
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md));
    final cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.card),
      side: BorderSide(color: scheme.outlineVariant),
    );
    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      scaffoldBackgroundColor: light ? AppColors.page : null,
      appBarTheme: AppBarTheme(
        backgroundColor: light ? AppColors.card : null,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0.5,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: light ? AppColors.card : null,
        indicatorColor: light ? AppColors.successSoft : null,
        // labelTextStyle: WidgetStateProperty.all(AppFonts.monoStyle(const TextStyle(fontSize: 12), letterSpacing: 0.4)),
      ),
      visualDensity: VisualDensity.standard,

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.sm)),
        isDense: true,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(minimumSize: const Size(0, AppSizes.touchTarget), shape: shape),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(minimumSize: const Size(0, AppSizes.touchTarget), shape: shape),
      ),
      cardTheme: CardThemeData(shape: cardShape, margin: EdgeInsets.zero, elevation: 0, color: light ? AppColors.card : null),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    );
  }
}
