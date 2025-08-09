import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class ScannedCodeProperties with EquatableMixin {
  final IList<String> allowedItemTypes;
  final IList<String> gtin;
  final String? batchLot;
  final IMap<String, String> productionDate;

  ScannedCodeProperties({
    this.batchLot,
    Iterable<String>? allowedItemTypes,
    Iterable<String>? gtin,
    this.productionDate = const IMap.empty(),
  })  : this.allowedItemTypes =
            IList.orNull(allowedItemTypes) ?? const IList<String>.empty(),
        this.gtin = IList.orNull(gtin) ?? const IList<String>.empty();

  @override
  List<Object?> get props => [allowedItemTypes, gtin, batchLot, productionDate];

  factory ScannedCodeProperties.fromJson(Map<String, dynamic> json) {
    // final valueType = ValueType.getValueType(json['type']);
    final allowedItemTypes = json['allowedItemTypes'] != null
        ? json['allowedItemTypes'].runtimeType == String
            ? jsonDecode(json['allowedItemTypes']).cast<String>()
            : json['allowedItemTypes'].cast<String>()
        : null;

    final gtin = json['gtin'] != null
        ? json['gtin'].runtimeType == String
            ? jsonDecode(json['gtin']).cast<String>()
            : json['gtin'].cast<String>()
        : null;

    final productionDate = json['productionDate'] != null
        ? Map<String, String>.from(json['productionDate'] is String
            ? jsonDecode(json['productionDate'])
            : json['productionDate'])
        : <String, String>{};

    return ScannedCodeProperties(
        allowedItemTypes: allowedItemTypes,
        gtin: gtin,
        batchLot: json['batchLot'],
        productionDate: productionDate.lock);
  }

  Map<String, dynamic> toJson() {
    return {
      'allowedItemTypes': jsonEncode(allowedItemTypes.unlockView),
      'gtin': jsonEncode(gtin.unlockView),
      'productionDate': jsonEncode(productionDate.unlock),
    };
  }
}
