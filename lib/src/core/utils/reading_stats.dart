class ReadingStats {
  static int calculateReadingTime(String content) {
    final wordCount = content.split(' ').length;
    // Average reading speed: 200 words per minute
    return (wordCount / 200).ceil();
  }
}
