# Implementation Plan - Fix Static Analysis Issues for StateNotifier Providers

## Problem Statement
Static analysis (using strict lints/rules such as `lints_core`) fails with 64 issues, starting with:
- `ERROR: The function 'StateNotifierProvider' isn't defined.` in `lib/src/state/auto_scroll_provider.dart`
- `ERROR: Classes can only extend other classes.` in `lib/src/state/auto_scroll_provider.dart`

This is caused by missing explicit imports of `package:state_notifier/state_notifier.dart` in files that extend `StateNotifier`.

## Proposed Changes

### State Providers
Add explicit `import 'package:state_notifier/state_notifier.dart';` to all state provider files that extend `StateNotifier`:

#### [MODIFY] [auto_scroll_provider.dart](file:///C:/OtherProjects/novel_reader/lib/src/state/auto_scroll_provider.dart)
- Add `import 'package:state_notifier/state_notifier.dart';`

#### [MODIFY] [bookmark_provider.dart](file:///C:/OtherProjects/novel_reader/lib/src/state/bookmark_provider.dart)
- Add `import 'package:state_notifier/state_notifier.dart';`

#### [MODIFY] [reading_provider.dart](file:///C:/OtherProjects/novel_reader/lib/src/state/reading_provider.dart)
- Add `import 'package:state_notifier/state_notifier.dart';`

#### [MODIFY] [settings_provider.dart](file:///C:/OtherProjects/novel_reader/lib/src/state/settings_provider.dart)
- Add `import 'package:state_notifier/state_notifier.dart';`

## Verification Plan

### Automated Tests
1. Run `flutter analyze` to ensure 0 errors, warnings, or lints.
2. Run `dart format --output=none --set-exit-if-changed .` to verify code formatting.
3. Run `flutter test` to ensure all unit and widget tests pass successfully.
