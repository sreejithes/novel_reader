# Task: Fix Package Report Issues

- [x] Fix redundant imports
    - [x] Verified `lib/src/state/settings_provider.dart` (Already clean)
    - [x] Cleaned up `lib/novel_reader_method_channel.dart` (Keep needed imports)
- [x] Update dependencies in `pubspec.yaml` (Optimized for SDK 3.7.0)
- [x] Migrate Android to built-in Kotlin
- [x] Verify SPM support (Moved `Package.swift` to roots)
- [x] Update `CHANGELOG.md` for 1.0.3
- [x] Final verification
    - [x] `flutter analyze`
    - [x] Build check (Implicitly via analyze/pub get)
