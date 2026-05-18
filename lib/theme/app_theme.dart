// THEME LOCK: light — source: domain signal (luxury beauty/fashion consumer app)
// Scaffold.backgroundColor = AppTheme.background — ALL screens

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ── Brand Colors ──────────────────────────────────────────────
  static const Color primary = Color(0xFF4A1C2A);
  static const Color primaryLight = Color(0xFF7A3A4E);
  static const Color primaryContainer = Color(0xFFF5E6DA);
  static const Color secondary = Color(0xFFF5E6DA);
  static const Color accent = Color(0xFFD4AF37);
  static const Color accentLight = Color(0xFFE8CC6A);
  static const Color ivory = Color(0xFFFFFDF9);
  static const Color espresso = Color(0xFF2B1A17);
  static const Color nudePink = Color(0xFFF0D5C4);
  static const Color muted = Color(0xFF9E8A80);
  static const Color mutedLight = Color(0xFFD4C4BC);

  // ── Semantic Colors ───────────────────────────────────────────
  static const Color success = Color(0xFF2D7A4F);
  static const Color warning = Color(0xFFB45309);
  static const Color error = Color(0xFFB91C1C);

  // ── Surface Colors ────────────────────────────────────────────
  static const Color surfaceLight = Color(0xFFFFFDF9);
  static const Color surfaceVariantLight = Color(0xFFF5E6DA);
  static const Color backgroundLight = Color(0xFFFFFDF9);
  static const Color cardLight = Color(0xFFFFFFFF);

  static const Color surfaceDark = Color(0xFF1E1A1B);
  static const Color backgroundDark = Color(0xFF120F10);
  static const Color cardDark = Color(0xFF2A2224);

  // ── Shadows ───────────────────────────────────────────────────
  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: primary.withAlpha(20),
          blurRadius: 20,
          offset: const Offset(0, 6),
          spreadRadius: 0,
        ),
      ];

  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: espresso.withAlpha(26),
          blurRadius: 24,
          offset: const Offset(0, 8),
          spreadRadius: -2,
        ),
      ];

  static List<BoxShadow> get accentGlow => [
        BoxShadow(
          color: accent.withAlpha(77),
          blurRadius: 16,
          offset: const Offset(0, 4),
          spreadRadius: 0,
        ),
      ];

  // ── Light Theme ─────────────────────────────────────────────────
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: primary,
          onPrimary: Colors.white,
          primaryContainer: primaryContainer,
          onPrimaryContainer: espresso,
          secondary: secondary,
          onSecondary: espresso,
          tertiary: accent,
          onTertiary: Colors.white,
          surface: surfaceLight,
          onSurface: espresso,
          surfaceContainerHighest: surfaceVariantLight,
          onSurfaceVariant: muted,
          error: error,
          onError: Colors.white,
          outline: mutedLight,
          outlineVariant: Color(0xFFEDE0D8),
        ),
        scaffoldBackgroundColor: backgroundLight,
        textTheme: _buildTextTheme(isDark: false),
        appBarTheme: AppBarThemeData(
          backgroundColor: backgroundLight,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: espresso,
            letterSpacing: 0.5,
          ),
          iconTheme: const IconThemeData(color: espresso),
        ),
        cardTheme: CardThemeData(
          color: cardLight,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        inputDecorationTheme: InputDecorationThemeData(
          filled: true,
          fillColor: surfaceVariantLight,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: mutedLight, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primary, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          labelStyle: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: muted,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: GoogleFonts.dmSans(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
            elevation: 0,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primary,
            side: const BorderSide(color: primary, width: 1.5),
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: GoogleFonts.dmSans(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(foregroundColor: espresso),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return GoogleFonts.dmSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primary,
              );
            }
            return GoogleFonts.dmSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: muted,
            );
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: Colors.white, size: 22);
            }
            return const IconThemeData(color: Color(0xFF9E8A80), size: 22);
          }),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: surfaceVariantLight,
          selectedColor: primary,
          labelStyle: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0xFFEDE0D8),
          space: 1,
          thickness: 1,
        ),
      );

  // ── Dark Theme ──────────────────────────────────────────────────
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: accentLight,
          onPrimary: espresso,
          primaryContainer: primaryLight,
          onPrimaryContainer: Colors.white,
          secondary: const Color(0xFF5A3040),
          onSecondary: Colors.white,
          tertiary: accent,
          onTertiary: espresso,
          surface: surfaceDark,
          onSurface: const Color(0xFFF0E8E4),
          surfaceContainerHighest: const Color(0xFF2E2426),
          onSurfaceVariant: const Color(0xFFBBABAA),
          error: const Color(0xFFCF6679),
          onError: Colors.white,
          outline: const Color(0xFF6A5550),
          outlineVariant: const Color(0xFF3A2E2E),
        ),
        scaffoldBackgroundColor: backgroundDark,
        textTheme: _buildTextTheme(isDark: true),
        appBarTheme: AppBarThemeData(
          backgroundColor: backgroundDark,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFF0E8E4),
            letterSpacing: 0.5,
          ),
          iconTheme: const IconThemeData(color: Color(0xFFF0E8E4)),
        ),
      );

  static TextTheme _buildTextTheme({required bool isDark}) {
    final baseColor = isDark ? const Color(0xFFF0E8E4) : espresso;
    final mutedColor = isDark ? const Color(0xFFBBABAA) : muted;

    return TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: baseColor,
        letterSpacing: -0.5,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: baseColor,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      headlineLarge: GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: baseColor,
      ),
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      headlineSmall: GoogleFonts.playfairDisplay(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      titleLarge: GoogleFonts.dmSans(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      titleMedium: GoogleFonts.dmSans(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      titleSmall: GoogleFonts.dmSans(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      bodyLarge: GoogleFonts.dmSans(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: baseColor,
        height: 1.6,
      ),
      bodyMedium: GoogleFonts.dmSans(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: baseColor,
        height: 1.5,
      ),
      bodySmall: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: mutedColor,
        height: 1.4,
      ),
      labelLarge: GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: baseColor,
        letterSpacing: 0.3,
      ),
      labelMedium: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: mutedColor,
        letterSpacing: 0.2,
      ),
      labelSmall: GoogleFonts.dmSans(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: mutedColor,
        letterSpacing: 0.2,
      ),
    );
  }
}
