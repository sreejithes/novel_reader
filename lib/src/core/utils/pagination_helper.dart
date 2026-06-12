import 'package:flutter/material.dart';

/// Helper class to split long text content into individual pages.
class PaginationHelper {
  /// Splits the [content] into a list of strings, where each string fits within
  /// the specified [maxWidth] and [maxHeight] given the [style] and [textAlign].
  static List<String> paginate(
    String content,
    TextStyle style,
    double maxWidth,
    double maxHeight,
    TextAlign textAlign,
  ) {
    final List<String> pages = [];
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: textAlign,
    );

    int start = 0;
    while (start < content.length) {
      int end = _findPageEnd(
        content,
        start,
        style,
        maxWidth,
        maxHeight,
        textPainter,
      );
      pages.add(content.substring(start, end));
      start = end;
    }
    return pages;
  }

  /// Binary search to find the maximum amount of text that fits in the given area.
  static int _findPageEnd(
    String content,
    int start,
    TextStyle style,
    double maxWidth,
    double maxHeight,
    TextPainter textPainter,
  ) {
    int low = start;
    int high = content.length;
    int bestEnd = start;

    while (low <= high) {
      int mid = (low + high) ~/ 2;
      textPainter.text = TextSpan(
        text: content.substring(start, mid),
        style: style,
      );
      textPainter.layout(maxWidth: maxWidth);

      if (textPainter.height <= maxHeight) {
        bestEnd = mid;
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }

    // Adjust bestEnd to not break words if possible
    if (bestEnd < content.length) {
      int spaceIndex = content.lastIndexOf(' ', bestEnd);
      if (spaceIndex > start) {
        bestEnd = spaceIndex + 1;
      }
    }

    return bestEnd;
  }
}
