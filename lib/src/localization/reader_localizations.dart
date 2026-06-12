import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Provides localized strings for the [NovelReader] package.
class ReaderLocalizations {
  /// Creates a [ReaderLocalizations] instance for the given [locale].
  ReaderLocalizations(this.locale);

  /// The current locale.
  final Locale locale;

  /// Helper method to retrieve localizations from the [BuildContext].
  static ReaderLocalizations of(BuildContext context) {
    return Localizations.of<ReaderLocalizations>(context, ReaderLocalizations)!;
  }

  static const _localizedValues = {
    'en': {
      'settings': 'Settings',
      'fontSize': 'Font Size',
      'theme': 'Theme',
      'fontFamily': 'Font Family',
      'lineSpacing': 'Line Spacing',
      'navigationMode': 'Navigation Mode',
      'vertical': 'Vertical',
      'horizontal': 'Horizontal',
      'keepAwake': 'Keep Screen Awake',
      'hideStatusBar': 'Hide Status Bar',
      'brightness': 'Brightness',
      'previous': 'Previous',
      'next': 'Next',
      'search': 'Search',
      'clear': 'Clear',
      'noResults': 'No results found',
    },
  };

  /// Localized string for 'Settings'.
  String get settings => _localizedValues['en']!['settings']!;

  /// Localized string for 'Font Size'.
  String get fontSize => _localizedValues['en']!['fontSize']!;

  /// Localized string for 'Theme'.
  String get theme => _localizedValues['en']!['theme']!;

  /// Localized string for 'Font Family'.
  String get fontFamily => _localizedValues['en']!['fontFamily']!;

  /// Localized string for 'Line Spacing'.
  String get lineSpacing => _localizedValues['en']!['lineSpacing']!;

  /// Localized string for 'Navigation Mode'.
  String get navigationMode => _localizedValues['en']!['navigationMode']!;

  /// Localized string for 'Vertical'.
  String get vertical => _localizedValues['en']!['vertical']!;

  /// Localized string for 'Horizontal'.
  String get horizontal => _localizedValues['en']!['horizontal']!;

  /// Localized string for 'Keep Screen Awake'.
  String get keepAwake => _localizedValues['en']!['keepAwake']!;

  /// Localized string for 'Hide Status Bar'.
  String get hideStatusBar => _localizedValues['en']!['hideStatusBar']!;

  /// Localized string for 'Brightness'.
  String get brightness => _localizedValues['en']!['brightness']!;

  /// Localized string for 'Previous'.
  String get previous => _localizedValues['en']!['previous']!;

  /// Localized string for 'Next'.
  String get next => _localizedValues['en']!['next']!;

  /// Localized string for 'Search'.
  String get search => _localizedValues['en']!['search']!;

  /// Localized string for 'Clear'.
  String get clear => _localizedValues['en']!['clear']!;

  /// Localized string for 'No results found'.
  String get noResults => _localizedValues['en']!['noResults']!;
}

/// [LocalizationsDelegate] for [ReaderLocalizations].
class ReaderLocalizationsDelegate
    extends LocalizationsDelegate<ReaderLocalizations> {
  /// Creates a [ReaderLocalizationsDelegate] instance.
  const ReaderLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<ReaderLocalizations> load(Locale locale) {
    return SynchronousFuture<ReaderLocalizations>(ReaderLocalizations(locale));
  }

  @override
  bool shouldReload(ReaderLocalizationsDelegate old) => false;
}
