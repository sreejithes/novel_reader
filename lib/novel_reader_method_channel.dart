import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'novel_reader_platform_interface.dart';

/// An implementation of [NovelReaderPlatform] that uses method channels.
class MethodChannelNovelReader extends NovelReaderPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('novel_reader');

  /// Invokes the native method to get the platform version.
  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
