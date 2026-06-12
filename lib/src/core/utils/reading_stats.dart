/// Utility class to calculate reading statistics.
class ReadingStats {
  /// Estimates the reading time in minutes for the given [content].
  ///
  /// Assumes an average reading speed of 200 words per minute.
  static int calculateReadingTime(String content) {
    final wordCount = content.split(' ').length;
    // Average reading speed: 200 words per minute
    return (wordCount / 200).ceil();
  }
}
