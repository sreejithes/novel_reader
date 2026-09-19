# Package Release Readiness Check & Polish Plan

This plan outlines the final steps to ensure the `novel_reader` package is polished and ready for a professional release to pub.dev.

## User Review Required

> [!IMPORTANT]
> The current state of the package is highly functional and passes all tests/analysis. The following changes are focused on "polish" and consistency.

## Open Questions

- Should we implement the `ReaderThemeMode.custom` logic now, or keep it as a future feature and remove it from the enum for the initial stable release?
- Do we want to support multiple languages now, or is English only sufficient for the 1.0.3 release? (The infrastructure is there, but only English is implemented).

## Proposed Changes

### Core Library Polish

#### [MODIFY] [SettingsPanel](file:///C:/OtherProjects/novel_reader/lib/src/widgets/settings_panel.dart)
- Update the hardcoded version string from `v0.0.1` to `v1.0.3`.
- Use `ReaderLocalizations` for "Navigation" and "Align" labels.
- Remove `ReaderThemeMode.custom` from the UI if not fully implemented, or implement a basic version.

#### [MODIFY] [ReaderLocalizations](file:///C:/OtherProjects/novel_reader/lib/src/localization/reader_localizations.dart)
- Add missing keys: `navigation`, `alignment`, `page`.

#### [MODIFY] [ReaderPage](file:///C:/OtherProjects/novel_reader/lib/src/pages/reader_page.dart)
- Implement scroll position restoration when loading progress.
- Ensure `ReaderAppBar` handles localization if necessary (it currently uses the book title, which is fine, but may need "Back" button tooltip).

### Documentation & Examples

#### [MODIFY] [example/README.md](file:///C:/OtherProjects/novel_reader/example/README.md)
- Replace the default Flutter template with a proper explanation of the example app.

#### [MODIFY] [README.md](file:///C:/OtherProjects/novel_reader/README.md)
- Verify all links and ensure it reflects the latest features (WASM support, etc.).

## Verification Plan

### Automated Tests
- Run `flutter test` to ensure no regressions.
- Run `flutter analyze` to ensure no lint warnings.

### Manual Verification
- Run the example app and verify the "About" version.
- Verify that scrolling to a position, closing the app, and reopening it restores the position.
- Change navigation modes and verify UI labels are correctly localized (where implemented).
