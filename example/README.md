# Novel Reader Example

This example demonstrates how to integrate the `novel_reader` package into your Flutter application.

## 🚀 Getting Started

The `novel_reader` package provides a highly customizable reading experience with support for:

- **Dual Navigation Modes**: Vertical scroll and horizontal paging.
- **Premium Themes**: Pre-built themes like Sepia, Dark, and AMOLED.
- **Typography Control**: Integration with Google Fonts.
- **State Persistence**: Automatically saves reading progress and user settings.

## 💻 Usage

```dart
import 'package:flutter/material.dart';
import 'package:novel_reader/novel_reader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NovelReader(
        config: ReaderConfig(
          title: "My Awesome Novel",
          chapters: [
            Chapter(
              id: "1",
              title: "Chapter 1: The Beginning",
              content: "Once upon a time...",
            ),
            // Add more chapters here
          ],
        ),
      ),
    );
  }
}
```

## 🛠 Customization

You can listen to various callbacks to react to user actions:

- `onChapterChanged`: Triggered when the user navigates between chapters.
- `onThemeChanged`: Triggered when the reading theme is updated.
- `onNextChapter` / `onPreviousChapter`: Custom logic for chapter transitions.
