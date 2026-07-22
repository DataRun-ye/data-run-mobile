import 'dart:convert';

dynamic parseDynamicField(dynamic jsonField) {
  return jsonField.runtimeType == String ? jsonDecode(jsonField) : jsonField;
}

dynamic parseDynamicJson(dynamic jsonList) {
  return jsonList.runtimeType == String ? jsonDecode(jsonList) : jsonList;
}
