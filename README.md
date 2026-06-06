# Advanced Novel Reader

[![pub package](https://img.shields.io/pub/v/novel_reader.svg)](https://pub.dev/packages/novel_reader)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A professional-grade, highly customizable Novel/Ebook Reader package for Flutter. Designed for high-performance reading experiences with a focus on premium typography and an immersive, focus-driven UI.

## ✨ Features

- 🎨 **Premium Theme System**: Optimized palettes for Light, Dark, Sepia, AMOLED, Cream, and Slate.
- 📖 **Dual Navigation Modes**:
  - **Fluid Vertical Scroll**: Smooth scrolling with chapter-by-chapter loading.
  - **Horizontal Paging**: Physical e-reader style pagination with dynamic text fitting.
- 🔠 **Advanced Typography**:
  - Full Google Fonts integration.
  - Granular control over font size, line height, and word spacing.
  - Four-way text alignment (Left, Center, Right, Justify).
- 📱 **Immersive UI**:
  - Auto-hiding status bar and toolbars for zero distraction.
  - Intelligent tap zones: Center to toggle UI, sides for navigation.
  - Haptic feedback and smooth micro-animations.
- 💾 **Smart Persistence**: Automatically remembers theme, font settings, reading position, and current chapter.
- 🌍 **Localization**: Built-in support for multiple languages (English and Spanish included).
- 🚀 **Multi-Platform**: Native optimizations for Android, iOS, Web, Windows, macOS, and Linux.

## 🚀 Installation

Add `novel_reader` to your `pubspec.yaml`:

```yaml
dependencies:
  novel_reader: ^latest_version
```

## 🛠️ Quick Start

```dart
import 'package:flutter/material.dart';
import 'package:novel_reader/novel_reader.dart';

void main() {
  runApp(const MaterialApp(
    home: NovelReader(
      config: ReaderConfig(
        title: "The Great Gatsby",
        chapters: [
          Chapter(
            id: "1",
            title: "Chapter 1",
            content: "In my younger and more vulnerable years...",
            order: 1,
          ),
          // Add more chapters here
        ],
      ),
    ),
  ));
}
```

## ⚙️ Advanced Configuration

### Localization
To enable localized strings, add the `ReaderLocalizationsDelegate` to your `MaterialApp`:

```dart
MaterialApp(
  localizationsDelegates: [
    ReaderLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  supportedLocales: [
    const Locale('en'),
    const Locale('es'),
  ],
  home: MyReaderScreen(),
)
```

### Callbacks
Listen to reader events to sync with your backend or analytics:

```dart
NovelReader(
  config: myConfig,
  onChapterChanged: (index) => print("User moved to chapter $index"),
  onThemeChanged: (mode) => print("Theme changed to $mode"),
)
```

## 🏗️ Architecture

Built on **Riverpod** for robust state management and **Shared Preferences** for lightweight data persistence. The package follows a clean, modular architecture that is easy to extend and maintain.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
