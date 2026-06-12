# Advanced Novel Reader 📖

[![pub package](https://img.shields.io/pub/v/novel_reader.svg)](https://pub.dev/packages/novel_reader)

A professional-grade, highly customizable **Novel & Ebook Reader** package for Flutter. Designed for high-performance reading experiences with a focus on premium typography and an immersive, distraction-free UI.

---

## ✨ Features

- 🎨 **Adaptive Theme System**: Sophisticated pre-built palettes including:
  - **Light & Dark**: Standard reading modes.
  - **Sepia & Cream**: Eye-friendly classic book styles.
  - **AMOLED**: Pure black for OLED efficiency.
  - **Gray & Slate**: Low-contrast professional themes.
- 📖 **Dual Navigation Modes**:
  - **Fluid Vertical Scroll**: Standard continuous scrolling experience.
  - **Horizontal Paging**: Physical e-reader style pagination with dynamic text fitting based on screen size.
- 🔠 **Premium Typography**:
  - Full **Google Fonts** integration.
  - Granular control over **font size** (12px to 36px), **line height**, and **letter spacing**.
  - Four-way **text alignment**: Left, Center, Right, and Justify.
- 📱 **Immersive Focus UI**:
  - Automatically hides status bar and toolbars while reading.
  - **Intelligent Tap Zones**: Center to toggle controls; sides for rapid navigation.
  - **Haptic Feedback**: Native vibration responses on Android and iOS.
- 💾 **State Persistence**: Automatically remembers and restores theme, font settings, and reading progress (current chapter and scroll position).
- 🌍 **Localization**: Built-in support for multiple languages.
- 🚀 **Multi-Platform**: Native optimizations for **Android, iOS, Web, Windows, macOS, and Linux**.

---

## 🛠️ Installation

Add `novel_reader` to your `pubspec.yaml`:

```yaml
dependencies:
  novel_reader: ^1.0.0
```

Then, run:
```bash
flutter pub get
```

---

## 🚀 Quick Start

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
          // Add more chapters for the full experience
        ],
      ),
    ),
  ));
}
```

---

## ⚙️ Advanced Configuration

### 🌍 Localization
To use the built-in localized strings, register the `ReaderLocalizationsDelegate` in your `MaterialApp`:

```dart
MaterialApp(
  localizationsDelegates: const [
    ReaderLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: const [
    Locale('en'),
  ],
  home: MyReaderScreen(),
)
```

### ⌨️ Desktop & Web Support
On non-mobile platforms, the reader supports native keyboard shortcuts out of the box:
- **Navigation**: `Arrow Right` / `Arrow Left`.
- **Zoom Control**: `Ctrl +` and `Ctrl -` to adjust font size instantly.
- **UI Toggle**: `Space` to show/hide bars, `Esc` to hide.

### 📱 Mobile Specifics
- **Haptic Feedback**: Integrated native vibrations for interactive settings.
- **Hardware Controls**: Direct control over screen brightness and **"Keep Awake"** (WakeLock) via the settings panel.

### 🔗 Event Callbacks
Sync reading progress with your backend or analytics:

```dart
NovelReader(
  config: myConfig,
  onChapterChanged: (index) => print("User moved to chapter $index"),
  onThemeChanged: (mode) => print("Theme updated to $mode"),
  onNextChapter: () => print("User clicked next"),
)
```

---

## 🏗️ Architecture

Built on **Riverpod** for robust state management and **Shared Preferences** for lightweight data persistence. The package follows a clean, modular architecture separating models, state, and specialized widgets, making it easy to extend for custom needs.

---

## 🤝 Contributing

Contributions are welcome! If you find a bug or have a feature request, please open an issue on [GitHub](https://github.com/sreejithes/novel_reader/issues). Pull requests are also appreciated.

---

## 🔗 Links

- **Repository**: [github.com/sreejithes/novel_reader](https://github.com/sreejithes/novel_reader)
- **Issues**: [github.com/sreejithes/novel_reader/issues](https://github.com/sreejithes/novel_reader/issues)

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
