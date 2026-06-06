/// A high-performance, customizable Novel/Ebook reader package for Flutter.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/pages/reader_page.dart';
import 'src/models/reader_config.dart';
import 'src/models/reading_settings.dart';

export 'src/models/chapter.dart';
export 'src/models/reader_config.dart';
export 'src/models/reading_settings.dart';
export 'src/theme/reader_theme.dart';
export 'src/localization/reader_localizations.dart';

/// The primary widget for displaying a novel or book.
///
/// Use this widget to provide a complete reading experience, including
/// chapter navigation, theme customization, and persistence.
///
/// Example:
/// ```dart
/// NovelReader(
///   config: ReaderConfig(
///     title: "The Great Gatsby",
///     chapters: [
///       Chapter(id: "1", title: "Chapter 1", content: "..."),
///     ],
///   ),
///   onChapterChanged: (index) => print("Now reading chapter $index"),
/// )
/// ```
class NovelReader extends StatelessWidget {
  /// Configuration containing the title and chapters of the novel.
  final ReaderConfig config;

  /// Callback triggered when the user requests the next chapter.
  final VoidCallback? onNextChapter;

  /// Callback triggered when the user requests the previous chapter.
  final VoidCallback? onPreviousChapter;

  /// Callback triggered whenever the current chapter index changes.
  final Function(int)? onChapterChanged;

  /// Callback triggered when the user changes the reader's theme mode.
  final Function(ReaderThemeMode)? onThemeChanged;

  /// Creates a [NovelReader] widget.
  const NovelReader({
    super.key,
    required this.config,
    this.onNextChapter,
    this.onPreviousChapter,
    this.onChapterChanged,
    this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ReaderPage(
        config: config,
        onNextChapter: onNextChapter,
        onPreviousChapter: onPreviousChapter,
        onChapterChanged: onChapterChanged,
      ),
    );
  }
}
