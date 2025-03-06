// import 'package:gs1_barcode_parser/gs1_barcode_parser.dart';
//
// class BarcodeValidator {
//
//   BarcodeValidator({
//     required this.startCode,
//     required this.fixedGtin,
//     required this.productionDateLength,
//     required this.batchNumberLength,
//     required this.serialNumberPrefix,
//     required this.serialNumberLength,
//   });
//   // Fixed parts of the barcode
//   final String startCode;
//   final String fixedGtin;
//   final int productionDateLength;
//   final int batchNumberLength;
//   final String serialNumberPrefix;
//   final int serialNumberLength;
//
//   // Method to validate the barcode
//   bool isValidBarcode(String barcode) {
//     // Check the start code
//     if (!barcode.startsWith(startCode)) {
//       return false;
//     }
//
//     // Check the GTIN (just after the start code)
//     String barcodeGtin = barcode.substring(
//         startCode.length, startCode.length + fixedGtin.length);
//     if (barcodeGtin != fixedGtin) {
//       return false;
//     }
//
//     // Calculate the start index of the remaining segments
//     int startIndex = startCode.length + fixedGtin.length;
//
//     // Check the production date (basic length check)
//     String productionDate =
//         barcode.substring(startIndex, startIndex + productionDateLength);
//     if (productionDate.length != productionDateLength) {
//       return false;
//     }
//
//     // Update the start index for the next segment
//     startIndex += productionDateLength;
//
//     // Check the batch number (basic length check)
//     String batchNumber =
//         barcode.substring(startIndex, startIndex + batchNumberLength);
//     if (batchNumber.length != batchNumberLength) {
//       return false;
//     }
//
//     // Update the start index for the next segment
//     startIndex += batchNumberLength;
//
//     // Check the serial number prefix and length
//     String serialNumber = barcode.substring(startIndex);
//     if (!serialNumber.startsWith(serialNumberPrefix) ||
//         serialNumber.length != serialNumberPrefix.length + serialNumberLength) {
//       return false;
//     }
//
//     return true;
//   }
// }
//
// void scanBarcode() async {
//   String code1 = ']C102076402178117593750\u001d1124070010104724';
//   String code2 =
//       '\u001d01076402178117591124070010104724\u001d21E6DAF62C0';
//
//   // final String barcode =
//   //     ']C101040123456789011715012910ABC1233932971471131030005253922471142127649716';
//   // final parser = GS1BarcodeParser.defaultParser();
//   // final result1 = parser.parse(code1);
//   // final GS1Barcode result2 = parser.parse(code2);
//
//   /// data = {
//   // 01 (GTIN): 07640217811759,
//   // 11 (PROD DATE): 2024-06-30 00:00:00.000,
//   // 10 (BATCH/LOT): 104724,
//   // 21 (SERIAL): E6DAF62C0,
//   // }
//   // final Content = result1.getAIData('01');
//   // final GTIN = result2.getAIData('02');
//   // final countBundle = result1.getAIData('37');
//   // final countSingle = result2.getAIData('37') ?? 1;
//   //
//   // final prodDate1 = result1.getAIData('11');
//   // final prodDate2 = result2.getAIData('11');
//   // final BATCH = result1.getAIData('10');
//   // final SERIAL = result2.getAIData('21');
//
// }
//
// void main() {
//   scanBarcode();
// }
//
// // void main() {
// //   final barcode = "]C102076402178117593750\u001d1124070010104724";
// //   final parsedFields = parseGS1Barcode(barcode);
// //
// //   print(parsedFields);
// //   // Output: {GTIN: 021123456789012345678901234567890, Quantity: 1, Production Date: 1234567890, Batch: 10123456789012345678901234567890, Serial
// //   // }
// // }
