// import 'dart:async';
// import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
// import 'package:datarunmobile/data_run/screens/form/field_widgets/code_scanner/reactive_gs1_code_scan_details.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:gs1_barcode_parser/gs1_barcode_parser.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:datarunmobile/data_run/form/scanned_code/scanned_items_notifier.dart';
// import 'package:datarunmobile/data_run/form/scanned_code/scan_validator.dart';
// import 'package:d_sdk/core/datarun/utilities/date_utils.dart';
// import 'package:d_sdk/core/logging/new_app_logging.dart';
//
// import '../field_widgets/code_scanner/reactive_code_scan_field.dart';
//
// class ScanGs1Items extends StatefulHookConsumerWidget {
//   ScanGs1Items({
//     super.key,
//     this.validator,
//     this.onScan,
//   });
//
//   final ScanValidator? validator;
//   final OnGs1Scan? onScan;
//
//   @override
//   _ScanBottomSheetState createState() => _ScanBottomSheetState();
// }
//
// class _ScanBottomSheetState extends ConsumerState<ScanGs1Items> {
//   StreamSubscription<dynamic>? _scanSubscription;
//
//   void handleScan(String scannedBarcode) {
//     final parser = GS1BarcodeParser.defaultParser();
//     final gs1Barcode = parser.parse(scannedBarcode);
//     final gs1BarcodeModel = Gs1ScannedItem.fromScannedCode(gs1Barcode);
//     if (!isDuplicate(gs1BarcodeModel)) {
//       if (widget.validator != null) {
//         if (widget.validator!.validate(gs1BarcodeModel)) {
//           addScannedItem(gs1BarcodeModel);
//           _scanSubscription
//               ?.cancel(); // Stop scanning when a valid item is found
//         } else {
//           showSnackBar('Invalid scan!');
//         }
//       } else {
//         addScannedItem(gs1BarcodeModel);
//         _scanSubscription?.cancel();
//       }
//     } else {
//       showSnackBar('Duplicate item!');
//     }
//   }
//
//   void addScannedItem(Gs1ScannedItem gs1BarcodeModel) {
//     ref.read(gs1ScannedItemsNotifierProvider.notifier).addItem(gs1BarcodeModel);
//     showSnackBar('Item added successfully!');
//     widget.onScan?.call(gs1BarcodeModel);
//     if (mounted) return;
//     Navigator.pop(context); // Close the camera
//   }
//
//   void showSnackBar(String message) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(message)));
//   }
//
//   void startScanning() {
//     try {
//       _scanSubscription = FlutterBarcodeScanner.getBarcodeStreamReceiver(
//         '#ff6666',
//         'Cancel',
//         true,
//         ScanMode.BARCODE,
//       )?.listen((barcode) => handleScan(barcode));
//     } on PlatformException {
//       logError('Failed to get platform version.');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Expanded(
//           child: const ScannedItemsTable(),
//         ),
//         ElevatedButton(
//           onPressed: startScanning,
//           child: const Text('Scan Again'),
//         ),
//       ],
//     );
//   }
//
//   bool isDuplicate(Gs1ScannedItem barcodeModel) {
//     return ref.read(gs1ScannedItemsNotifierProvider).contains(barcodeModel);
//   }
//
//   @override
//   void dispose() {
//     _scanSubscription
//         ?.cancel(); // Ensure the subscription is cancelled when the widget is disposed
//     super.dispose();
//   }
// }
//
// class ScannedItemsTable extends HookConsumerWidget {
//   const ScannedItemsTable({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final items = ref.watch(gs1ScannedItemsNotifierProvider);
//
//     return DataTable(
//       columns: const [
//         DataColumn(label: Text('GTIN')),
//         DataColumn(label: Text('Production Date')),
//         DataColumn(label: Text('Batch/Lot')),
//         DataColumn(label: Text('Serial')),
//         DataColumn(label: Text('Quantity')),
//         DataColumn(label: Text('Type')),
//       ],
//       rows: items.map((item) {
//         return DataRow(cells: [
//           DataCell(Text(item.gtin ?? '-')),
//           DataCell(Text(item.productionDate != null
//               ? DDateUtils.uiDateFormat().format(item.productionDate!)
//               : '-')),
//           DataCell(Text(item.batchLot ?? '-')),
//           DataCell(Text(item.serialNumber ?? '-')),
//           DataCell(Text((item.bundleCount ?? '-').toString())),
//           DataCell(Text(item.isBundle ? 'Bundle' : 'Single Item')),
//         ]);
//       }).toList(),
//     );
//   }
// }
//
// // class ScanScreen extends StatefulHookConsumerWidget {
// //   ScanScreen({
// //     super.key,
// //     this.validator,
// //   });
// //
// //   final ScanValidator? validator;
// //
// //   @override
// //   _ScanScreenState createState() => _ScanScreenState();
// // }
// //
// // class _ScanScreenState extends ConsumerState<ScanScreen> {
// //   StreamSubscription<dynamic>? _scanSubscription;
// //   Gs1BarcodeModel? item;
// //
// //   void handleScan(String scannedBarcode) {
// //     final parser = GS1BarcodeParser.defaultParser();
// //     final gs1Barcode = parser.parse(scannedBarcode);
// //     final gs1BarcodeModel = Gs1BarcodeModel(gs1Barcode);
// //     if (!isDuplicate(gs1BarcodeModel)) {
// //       if (widget.validator != null) {
// //         if (widget.validator!.validate(gs1BarcodeModel)) {
// //           addItem(gs1BarcodeModel);
// //           _scanSubscription
// //               ?.cancel(); // Stop scanning when a valid item is found
// //         } else {
// //           showSnackBar('Invalid scan!');
// //         }
// //       } else {
// //         addItem(gs1BarcodeModel);
// //         _scanSubscription?.cancel(); // Stop scanning when a valid item is found
// //       }
// //     } else {
// //       showSnackBar('Duplicate item!');
// //     }
// //   }
// //
// //   void addItem(Gs1BarcodeModel gs1BarcodeModel) {
// //     setState(() {
// //       item = gs1BarcodeModel;
// //     });
// //     showSnackBar('Item added successfully!');
// //   }
// //
// //   void showSnackBar(String message) {
// //     ScaffoldMessenger.of(context)
// //         .showSnackBar(SnackBar(content: Text(message)));
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         Expanded(
// //           child: ScannedItem(item: item),
// //         ),
// //         ElevatedButton(
// //           onPressed: () async {
// //             try {
// //               /// this opens the barcode scanner (camera)
// //               _scanSubscription =
// //                   FlutterBarcodeScanner.getBarcodeStreamReceiver(
// //                 '#ff6666',
// //                 'Cancel',
// //                 true,
// //                 ScanMode.BARCODE,
// //               )?.listen((barcode) => handleScan(barcode));
// //             } on PlatformException {
// //               logError('Failed to get platform version.');
// //             }
// //           },
// //           child: const Text('Scan Again'),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   bool isDuplicate(Gs1BarcodeModel barcodeModel) {
// //     return ref.read(gs1ScannedItemsNotifierProvider).contains(barcodeModel);
// //   }
// //
// //   @override
// //   void dispose() {
// //     _scanSubscription
// //         ?.cancel(); // Ensure the subscription is cancelled when the widget is disposed
// //     super.dispose();
// //   }
// // }
// //
// // class ScannedItem extends HookConsumerWidget {
// //   ScannedItem({super.key, this.item});
// //
// //   final Gs1BarcodeModel? item;
// //   void addItem(Gs1BarcodeModel gs1BarcodeModel, WidgetRef ref) {
// //     ref.read(gs1ScannedItemsNotifierProvider.notifier).addItem(gs1BarcodeModel);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     return Placeholder();
// //   }
// // }
// //
// // class ScannedItemsTable extends HookConsumerWidget {
// //   const ScannedItemsTable({super.key});
// //
// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final items = ref.watch(gs1ScannedItemsNotifierProvider);
// //
// //     return DataTable(
// //       columns: const [
// //         DataColumn(label: Text('GTIN')),
// //         DataColumn(label: Text('Production Date')),
// //         DataColumn(label: Text('Batch/Lot')),
// //         DataColumn(label: Text('Serial')),
// //         DataColumn(label: Text('Quantity')),
// //         DataColumn(label: Text('Type')),
// //       ],
// //       rows: items.map((item) {
// //         return DataRow(cells: [
// //           DataCell(Text(item.gtin ?? '-')),
// //           DataCell(Text(item.productionDate != null
// //               ? DDateUtils.uiDateFormat().format(item.productionDate!)
// //               : '-')),
// //           DataCell(Text(item.batchLot ?? '-')),
// //           DataCell(Text(item.serialNumber ?? '-')),
// //           DataCell(Text((item.bundleCount ?? '-').toString())),
// //           DataCell(Text(item.isBundle ? 'Bundle' : 'Single Item')),
// //         ]);
// //       }).toList(),
// //     );
// //   }
// // }
