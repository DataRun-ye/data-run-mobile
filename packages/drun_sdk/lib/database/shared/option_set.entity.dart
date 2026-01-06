import 'package:d_sdk/core/util/parsing_helpers.dart';
import 'package:d_sdk/database/shared/shared.dart';

class DOptionSet {
  final String listName;
  final List<FormOption> options = [];

  DOptionSet({required this.listName, List<FormOption> options = const []}) {
    this.options.addAll(options..sort((a, b) => a.order .compareTo(b.order)));
  }

  factory DOptionSet.fromJson(Map<String, dynamic> json) {
    final options = json['options'] != null
        ? (parseDynamicJson(json['options']) as List)
            .map<FormOption>((option) =>
                FormOption.fromJson({...option, 'listName': json['listName']}))
            .toList()
        : <FormOption>[];

    return DOptionSet(
        options: options..sort((a, b) => a.order.compareTo(b.order)),
        listName: json['listName']);
  }

  Map<String, dynamic> toJson() {
    return {
      'options': options.map((option) => option.toJson()).toList(),
      'listName': listName
    };
  }
}
