import 'package:d_sdk/database/app_database.dart';

Map<String, dynamic> sumActualResources(
    List<DataSubmission> submissions, List<String> resourceKeys) {
  try {
    Map<String, dynamic> totalResources = {};

    for (var submission in submissions) {
      var actualResources =
          extractAndSumValues(submission.formData ?? {}, resourceKeys);
      actualResources.forEach((key, value) {
        totalResources[key] = (totalResources[key] ?? 0) + value;
      });
    }

    return totalResources;
  } catch (e) {}
  return {'itns': 0, 'population': 0, 'households': 0};
}

Map<String, dynamic> extractAndSumValues(
    Map<String, dynamic> formData, List<String> keys) {
  Map<String, dynamic> result = {};
  List<String> lowerCaseKeys = keys.map((key) => key.toLowerCase()).toList();

  void extractValues(Map<String, dynamic> data, String key) {
    data.forEach((k, v) {
      if (k.toLowerCase() == key) {
        if (v is num) {
          result[key] = (result[key] ?? 0) + v;
        }
      } else if (v is Map<String, dynamic>) {
        extractValues(v, key);
      } else if (v is List) {
        for (var item in v) {
          if (item is Map<String, dynamic>) {
            extractValues(item, key);
          }
        }
      }
    });
  }

  for (var key in lowerCaseKeys) {
    extractValues(formData, key);
  }

  return result;
}

Map<String, dynamic> comparePlannedVsActual(
    Map<String, dynamic> plannedResources, Map<String, dynamic> formData) {
  List<String> keys = plannedResources.keys.toList();
  Map<String, dynamic> actualValues = extractAndSumValues(formData, keys);

  Map<String, dynamic> comparison = {};
  plannedResources.forEach((key, plannedValue) {
    comparison[key] = {
      'planned': plannedValue,
      'actual': actualValues[key] ?? 0,
    };
  });

  return comparison;
}
