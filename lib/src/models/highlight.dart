import 'package:flutter/material.dart';

/// Represents a highlighted section of text within a chapter.
class Highlight {
  /// Unique identifier for the highlight.
  final String id;

  /// The index of the chapter containing the highlighted text.
  final int chapterIndex;

  /// The character offset where the highlight begins.
  final int startOffset;

  /// The character offset where the highlight ends.
  final int endOffset;

  /// The color of the highlight marker.
  final Color color;

  /// The date and time when the highlight was created.
  final DateTime timestamp;

  /// Creates a [Highlight] instance.
  Highlight({
    required this.id,
    required this.chapterIndex,
    required this.startOffset,
    required this.endOffset,
    required this.color,
    required this.timestamp,
  });
}
