/// Represents a user-created bookmark at a specific position in a novel.
class Bookmark {
  /// Unique identifier for the bookmark.
  final String id;

  /// The index of the chapter where the bookmark was created.
  final int chapterIndex;

  /// The title of the chapter for display in lists.
  final String chapterTitle;

  /// The scroll position (vertical) or page index (horizontal) saved.
  final double position;

  /// The date and time when the bookmark was created.
  final DateTime timestamp;

  /// Optional user-written note attached to the bookmark.
  final String? note;

  /// Creates a [Bookmark] instance.
  Bookmark({
    required this.id,
    required this.chapterIndex,
    required this.chapterTitle,
    required this.position,
    required this.timestamp,
    this.note,
  });

  /// Converts the bookmark to a JSON map for storage.
  Map<String, dynamic> toJson() => {
        'id': id,
        'chapterIndex': chapterIndex,
        'chapterTitle': chapterTitle,
        'position': position,
        'timestamp': timestamp.toIso8601String(),
        'note': note,
      };

  /// Creates a [Bookmark] from a JSON map.
  factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        id: json['id'],
        chapterIndex: json['chapterIndex'],
        chapterTitle: json['chapterTitle'],
        position: json['position'],
        timestamp: DateTime.parse(json['timestamp']),
        note: json['note'],
      );
}
