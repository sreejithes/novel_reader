import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../models/reading_settings.dart';

/// Provider for the [ReadingSettings] state.
final settingsProvider =
    StateNotifierProvider<SettingsNotifier, ReadingSettings>((ref) {
      return SettingsNotifier();
    });

/// Notifier that manages reading settings and persists them to local storage.
class SettingsNotifier extends StateNotifier<ReadingSettings> {
  /// Creates a [SettingsNotifier] and loads initial settings.
  SettingsNotifier() : super(ReadingSettings()) {
    _loadSettings();
  }

  /// Loads reading settings from [SharedPreferences].
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    state = ReadingSettings(
      fontSize: prefs.getDouble('font_size') ?? 18.0,
      fontFamily: prefs.getString('font_family') ?? 'Default',
      themeMode:
          ReaderThemeMode.values[prefs.getInt('theme_mode') ??
              3], // Default Sepia
      scrollMode: ScrollMode.values[prefs.getInt('scroll_mode') ?? 0],
      lineHeight: prefs.getDouble('line_height') ?? 1.5,
      brightness: prefs.getDouble('brightness') ?? 1.0,
      keepScreenAwake: prefs.getBool('keep_awake') ?? true,
      textAlign: TextAlign.values[prefs.getInt('text_align') ?? 0],
    );
    _applySystemSettings();
  }

  /// Applies system-level settings like brightness and wake lock.
  Future<void> _applySystemSettings() async {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return;
    }
    try {
      if (state.keepScreenAwake) {
        await WakelockPlus.enable();
      } else {
        await WakelockPlus.disable();
      }

      if (!state.useSystemBrightness) {
        await ScreenBrightness().setApplicationScreenBrightness(
          state.brightness,
        );
      }
    } catch (e) {
      debugPrint('System settings not supported on this platform: $e');
    }
  }

  /// Updates the font size and persists the change.
  void updateFontSize(double size) {
    state = state.copyWith(fontSize: size.clamp(10, 40));
    _saveSettings();
  }

  /// Updates the theme mode and persists the change.
  void updateThemeMode(ReaderThemeMode mode) {
    state = state.copyWith(themeMode: mode);
    _saveSettings();
  }

  /// Updates the scroll mode and persists the change.
  void updateScrollMode(ScrollMode mode) {
    state = state.copyWith(scrollMode: mode);
    _saveSettings();
  }

  /// Updates the font family and persists the change.
  void updateFontFamily(String family) {
    state = state.copyWith(fontFamily: family);
    _saveSettings();
  }

  /// Toggles the wake lock setting and persists the change.
  void toggleKeepAwake(bool value) {
    state = state.copyWith(keepScreenAwake: value);
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      _saveSettings();
      return;
    }
    try {
      if (value) {
        WakelockPlus.enable();
      } else {
        WakelockPlus.disable();
      }
    } catch (e) {
      debugPrint('Wakelock not supported: $e');
    }
    _saveSettings();
  }

  /// Updates the line height and persists the change.
  void updateLineHeight(double height) {
    state = state.copyWith(lineHeight: height);
    _saveSettings();
  }

  /// Updates the text alignment and persists the change.
  void updateTextAlign(TextAlign align) {
    state = state.copyWith(textAlign: align);
    _saveSettings();
  }

  /// Updates the screen brightness and persists the change.
  void updateBrightness(double value) {
    state = state.copyWith(brightness: value, useSystemBrightness: false);
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      _saveSettings();
      return;
    }
    try {
      ScreenBrightness().setApplicationScreenBrightness(value);
    } catch (e) {
      debugPrint('Brightness control not supported: $e');
    }
    _saveSettings();
  }

  /// Toggles the status bar visibility setting and persists the change.
  void toggleHideStatusBar(bool value) {
    state = state.copyWith(hideStatusBar: value);
    _saveSettings();
  }

  /// Persists current state to [SharedPreferences].
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('font_size', state.fontSize);
    await prefs.setString('font_family', state.fontFamily);
    await prefs.setInt('theme_mode', state.themeMode.index);
    await prefs.setInt('scroll_mode', state.scrollMode.index);
    await prefs.setDouble('brightness', state.brightness);
    await prefs.setBool('keep_awake', state.keepScreenAwake);
    await prefs.setDouble('line_height', state.lineHeight);
    await prefs.setBool('hide_status_bar', state.hideStatusBar);
    await prefs.setInt('text_align', state.textAlign.index);
  }
}
