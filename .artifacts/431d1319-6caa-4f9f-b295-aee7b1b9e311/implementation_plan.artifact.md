# Fix Package Report Issues

This plan addresses several issues identified in the package report, including redundant imports, outdated dependencies, legacy Kotlin configuration, and missing Swift Package Manager support.

## User Review Required

> [!IMPORTANT]
> The dependency updates for `flutter_riverpod` and `google_fonts` are major version bumps. While the package already supports them in its constraint range, explicitly bumping the lower bound or using the latest recommended versions will improve the package score and ensure compatibility with modern Flutter apps.

## Proposed Changes

### [Core]
Clean up redundant imports that trigger static analysis warnings.

#### [MODIFY] [reader_page.dart](file:///C:/OtherProjects/novel_reader/lib/src/pages/reader_page.dart)
- Remove `import 'package:flutter/foundation.dart';` as it is already provided by `material.dart`.

#### [MODIFY] [reader_localizations.dart](file:///C:/OtherProjects/novel_reader/lib/src/localization/reader_localizations.dart)
- Remove `import 'package:flutter/foundation.dart';` as it is already provided by `material.dart`.

---

### [Dependencies]
Update dependencies to satisfy the "Support up-to-date dependencies" check.

#### [MODIFY] [pubspec.yaml](file:///C:/OtherProjects/novel_reader/pubspec.yaml)
- Update `flutter_riverpod` to `^3.0.0` (or `^3.4.1` if available).
- Update `google_fonts` to `^7.0.0` (or `^8.2.0` if available).
- Update `intl` to `^0.20.0`.
- Update `wakelock_plus` and other plugins to their latest versions.

---

### [Android]
Migrate to the modern AGP 9.0+ "built-in Kotlin" support to remove legacy configuration warnings.

#### [MODIFY] [build.gradle](file:///C:/OtherProjects/novel_reader/android/build.gradle)
- Remove `id "kotlin-android"` from the `plugins` block.
- Update `sourceSets` to use the standard Kotlin directory configuration.
- Remove the `kotlin { jvmToolchain(11) }` block as it's now handled by `compileOptions`.

---

### [Swift Package Manager]
Ensure SPM support is correctly detected by the package manager.

#### [MODIFY] [Package.swift](file:///C:/OtherProjects/novel_reader/ios/novel_reader/Package.swift)
- Double-check the path and structure. The current structure seems correct, but I will re-verify it against the latest Flutter SPM guidelines.

#### [MODIFY] [Package.swift](file:///C:/OtherProjects/novel_reader/macos/novel_reader/Package.swift)
- Same as iOS.

---

## Verification Plan

### Automated Tests
- Run `flutter analyze` to ensure no new warnings or errors are introduced.
- Run `flutter pub get` and `flutter pub outdated` to verify dependency resolution.
- (If possible) Run `gradlew lint` in the `android/` directory to check for configuration issues.

### Manual Verification
- Verify the example app builds and runs on Android and iOS.
- Check that the reader functionality (themes, font size) still works correctly after dependency updates.
