part of '../../../form_submission/application/element/form_element.dart';

class Gs1ScannedItem with EquatableMixin {
  factory Gs1ScannedItem.fromMap(Map<String, dynamic> map) {
    return Gs1ScannedItem(
      AIs: map['AIs'] as Iterable<String>,
      isBundle: map['isBundle'] as bool,
      isSingleItem: map['isSingleItem'] as bool,
      isSSCC: map['isSSCC'] as bool,
      gtin: map['gtin'] as String?,
      batchLot: map['batchLot'] as String?,
      productionDate: map['productionDate'] as DateTime?,
      serialNumber: map['serialNumber'] as String?,
      count: map['count'] as int?,
    );
  }
  const Gs1ScannedItem({
    this.AIs,
    required this.isBundle,
    required this.isSingleItem,
    required this.isSSCC,
    this.gtin,
    this.batchLot,
    this.productionDate,
    this.serialNumber,
    this.count,
  });

  factory Gs1ScannedItem.fromScannedCode(GS1Barcode? barcode) {
    bool isBundle =
        (barcode?.hasAI('02') ?? false) && (barcode?.hasAI('37') ?? false);
    bool isSingleItem =
        (barcode?.hasAI('01') ?? false) && (barcode?.hasAI('21') ?? false);
    bool isSSCC = (barcode?.hasAI('00') ?? false);

    return Gs1ScannedItem(
      gtin: barcode?.getAIRawData('01') ??
          barcode?.getAIRawData('02') ??
          barcode?.getAIRawData('00'),
      isBundle: isBundle || isSSCC,
      isSingleItem: isSingleItem,
      isSSCC: isSSCC,
      batchLot: barcode?.getAIRawData('10'),
      productionDate: barcode?.getAIData('11'),
      serialNumber: barcode?.getAIRawData('21'),
      count: isBundle
          ? int.tryParse(barcode!.getAIRawData('37')!)
          : isSSCC
              ? 50
              : 1,
      AIs: barcode?.elements.keys,
    );
  }

  final Iterable<String>? AIs;

  /// Determines if the code represents a bundle
  final bool isBundle;

  /// Determines if the code represents a single item
  final bool isSingleItem;

  /// Determines if the code represents a 'Serial Shipping Container Code (SSCC)'
  /// code: '00',
  ///       fixLength: 18,
  ///       type: AIFormatType.FIXED_LENGTH,
  ///       description: 'Serial Shipping Container Code (SSCC)',
  ///       dataTitle: 'SSCC',
  ///       regExpString: r'^00(\d{18})$',
  final bool isSSCC;

  /// Consistent for items of the same type
  final String? gtin;

  /// Batch/Lot number, consistent for items in the same batch
  final String? batchLot;

  /// Production date, consistent for items in the same batch
  final DateTime? productionDate;

  // /// Production date, consistent for items in the same batch
  // String? get productionDateRaw => barcode?.getAIData('11');

  /// Serial number, exclusive to single items
  final String? serialNumber;

  /// Quantity of items in the bundle or one for single item
  final int? count;

  /// Utility method to display key information
  String getDetails() {
    if (isBundle) {
      return 'GTIN: ${gtin}, Batch: ${batchLot}, Production Date: ${productionDate}) | ${count} items';
    } else if (isSingleItem) {
      return 'GTIN: ${gtin}, Serial: ${serialNumber}, Batch: ${batchLot}, Production Date: ${productionDate}) | ${count} item';
    } else {
      return 'Unknown type';
    }
  }

  Gs1ScannedItem copyWith({
    Iterable<String>? AIs,
    bool? isBundle,
    bool? isSingleItem,
    String? gtin,
    String? batchLot,
    DateTime? productionDate,
    String? serialNumber,
    int? count,
  }) {
    return Gs1ScannedItem(
      AIs: AIs ?? this.AIs,
      isBundle: isBundle ?? this.isBundle,
      isSingleItem: isSingleItem ?? this.isSingleItem,
      isSSCC: isSSCC,
      gtin: gtin ?? this.gtin,
      batchLot: batchLot ?? this.batchLot,
      productionDate: productionDate ?? this.productionDate,
      serialNumber: serialNumber ?? this.serialNumber,
      count: count ?? this.count,
    );
  }

  @override
  List<Object?> get props => [
        isBundle,
        isSingleItem,
        gtin,
        batchLot,
        productionDate,
        serialNumber,
        count
      ];

  Map<String, dynamic> toMap() {
    return {
      'AIs': this.AIs,
      'isBundle': this.isBundle,
      'isSingleItem': this.isSingleItem,
      'isSSCC': this.isSSCC,
      'gtin': this.gtin,
      'batchLot': this.batchLot,
      'productionDate': this.productionDate,
      'serialNumber': this.serialNumber,
      'count': this.count,
    };
  }
}
//
// void main() {
//   String code1 = ']C102076402178117593750\u001d1124070010104724';
//   String code2 = '\u001d01076402178117591124070010104724\u001d21E6DAF62C0';
//   final parser = GS1BarcodeParser.defaultParser();
//   final GS1Barcode parsedCode1 = parser.parse(code1);
//   final GS1Barcode parsedCode2 = parser.parse(code2);
//
//   Gs1ScannedItem bundleCode = Gs1ScannedItem.fromScannedCode(parsedCode1);
//   Gs1ScannedItem singleItemCode = Gs1ScannedItem.fromScannedCode(parsedCode2);
//
//   print(bundleCode
//       .getDetails()); // Output: Bundle of 50 items (GTIN: 07640217811759, Batch: 104724, Production Date: 2024-06-30 00:00:00.000)
//   print(singleItemCode
//       .getDetails()); // Output: Single item (GTIN: 07640217811759, Serial: E6DAF62C0, Batch: 104724, Production Date: 2024-06-30 00:00:00.000)
// }
