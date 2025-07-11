import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool isDesktop(BuildContext context) {
  final data = MediaQueryData.fromView(View.of(context));
  return data.size.width >= 600; // Adjust breakpoint as needed
}

// TODOremove this function
bool supportsInlineBrowser() => !isDesktopOS();

// TODOremove this function
bool supportsGoogleOAuth() => kIsWeb || isMobileOS();

// TODOremove this function
bool supportsAppleOAuth() => kIsWeb || isApple();

// TODOremove this function
bool supportsMicrosoftOAuth() => kIsWeb;

bool isDesktopOS() => isMacOS() || isWindows() || isLinux();

bool isMobileOS() => isAndroid() || isIOS();

bool isApple() {
  if (kIsWeb) {
    return false;
  }

  return Platform.isIOS || Platform.isMacOS;
}

bool isMacOS() {
  if (kIsWeb) {
    return false;
  }

  return Platform.isMacOS;
}

bool isWindows() {
  if (kIsWeb) {
    return false;
  }

  return Platform.isWindows;
}

bool isLinux() {
  if (kIsWeb) {
    return false;
  }

  return Platform.isLinux;
}

bool isAndroid() {
  if (kIsWeb) {
    return false;
  }

  return Platform.isAndroid;
}

bool isIOS() {
  if (kIsWeb) {
    return false;
  }

  return Platform.isIOS;
}

String getMapURL(BuildContext context) => isApple()
    ? 'https://maps.apple.com/?address='
    : 'https://maps.google.com/?q=';

String getLegacyAppURL(BuildContext context) => isAndroid()
    ? 'https://play.google.com/store/apps/details?id=com.invoiceninja.invoiceninja'
    : 'https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1220337560&mt=8';

String getPlatformLetter() {
  if (kIsWeb) {
    return 'C';
  } else {
    if (Platform.isIOS) {
      return 'I';
    } else if (Platform.isAndroid) {
      return 'A';
    } else if (Platform.isWindows) {
      return 'W';
    } else if (Platform.isLinux) {
      return 'L';
    } else if (Platform.isMacOS) {
      return 'M';
    } else if (Platform.isFuchsia) {
      return 'F';
    }
  }

  return 'U';
}

String getPlatformName() {
  if (kIsWeb) {
    return 'Web';
  } else {
    if (Platform.isIOS) {
      return 'iOS';
    } else if (Platform.isAndroid) {
      return 'Android';
    } else if (Platform.isWindows) {
      return 'Windows';
    } else if (Platform.isLinux) {
      return 'Linux';
    } else if (Platform.isMacOS) {
      return 'macOS';
    } else if (Platform.isFuchsia) {
      return 'Fuchsia';
    }
  }

  return 'Unknown';
}

// String getNativePlatform() {
//   String userAgent = WebUtils.getHtmlValue('user-agent') ?? '';
//   userAgent = userAgent.toLowerCase();
//
//   if (userAgent.contains('ipad') ||
//       userAgent.contains('ipod') ||
//       userAgent.contains('iphone')) {
//     return kPlatformiPhone;
//   } else if (userAgent.contains('android')) {
//     return kPlatformAndroid;
//   } else if (userAgent.contains('win')) {
//     return kPlatformWindows;
//   } else if (userAgent.contains('mac')) {
//     return kPlatformMacOS;
//   } else if (userAgent.contains('linux')) {
//     return kPlatformLinux;
//   } else {
//     return '';
//   }
// }

// String getNativeAppUrl(String platform) {
//   switch (platform) {
//     case kPlatformAndroid:
//       return kGoogleStoreUrl;
//     case kPlatformiPhone:
//       return kAppleStoreUrl;
//     case kPlatformWindows:
//       return kWindowsUrl;
//     case kPlatformMacOS:
//       return kMacOSUrl;
//     case kPlatformLinux:
//       return kLinuxUrl;
//   }
//
//   return '';
// }

// AppLayout getLayout(BuildContext context) =>
//     context.read<AppBloc>().state.prefState.appLayout;

bool isMobile(BuildContext context) =>
    true; //getLayout(context) == AppLayout.mobile;

bool isNotMobile(BuildContext context) => !isMobile(context);

// bool isDesktop(BuildContext context) =>
//     false; //getLayout(context) == AppLayout.desktop;

bool isNotDesktop(BuildContext context) => !isDesktop(context);

bool isDarkMode(BuildContext context) =>
    false; //context.select((AppBloc bloc) => bloc.state.prefState.enableDarkMode);
