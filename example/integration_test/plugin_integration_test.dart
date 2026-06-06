import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:novel_reader/novel_reader.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('NovelReader integration test', (WidgetTester tester) async {
    final config = ReaderConfig(
      title: 'Integration Test Novel',
      chapters: [
        Chapter(
          id: '1',
          title: 'Chapter 1',
          content: 'Content for integration test.',
          order: 1,
        ),
      ],
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: NovelReader(config: config)));

    // Wait for providers and animations
    await tester.pumpAndSettle();

    // Verify that our novel title is shown.
    expect(find.text('Integration Test Novel'), findsOneWidget);
    expect(find.text('Chapter 1'), findsOneWidget);
  });
}
