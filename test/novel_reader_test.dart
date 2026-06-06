import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novel_reader/novel_reader.dart';

void main() {
  testWidgets('NovelReader renders title and content', (WidgetTester tester) async {
    final config = ReaderConfig(
      title: 'Test Novel',
      chapters: [
        Chapter(
          id: '1',
          title: 'Chapter 1',
          content: 'Test Content',
          order: 1,
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NovelReader(config: config),
        ),
      ),
    );

    // Initial pump for ProviderScope and first frame
    await tester.pump();

    expect(find.text('Test Novel'), findsOneWidget);
    expect(find.text('Chapter 1'), findsOneWidget);
    expect(find.text('Test Content'), findsOneWidget);
  });
}
