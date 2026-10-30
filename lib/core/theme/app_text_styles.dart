import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  // =========================
  // Display Styles
  // =========================
  static TextStyle get displayLarge => const TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w700,
    height: 64 / 57, // Line height / Font size
    letterSpacing: 0,
  );

  static TextStyle get displayMedium => const TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w700, // Medium
    height: 52 / 45,
    letterSpacing: 0,
  );

  static TextStyle get displaySmall => const TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 44 / 36,
    letterSpacing: 0,
  );

  // =========================
  // Headline Styles
  // =========================
  static TextStyle get headlineLarge => const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 40 / 32,
    letterSpacing: 0,
  );

  static TextStyle get headlineMedium => const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700, // Medium
    height: 36 / 28,
    letterSpacing: 0,
  );

  static TextStyle get headlineSmall => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 32 / 24,
    letterSpacing: 0,
  );

  // =========================
  // Title Styles (Medium Weight)
  // =========================
  static TextStyle get titleLarge => const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600, // Medium
    height: 28 / 22,
    letterSpacing: 0,
  );

  static TextStyle get titleMedium => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600, // Medium
    height: 24 / 16,
    letterSpacing: 0.15,
  );

  static TextStyle get titleSmall => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600, // Medium
    height: 20 / 14,
    letterSpacing: 0.1,
  );

  // =========================
  // Label Styles (Medium Weight)
  // =========================
  static TextStyle get labelLarge => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600, // Medium
    height: 20 / 14,
    letterSpacing: 0.1,
  );

  static TextStyle get labelMedium => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500, // Medium
    height: 16 / 12,
    letterSpacing: 0.5,
  );

  static TextStyle get labelSmall => const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500, // Medium
    height: 16 / 11,
    letterSpacing: 0.5,
  );

  // =========================
  // Body Styles (Regular Weight)
  // =========================
  static TextStyle get bodyLarge => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
    height: 24 / 16,
    letterSpacing: 0.15,
  );

  static TextStyle get bodyMedium => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400, // Regular
    height: 20 / 14,
    letterSpacing: 0.25,
  );

  static TextStyle get bodySmall => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400, // Regular
    height: 16 / 12,
    letterSpacing: 0.4,
  );

  // =========================
  // Custom Styles (للأرقام والمصروفات)
  // =========================
  static TextStyle get amountLarge =>
      const TextStyle(fontSize: 34, fontWeight: FontWeight.w800);

  static TextStyle get amountMedium =>
      const TextStyle(fontSize: 26, fontWeight: FontWeight.w700);

  static TextStyle get amountSmall =>
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w700);

  // Buttons
  static TextStyle get button =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

  // Caption
  static TextStyle get caption =>
      const TextStyle(fontSize: 11, fontWeight: FontWeight.w400);

  // Overline
  static TextStyle get overline => const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 1,
  );
}
