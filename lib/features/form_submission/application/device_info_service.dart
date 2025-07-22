import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';

@injectable
class AndroidDeviceInfoService {
  AndroidDeviceInfoService({required this.androidDeviceInfo});

  final AndroidDeviceInfo? androidDeviceInfo;

  String? deviceId() => androidDeviceInfo?.id;

  String? model() => androidDeviceInfo?.model;

  String? manufacturer() => androidDeviceInfo?.manufacturer;

  String? release() => androidDeviceInfo?.version.release;

  bool? isLowRamDevice() => androidDeviceInfo?.isLowRamDevice;
}
