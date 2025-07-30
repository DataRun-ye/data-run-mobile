import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/core/form/tree/element_tree_service.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/datasource/util/field_value.dart';
import 'package:d_sdk/datasource/util/submission_aggregator.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SubmissionAggregator)
class DetailSubmissionsTableService implements SubmissionAggregator {
  @override
  Map<String, FieldValue> extractValues(
    Map<String, dynamic> formData,
    List<Template> fieldTree,
  ) {
    Map<String, FieldValue> extractedValues = {};

    void _extract(Map<String, dynamic> data, Iterable<Template> fields) {
      fields.forEach((Template field) {
        if (field.name != null) {
          try {
            if (field is SectionTemplate && data.containsKey(field.name)) {
              if (field.repeatable && data[field.name] is List) {
                final items = data[field.name]
                    .map<Map<String, dynamic>>(
                        (item) => Map<String, dynamic>.of(item))
                    .toList();
                // summarize and extract for repeat
                _extract(
                  _sumNumericResources(items),
                  field.children,
                );
              } else {
                // extract for Section
                _extract(
                  data[field.name] ?? {},
                  ElementTreeService.getImmediateChildren(
                      field.path, field.children),
                );
              }
            } else {
              final key = field.name;
              final value = data[key];
              extractedValues[field.name!] = FieldValue(
                  id: field.id,
                  name: field.name!,
                  valueType: field.type!,
                  optionSet: field.optionSet,
                  label: field.label.unlock,
                  showInSummary: field.mainField,
                  value: value);
            }
          } catch (e) {
            logError('error extracting field: ${field.name} value', source: e);
          }
        }
      });
    }

    _extract(formData, fieldTree);

    return extractedValues;
  }

  static Map<String, double> _sumNumericResources(
      List<Map<String, dynamic>> formData) {
    Map<String, double> subTotals = {};

    void _sumResources(Map<String, dynamic> data) {
      data.forEach((key, value) {
        if (value is num) {
          subTotals[key] = (subTotals[key] ?? 0) + value.toDouble();
        } else if (value is Map<String, dynamic>) {
          _sumResources(value);
        } else if (value is List) {
          value.forEach((element) {
            if (element is Map<String, dynamic>) {
              _sumResources(element);
            }
          });
        }
      });
    }

    for (var formData in formData) {
      _sumResources(formData);
    }

    // _sumResources(formData);
    return subTotals;
  }
}
