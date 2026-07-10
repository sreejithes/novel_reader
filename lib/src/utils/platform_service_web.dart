import 'platform_service.dart';

PlatformService getPlatformService() => PlatformServiceWeb();

class PlatformServiceWeb implements PlatformService {
  @override
  Future<void> setWakelock(bool enable) async {
    // Web implementation could use Screen Wake Lock API if needed,
    // but for now we'll just skip to keep dependencies clean.
  }

  @override
  Future<void> setBrightness(double brightness) async {
    // Brightness control is not typically available in browsers.
  }
}
