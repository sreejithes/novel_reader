## 1.0.2

* **Web WASM Compatibility**: Removed `dart:io` dependencies to support Flutter's new WASM compilation target.
* **Swift Package Manager (SPM) Support**: Added `Package.swift` for iOS and macOS, following the new Flutter plugin standard.
* **Modernized Android Configuration**: Migrated to the modern Gradle plugins DSL and updated Kotlin configurations.
* **Material 3 Compliance**: Resolved deprecation warnings for `Switch` widgets and updated to newer UI standards.
* **Updated Dependencies**: Bumped multiple dependencies to their highest compatible versions for the current Dart SDK.

## 1.0.1

* **Enhanced Reader Theme**: Expanded `ReaderTheme` with secondary text, surface, divider, and selection colors for more granular UI control.
* **Improved UI Consistency**: Refined default themes (Light, Dark, Sepia, etc.) with better color balance.

## 1.0.0

* **Initial Release** of Advanced Novel Reader.
* Professional-grade UI with full-screen immersive reading mode.
* Support for **Vertical Scrolling** and **Horizontal Paging** (E-reader style).
* Integrated **Theme System**: Light, Dark, Sepia, AMOLED, Cream, and Gray.
* Advanced **Typography Controls**: Font size, Google Fonts, line height, and text alignment.
* Automatic **State Persistence**: Remembers progress, theme, and settings.
* Cross-platform support: Android, iOS, Web, Windows, macOS, and Linux.
* Native **Hardware Integration**: Brightness control, WakeLock, and Haptics (Mobile).
* Desktop **Keyboard Shortcuts**: Navigation, Zoom, and UI toggles.
* Optimized for performance with **Riverpod** state management.
