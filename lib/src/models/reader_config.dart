import 'chapter.dart';

/// Configuration for the [NovelReader] widget.
///
/// Contains the novel's title and the list of [Chapter]s to be displayed.
class ReaderConfig {
  /// The overall title of the novel or book.
  final String title;

  /// The list of chapters available in the reader.
  final List<Chapter> chapters;

  /// The index of the chapter to show when the reader is first opened.
  final int initialChapterIndex;

  /// Optional unique identifier for the book, used for persistence.
  final String? bookId;

  /// Creates a [ReaderConfig] instance.
  ReaderConfig({
    required this.title,
    required this.chapters,
    this.initialChapterIndex = 0,
    this.bookId,
  });
}
