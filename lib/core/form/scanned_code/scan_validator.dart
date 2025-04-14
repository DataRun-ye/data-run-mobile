import 'package:d_sdk/core/form/field_template/field_template.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';

class ScanValidator {
  ScanValidator(this.template);
  final FieldTemplate template;

  /// Validate the scanned barcode
  bool validate(Gs1ScannedItem barcode) {
    if (template.scannedCodeProperties != null) {
      final scannedCodeProperties = template.scannedCodeProperties!;
      final allowedItemTypes = scannedCodeProperties.allowedItemTypes;

      // Check item type
      if (allowedItemTypes.isNotEmpty &&
          !(barcode.AIs ?? []).any((t) => allowedItemTypes.contains(t))) {
        return false;
      }

      // Validate constraints
      final productionDate = scannedCodeProperties.productionDate;
      if (productionDate.isNotEmpty) {
        /// get production date from AI parsed element if present
        final prodDate = barcode.productionDate;
        // if (prodDate != null) {
        final minDate = DateTime.tryParse(productionDate['min']!);
        final maxDate = DateTime.tryParse(productionDate['max']!);
        if (prodDate == null) {
          return false;
        }
        if (minDate != null && prodDate.isBefore(minDate)) {
          return false;
        }
        if (maxDate != null && prodDate.isAfter(maxDate)) {
          return false;
        }
      }
      // Validate GTIN
      final gtinPatterns = scannedCodeProperties.gtin;
      if (gtinPatterns.isNotEmpty &&
          !gtinPatterns
              .any((pattern) => _matchesPattern(barcode.gtin, pattern))) {
        return false;
      }
      // Validate BATCH/LOT
      final batchRegex = scannedCodeProperties.batchLot;
      if (batchRegex != null &&
          !RegExp(batchRegex).hasMatch(barcode.batchLot ?? '')) {
        return false;
      }
    }
    return true;
  }

  /// Check if a value matches a wildcard pattern
  bool _matchesPattern(String? value, String pattern) {
    if (value == null) return false;
    final regex = RegExp(pattern.replaceAll('*', '.*'));
    return regex.hasMatch(value);
  }
}
