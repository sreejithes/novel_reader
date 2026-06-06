import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novel_reader/novel_reader.dart';
import 'package:novel_reader/src/state/settings_provider.dart';
import 'package:novel_reader/src/state/reading_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SettingsProvider', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('SettingsNotifier updates font size', () async {
      final container = ProviderContainer();
      // We don't dispose immediately to avoid async race conditions with _saveSettings
      
      final notifier = container.read(settingsProvider.notifier);
      notifier.updateFontSize(20.0);
      
      final state = container.read(settingsProvider);
      expect(state.fontSize, 20.0);
    });

    test('SettingsNotifier updates theme mode', () async {
      final container = ProviderContainer();
      
      final notifier = container.read(settingsProvider.notifier);
      notifier.updateThemeMode(ReaderThemeMode.dark);
      
      final state = container.read(settingsProvider);
      expect(state.themeMode, ReaderThemeMode.dark);
    });
  });

  group('ReadingProvider', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('ReadingNotifier updates chapter index', () async {
      final container = ProviderContainer();
      
      final notifier = container.read(readingProvider.notifier);
      notifier.updateChapter(2);
      
      final state = container.read(readingProvider);
      expect(state.currentChapterIndex, 2);
    });
  });
}
