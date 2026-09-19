# Task Tracking

- [x] Add explicit `package:state_notifier/state_notifier.dart` imports to state providers (superseded by Notifier migration)
- [x] Migrate `StateNotifier` / `StateNotifierProvider` to modern `Notifier` / `NotifierProvider`
  - [x] `lib/src/state/auto_scroll_provider.dart`
  - [x] `lib/src/state/bookmark_provider.dart`
  - [x] `lib/src/state/reading_provider.dart`
  - [x] `lib/src/state/settings_provider.dart`
- [x] Verify with static analysis (`flutter analyze`) -> 0 issues found
- [x] Verify code formatting (`dart format`) -> All files formatted
- [x] Run unit tests (`flutter test`) -> All tests passed successfully
- [x] Create walkthrough artifact
