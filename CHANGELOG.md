## 1.0.3

* **Web WASM Compatibility**: Removed `dart:io` dependencies to support Flutter's new WASM compilation target.
* **Improved Platform Support**: Implemented conditional imports for platform-specific plugins (WakeLock, ScreenBrightness), resolving analyzer warnings for Web, Linux, and WASM.
* **Swift Package Manager (SPM) Support**: Fixed SPM detection by moving `Package.swift` files to the root of `ios/` and `macos/` directories.
* **Modernized Android Configuration**: Migrated to the modern AGP 9.0+ **Built-in Kotlin** support, simplifying the build configuration and removing legacy plugin declarations.
* **Material 3 Compliance**: Resolved deprecation warnings for `Switch` widgets and updated to newer UI standards.
* **Optimized Dependency Constraints**: Widened dependency ranges to support latest major versions (Riverpod 3.0, Google Fonts 7.0+) while maintaining compatibility with existing environments.
* **Code Quality**: Resolved unnecessary import warnings and improved overall static analysis score.

## 1.0.2

* Initial maintenance release with minor bug fixes and metadata updates.

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
