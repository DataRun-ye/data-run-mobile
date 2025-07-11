import 'package:device_info_plus/device_info_plus.dart';

class AndroidDeviceInfoService {
  AndroidDeviceInfoService({required this.deviceInfo});

  final AndroidDeviceInfo? deviceInfo;

  String? deviceId() => deviceInfo?.id;

  String? model() => deviceInfo?.model;

  String? manufacturer() => deviceInfo?.manufacturer;

  String? release() => deviceInfo?.version.release;

  bool? isLowRamDevice() => deviceInfo?.isLowRamDevice;
}
