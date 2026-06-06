import 'package:flutter_test/flutter_test.dart';
import 'package:novel_reader/novel_reader.dart';

void main() {
  group('Chapter Model', () {
    test('Chapter initialization', () {
      final chapter = Chapter(
        id: '1',
        title: 'Title',
        content: 'Content',
        order: 1,
      );
      expect(chapter.id, '1');
      expect(chapter.title, 'Title');
      expect(chapter.content, 'Content');
      expect(chapter.order, 1);
    });
  });

  group('ReaderConfig Model', () {
    test('ReaderConfig initialization', () {
      final config = ReaderConfig(
        title: 'Book',
        chapters: [
          Chapter(id: '1', title: 'C1', content: 'C1', order: 1),
        ],
      );
      expect(config.title, 'Book');
      expect(config.chapters.length, 1);
    });
  });

  group('ReadingSettings Model', () {
    test('ReadingSettings copyWith works correctly', () {
      final settings = ReadingSettings();
      final updated = settings.copyWith(fontSize: 24.0, themeMode: ReaderThemeMode.dark);
      
      expect(updated.fontSize, 24.0);
      expect(updated.themeMode, ReaderThemeMode.dark);
      expect(updated.fontFamily, settings.fontFamily); // Should remain default
    });
  });
}
