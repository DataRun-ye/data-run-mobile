import 'package:d2_remote/core/datarun/utilities/date_helper.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class ScannedItemPreview extends StatelessWidget {
  const ScannedItemPreview({
    Key? key,
    required this.item,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);
  final Gs1ScannedItem item;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ScannedItemsDetailsTable(item: item),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: onAccept,
              child: Text(S.of(context).accept),
            ),
            ElevatedButton(
              onPressed: onReject,
              child: Text(S.of(context).rescan),
            ),
          ],
        ),
      ],
    );
  }
}

class ScannedItemsDetailsTable extends StatelessWidget {
  const ScannedItemsDetailsTable({
    required this.item,
    Key? key,
  }) : super(key: key);
  final Gs1ScannedItem item;

  @override
  Widget build(BuildContext context) {
    // List of item details as key-value pairs
    final List<MapEntry<String, String>> details = [
      MapEntry(S.of(context).gtin, item.gtin ?? 'N/A'),
      MapEntry(S.of(context).batch, item.batchLot ?? 'N/A'),
      MapEntry(S.of(context).serial, item.serialNumber ?? 'N/A'),
      MapEntry(
          S.of(context).productionDate,
          item.productionDate != null
              ? DateHelper.formatForUi(item.productionDate!)
              : '-'),
      MapEntry(S.of(context).count, item.count?.toString() ?? 'N/A'),
      // Add more fields if required
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1), // Title column width
          1: FlexColumnWidth(2), // Value column width
        },
        border: TableBorder.all(color: Colors.grey.shade300),
        children: details.map((entry) {
          return TableRow(
            decoration: BoxDecoration(
              color: details.indexOf(entry).isEven
                  ? Colors.grey.shade200
                  : Colors.white,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  entry.key,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  entry.value,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
