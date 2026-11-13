import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const background = Color(0xFFF5F8F5);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceAlt = Color(0xFFEEF7F0);
  static const panel = Color(0xFFEAF4ED);
  static const primary = Color(0xFF69C67A);
  static const primaryStrong = Color(0xFF3EA65E);
  static const accent = Color(0xFFC5EBC9);
  static const danger = Color(0xFFD96E6E);
  static const muted = Color(0xFF5A6A62);
  static const textPrimary = Color(0xFF1A2A23);
  static const textSoft = Color(0xFF51635B);

  static ThemeData light() {
    final base = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: primaryStrong,
        surface: surface,
        error: danger,
        onPrimary: Colors.white,
      ),
      useMaterial3: true,
    );

    final bodyTheme = GoogleFonts.manropeTextTheme(base.textTheme);
    final headingTheme = GoogleFonts.playfairDisplayTextTheme(base.textTheme);

    return base.copyWith(
      textTheme: bodyTheme.copyWith(
        displayLarge: headingTheme.displayLarge,
        displayMedium: headingTheme.displayMedium,
        displaySmall: headingTheme.displaySmall,
        headlineLarge: headingTheme.headlineLarge,
        headlineMedium: headingTheme.headlineMedium,
        headlineSmall: headingTheme.headlineSmall,
        titleLarge: headingTheme.titleLarge,
        titleMedium: headingTheme.titleMedium,
        titleSmall: headingTheme.titleSmall,
        bodyLarge: bodyTheme.bodyLarge,
        bodyMedium: bodyTheme.bodyMedium,
        bodySmall: bodyTheme.bodySmall,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
      ),
      scaffoldBackgroundColor: background,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle: const TextStyle(color: muted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryStrong, width: 1.5),
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: primary.withAlpha(30),
        shadowColor: Colors.black.withAlpha(12),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ),
      dividerColor: const Color(0xFFE1E9E2),
      chipTheme: const ChipThemeData(
        backgroundColor: surfaceAlt,
        labelStyle: TextStyle(color: textPrimary, fontWeight: FontWeight.w700),
      ),
    );
  }
}