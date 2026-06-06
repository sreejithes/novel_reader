import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart' as web;

import 'novel_reader_platform_interface.dart';

/// A web implementation of the [NovelReaderPlatform].
class NovelReaderWeb extends NovelReaderPlatform {
  /// Constructs a [NovelReaderWeb] instance.
  NovelReaderWeb();

  /// Registers this class as the default web implementation.
  static void registerWith(Registrar registrar) {
    NovelReaderPlatform.instance = NovelReaderWeb();
  }

  /// Returns the browser's user agent string as the platform version.
  @override
  Future<String?> getPlatformVersion() async {
    final version = web.window.navigator.userAgent;
    return version;
  }
}
