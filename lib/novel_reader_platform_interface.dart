import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'novel_reader_method_channel.dart';

/// The interface that implementations of novel_reader must implement.
abstract class NovelReaderPlatform extends PlatformInterface {
  /// Constructs a NovelReaderPlatform.
  NovelReaderPlatform() : super(token: _token);

  static final Object _token = Object();

  static NovelReaderPlatform _instance = MethodChannelNovelReader();

  /// The default instance of [NovelReaderPlatform] to use.
  ///
  /// Defaults to [MethodChannelNovelReader].
  static NovelReaderPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NovelReaderPlatform] when
  /// they register themselves.
  static set instance(NovelReaderPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Returns the platform version string.
  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
