import 'package:d_sdk/core/common/standard_extensions.dart';
import 'package:datarunmobile/commons/errors_management/d_error_localization.dart';
import 'package:datarunmobile/commons/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// @injectable
class ResourceManager {
  const ResourceManager();

  String getString(String stringResource) {
    return Intl.message(
      stringResource,
      name: stringResource,
      desc: '',
      args: <Object>[],
    );
  }

  String getTeamLabel(String? teamCode) {
    return '${getString('team')} $teamCode';
  }

  Icon getObjectStyleDrawableResource(
      IconData? icon, IconData defaultResource) {
    return icon?.let((IconData it) => Icon(icon)) ?? Icon(defaultResource);
    // return icon?.let {
    // val iconName = if (icon.startsWith("ic_")) icon else "ic_$icon"
    // val iconResource =
    // getWrapperContext().resources.getIdentifier(
    // iconName,
    // "drawable",
    // getWrapperContext().packageName
    // )
    // if (iconResource != 0 && iconResource != -1 && drawableExists(iconResource)
    // ) {
    // iconResource
    // } else {
    // drawable.ic_default_icon
    // }
    // } ?: defaultResource
  }

  bool drawableExists(String iconResource) {
    return true;
    // return try {
    // ContextCompat.getDrawable(getWrapperContext(), iconResource)
    // true
    // } catch (e: Exception) {
    // false
    // }
  }

  Color? getColorFrom(String? hexColor) {
    return convertHexStringToColor(hexColor);
    // return hexColor?.let {
    // ColorUtils.parseColor(it)
    // } ?: -1
  }

  // Color getColorOrDefaultFrom(String? hexColor) {
  //   return convertHexStringToColor(hexColor) ??
  //       Theme.of(navigatorKey.currentContext!).colorScheme.primary;
  // }

  String parseD2Error(Exception throwable) {
    return ErrorMessage.getMessage(throwable);
  }
}
