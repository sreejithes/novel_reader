import 'platform_service.dart';

PlatformService getPlatformService() =>
    throw UnsupportedError('Cannot create platform service');

abstract class PlatformServiceBase implements PlatformService {
  @override
  Future<void> setWakelock(bool enable) async {}

  @override
  Future<void> setBrightness(double brightness) async {}
}
