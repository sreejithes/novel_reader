import 'platform_service_stub.dart'
    if (dart.library.io) 'platform_service_io.dart'
    if (dart.library.js_interop) 'platform_service_web.dart';

abstract class PlatformService {
  static PlatformService get instance => getPlatformService();

  Future<void> setWakelock(bool enable);
  Future<void> setBrightness(double brightness);
}
