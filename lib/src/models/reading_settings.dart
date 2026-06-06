import 'package:flutter/material.dart';

/// Available theme modes for the reader.
enum ReaderThemeMode {
  /// Standard light theme with white background.
  light,

  /// Standard dark theme with dark gray background.
  dark,

  /// Pure black background optimized for OLED/AMOLED screens.
  amoled,

  /// Warm, yellowish background resembling aged paper.
  sepia,

  /// Light cream background for soft reading.
  cream,

  /// Gray background for low-contrast reading.
  gray,

  /// User-defined custom theme.
  custom
}

/// Defines how the content is navigated.
enum ScrollMode {
  /// Content flows vertically in a single continuous scroll.
  vertical,

  /// Content is split into screen-sized pages that are flipped horizontally.
  horizontal
}

/// Holds all the user-customizable reading preferences.
class ReadingSettings {
  /// The size of the main body text in logical pixels.
  final double fontSize;

  /// The font family name to be used for the content.
  final String fontFamily;

  /// The current color scheme selected for the reader.
  final ReaderThemeMode themeMode;

  /// The navigation style (vertical scrolling vs horizontal paging).
  final ScrollMode scrollMode;

  /// The multiplier for the line height (e.g., 1.5 for 1.5x spacing).
  final double lineHeight;

  /// Horizontal space between characters.
  final double letterSpacing;

  /// Horizontal space between words.
  final double wordSpacing;

  /// Vertical space between paragraphs.
  final double paragraphSpacing;

  /// The horizontal alignment of the text (left, center, right, or justify).
  final TextAlign textAlign;

  /// The brightness level specifically for the reader screen (0.0 to 1.0).
  final double brightness;

  /// Whether to use the global system brightness or the reader-specific one.
  final bool useSystemBrightness;

  /// Whether to prevent the device from going to sleep while the reader is open.
  final bool keepScreenAwake;

  /// Whether to hide the system status bar during reading.
  final bool hideStatusBar;

  /// Whether to enter full-screen immersive mode.
  final bool fullScreenMode;

  /// Creates a [ReadingSettings] instance with default values.
  ReadingSettings({
    this.fontSize = 18.0,
    this.fontFamily = 'Default',
    this.themeMode = ReaderThemeMode.sepia,
    this.scrollMode = ScrollMode.vertical,
    this.lineHeight = 1.5,
    this.letterSpacing = 0.0,
    this.wordSpacing = 0.0,
    this.paragraphSpacing = 15.0,
    this.textAlign = TextAlign.left,
    this.brightness = 1.0,
    this.useSystemBrightness = true,
    this.keepScreenAwake = true,
    this.hideStatusBar = false,
    this.fullScreenMode = false,
  });

  /// Creates a copy of these settings but with the given fields replaced with new values.
  ReadingSettings copyWith({
    double? fontSize,
    String? fontFamily,
    ReaderThemeMode? themeMode,
    ScrollMode? scrollMode,
    double? lineHeight,
    double? letterSpacing,
    double? wordSpacing,
    double? paragraphSpacing,
    TextAlign? textAlign,
    double? brightness,
    bool? useSystemBrightness,
    bool? keepScreenAwake,
    bool? hideStatusBar,
    bool? fullScreenMode,
  }) {
    return ReadingSettings(
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      themeMode: themeMode ?? this.themeMode,
      scrollMode: scrollMode ?? this.scrollMode,
      lineHeight: lineHeight ?? this.lineHeight,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      paragraphSpacing: paragraphSpacing ?? this.paragraphSpacing,
      textAlign: textAlign ?? this.textAlign,
      brightness: brightness ?? this.brightness,
      useSystemBrightness: useSystemBrightness ?? this.useSystemBrightness,
      keepScreenAwake: keepScreenAwake ?? this.keepScreenAwake,
      hideStatusBar: hideStatusBar ?? this.hideStatusBar,
      fullScreenMode: fullScreenMode ?? this.fullScreenMode,
    );
  }
}
