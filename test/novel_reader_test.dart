import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novel_reader/novel_reader.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Widget createTestableWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [
        ReaderLocalizationsDelegate(),
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
      ],
      home: child,
    );
  }

  testWidgets('NovelReader displays chapter title and content', (WidgetTester tester) async {
    final config = ReaderConfig(
      title: 'Test Book',
      chapters: [
        Chapter(
          id: '1',
          title: 'Chapter One',
          content: 'This is the content of chapter one.',
          order: 1,
        ),
      ],
    );

    // Pump the widget
    await tester.pumpWidget(createTestableWidget(NovelReader(config: config)));
    
    // Initial pump for ProviderScope
    await tester.pump();
    
    // Wait for any initial animations or state loading
    await tester.pumpAndSettle();

    // Verify content is visible
    expect(find.text('Chapter One'), findsOneWidget);
    expect(find.text('This is the content of chapter one.'), findsOneWidget);
  });

  testWidgets('NovelReader renders within a Scaffold', (WidgetTester tester) async {
    final config = ReaderConfig(
      title: 'Test Book',
      chapters: [
        Chapter(id: '1', title: 'C1', content: 'Content', order: 1),
      ],
    );

    await tester.pumpWidget(createTestableWidget(NovelReader(config: config)));
    await tester.pumpAndSettle();

    expect(find.byType(Scaffold), findsAtLeast(1));
  });
}
