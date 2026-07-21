import 'package:device_info_plus/device_info_plus.dart';

class AndroidDeviceInfoService {
  AndroidDeviceInfoService({required this.androidDeviceInfo});

  final AndroidDeviceInfo? androidDeviceInfo;

  String? deviceId() => androidDeviceInfo?.id;

  String? model() => androidDeviceInfo?.model;

  bool? isLowRamDevice() => androidDeviceInfo?.isLowRamDevice;
}
