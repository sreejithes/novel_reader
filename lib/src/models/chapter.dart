/// Represents a single chapter in a novel.
class Chapter {
  /// Unique identifier for the chapter.
  final String id;

  /// The title of the chapter.
  final String title;

  /// The plain text content of the chapter.
  final String content;

  /// The display order or sequence number of the chapter.
  final int order;

  /// Creates a [Chapter] instance.
  Chapter({
    required this.id,
    required this.title,
    required this.content,
    required this.order,
  });
}
