import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novel_reader/src/core/utils/pagination_helper.dart';

void main() {
  test('PaginationHelper splits text correctly', () {
    final longText = 'Word ' * 1000;
    final pages = PaginationHelper.paginate(
      longText,
      const TextStyle(fontSize: 16),
      300, // width
      500, // height
      TextAlign.left,
    );

    expect(pages.length, greaterThan(1));
    expect(pages.join(''), contains('Word'));
  });
}
