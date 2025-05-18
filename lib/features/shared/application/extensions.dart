import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
import 'package:d_sdk/database/app_database.dart';

extension FormTemplateLabelExtension on FormTemplate {
  String get displayLabel => getItemLocalString(label, defaultString: name);
}
