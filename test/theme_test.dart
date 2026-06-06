import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novel_reader/novel_reader.dart';

void main() {
  group('ReaderTheme', () {
    test('getTheme returns correct colors for Light mode', () {
      final theme = ReaderTheme.getTheme(ReaderThemeMode.light);
      expect(theme.backgroundColor, const Color(0xFFFFFFFF));
      expect(theme.textColor, const Color(0xFF1A1A1A));
    });

    test('getTheme returns correct colors for Dark mode', () {
      final theme = ReaderTheme.getTheme(ReaderThemeMode.dark);
      expect(theme.backgroundColor, const Color(0xFF1A1A1A));
      expect(theme.textColor, const Color(0xFFE0E0E0));
    });

    test('getTheme returns correct colors for AMOLED mode', () {
      final theme = ReaderTheme.getTheme(ReaderThemeMode.amoled);
      expect(theme.backgroundColor, Colors.black);
      expect(theme.textColor, const Color(0xFFFFFFFF));
    });

    test('getTheme returns correct colors for Sepia mode', () {
      final theme = ReaderTheme.getTheme(ReaderThemeMode.sepia);
      expect(theme.backgroundColor, const Color(0xFFF4ECD8));
      expect(theme.textColor, const Color(0xFF433422));
    });
  });
}
