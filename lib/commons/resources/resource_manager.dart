import 'package:d2_remote/modules/datarun/common/standard_extensions.dart';
import 'package:datarun/commons/errors_management/d_error_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datarun/utils/mass_utils/colors.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resource_manager.g.dart';

@riverpod
ResourceManager resourceManager(ResourceManagerRef ref) {
  return ResourceManager(ref);
}

class ResourceManager {
  const ResourceManager(this.ref);

  final ResourceManagerRef ref;

  String getString(String stringResource) {
    return Intl.message(
      stringResource,
      name: stringResource,
      desc: '',
      args: <Object>[],
    );
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

  String defaultEventLabel() => getString('events');

  String defaultDataSetLabel() => getString('string.data_sets');

  String defaultTeiLabel() => getString('tei');

  String jiraIssueSentMessage() => getString('string.jira_issue_sent');

  String jiraIssueSentErrorMessage() =>
      getString('string.jira_issue_sent_error');

  String sectionFeedback() => getString('string.section_feedback');

  String sectionIndicators() => getString('string.section_indicators');

  String sectionCharts() => getString('string.section_charts');

  String sectionChartsAndIndicators() =>
      getString('string.section_charts_indicators');

  String defaultIndicatorLabel() => getString('string.info');
}
