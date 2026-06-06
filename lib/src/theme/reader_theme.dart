import 'package:flutter/material.dart';
import '../models/reading_settings.dart';

/// Defines the color palette for the reader.
class ReaderTheme {
  /// The background color of the reading area and toolbars.
  final Color backgroundColor;

  /// The primary color for the body text.
  final Color textColor;

  /// The color used for interactive elements like sliders and active buttons.
  final Color accentColor;

  /// Creates a [ReaderTheme] instance.
  ReaderTheme({
    required this.backgroundColor,
    required this.textColor,
    required this.accentColor,
  });

  /// Returns the pre-defined [ReaderTheme] for a given [ReaderThemeMode].
  static ReaderTheme getTheme(ReaderThemeMode mode) {
    switch (mode) {
      case ReaderThemeMode.light:
        return ReaderTheme(
          backgroundColor: const Color(0xFFFFFFFF),
          textColor: const Color(0xFF1A1A1A),
          accentColor: const Color(0xFF2196F3),
        );
      case ReaderThemeMode.dark:
        return ReaderTheme(
          backgroundColor: const Color(0xFF1A1A1A),
          textColor: const Color(0xFFE0E0E0),
          accentColor: const Color(0xFF64B5F6),
        );
      case ReaderThemeMode.amoled:
        return ReaderTheme(
          backgroundColor: Colors.black,
          textColor: const Color(0xFFFFFFFF),
          accentColor: const Color(0xFFBB86FC),
        );
      case ReaderThemeMode.sepia:
        return ReaderTheme(
          backgroundColor: const Color(0xFFF4ECD8),
          textColor: const Color(0xFF433422),
          accentColor: const Color(0xFF8B4513),
        );
      case ReaderThemeMode.cream:
        return ReaderTheme(
          backgroundColor: const Color(0xFFFFF9E3),
          textColor: const Color(0xFF3E2723),
          accentColor: const Color(0xFF795548),
        );
      case ReaderThemeMode.gray:
        return ReaderTheme(
          backgroundColor: const Color(0xFF2C2C2C),
          textColor: const Color(0xFFBDBDBD),
          accentColor: const Color(0xFF90A4AE),
        );
      case ReaderThemeMode.custom:
        return ReaderTheme(
          backgroundColor: Colors.white,
          textColor: Colors.black,
          accentColor: Colors.blue,
        );
    }
  }
}
