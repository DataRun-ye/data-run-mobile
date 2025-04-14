import 'dart:async';

import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
import 'package:datarunmobile/data_run/screens/form/field_widgets/code_scanner/scanned_items_table.dart';
import 'package:datarunmobile/data_run/screens/form/field_widgets/code_scanner/scanner_button_widgets.dart';
import 'package:datarunmobile/data_run/screens/form/field_widgets/code_scanner/scanner_error_widget.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:gs1_barcode_parser/gs1_barcode_parser.dart';

typedef ScanPreviewBuilder = Widget Function(Gs1ScannedItem? scannedItem);

ScannedCodeProperties scannedCodeProperties = ScannedCodeProperties(
  allowedItemTypes: ['00', '01', '21'],
  gtin: ['7640217*'],
);

class BarcodeScannerWidget extends StatefulWidget {
  const BarcodeScannerWidget({
    super.key,
    this.controller,
    this.previewBuilder,
    this.initialRawCode,
  });

  final ScanPreviewBuilder? previewBuilder;
  final String? initialRawCode;
  final MobileScannerController? controller;

  @override
  _BarcodeScannerWidgetState createState() => _BarcodeScannerWidgetState();
}

class _BarcodeScannerWidgetState extends State<BarcodeScannerWidget>
    with WidgetsBindingObserver {
  late final MobileScannerController _controller;
  StreamSubscription<Object?>? _subscription;
  String? _rawCode;

  bool showError = false;
  // final parser = GS1BarcodeParser.defaultParser();
  Timer? _errorTimer;

  Gs1ScannedItem? parsedItem;

  void _handleBarcode(BarcodeCapture barcodeCapture) {
    final Barcode? barcode = barcodeCapture.barcodes.firstOrNull;

    if (barcode?.rawValue != null) {
      final item = parseRawCode(barcode!.rawValue!);

      if (item != null && CodeValidator.validate(item)) {
        setState(() {
          _rawCode = barcode.rawValue;
          parsedItem = item;
          _controller.stop();
        });
      } else {
        _showError();
      }
    } else {
      _showError();
    }
  }

  void _showError() {
    setState(() {
      showError = true;
    });
    _errorTimer?.cancel();
    _errorTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showError = false;
        });
      }
    });
  }

  void resumeScanning() {
    setState(() {
      _rawCode = null;
      parsedItem = null;
      _controller.start();
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? MobileScannerController();
    _subscription = _controller.barcodes.listen(_handleBarcode);
    if (widget.initialRawCode != null) {
      _rawCode = widget.initialRawCode;
      parsedItem = parseRawCode(widget.initialRawCode!);
    } else {
      logDebug('Start barcode scan Controller');
      unawaited(_controller.start());
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_controller.value.hasCameraPermission) {
      logError('- # hasCameraPermission');
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        logDebug('- # AppLifecycleState: detached, hidden, paused');
        return;
      case AppLifecycleState.resumed:
        logDebug('- # AppLifecycleState.resumed:');
        logDebug('resuming listening barcode scan Controller');
        _subscription = _controller.barcodes.listen(_handleBarcode);
        logDebug('start barcode scan Controller');
        unawaited(_controller.start());
      case AppLifecycleState.inactive:
        logDebug('- # AppLifecycleState.inactive:');
        logDebug('cancel _subscription to barcode scan Controller');
        unawaited(_subscription?.cancel());
        _subscription = null;
        logDebug('stopping barcode scan Controller');
        unawaited(_controller.stop());
    }
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    _errorTimer?.cancel();
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: Key('Scaffold_Kam_S_stack_809'),
      appBar: AppBar(
        title: Text(
            '${_rawCode != null ? S.of(context).acceptCode : S.of(context).scanBarcode}'),
      ),
      body: _buildScannerOrPreview(),
    );
  }

  Widget _buildScannerOrPreview() {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: 200,
      height: 200,
    );

    if (parsedItem == null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: _controller,
            scanWindow: scanWindow,
            errorBuilder: (context, error, child) {
              return ScannerErrorWidget(error: error);
            },
            fit: BoxFit.cover,
          ),
          ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, value, child) {
              if (!value.isInitialized ||
                  !value.isRunning ||
                  value.error != null) {
                return const SizedBox();
              }

              return CustomPaint(
                painter: ScannerOverlay(scanWindow),
              );
            },
          ),
          if (showError)
            Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.red,
                child: Text(
                  S.of(context).invalidScannedCode,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              color: Colors.black.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ToggleFlashlightButton(controller: _controller),
                  SwitchCameraButton(controller: _controller),
                ],
              ),
            ),
          ),
        ],
      );
    } else if (widget.previewBuilder != null) {
      return widget.previewBuilder!(parsedItem);
    } else {
      return ScannedItemPreview(
        item: parsedItem!,
        onAccept: () => Navigator.pop(context, _rawCode),
        onReject: resumeScanning,
      );
    }
  }
}

Gs1ScannedItem? parseRawCode(String rawCode) {
  try {
    final parser = GS1BarcodeParser.defaultParser();
    final GS1Barcode parsedCode = parser.parse(rawCode);
    return Gs1ScannedItem.fromScannedCode(parsedCode);
  } catch (e) {
    logError('Failed to parse raw code: $rawCode', data: {'error': e});
    return null; // Return null for invalid codes
  }
}

class CodeValidator {
  static bool validate(Gs1ScannedItem gs1Item) {
    try {
      if (gs1Item.gtin == null) {
        return false;
      }

      final allowedItemTypes = scannedCodeProperties.allowedItemTypes;

      if (allowedItemTypes.isNotEmpty &&
          !(gs1Item.AIs ?? []).any((t) => allowedItemTypes.contains(t))) {
        return false;
      }

      final gtinPatterns = scannedCodeProperties.gtin;
      if (gtinPatterns.isNotEmpty &&
          !gtinPatterns
              .any((pattern) => _matchesPattern(gs1Item.gtin, pattern))) {
        return false;
      }
      // Validate BATCH/LOT
      final batchRegex = scannedCodeProperties.batchLot;
      if (batchRegex != null &&
          !RegExp(batchRegex).hasMatch(gs1Item.batchLot ?? '')) {
        return false;
      }

      return true;
    } catch (e) {
      logError('Error:', data: {'error details': e});
      return false;
    }
  }

  /// Check if a value matches a wildcard pattern
  static bool _matchesPattern(String? value, String pattern) {
    if (value == null) return false;
    final regex = RegExp(pattern.replaceAll('*', '.*'));
    return regex.hasMatch(value);
  }
}

class ParsingException extends DException {
  ParsingException(String? message, Object? cause)
      : super(message ?? 'FormElementException: element error.', cause);
}

class ScannerOverlay extends CustomPainter {
  ScannerOverlay(this.scanWindow);

  final Rect scanWindow;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: use `Offset.zero & size` instead of Rect.largest
    // we need to pass the size to the custom paint widget
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()..addRect(scanWindow);

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BarcodeOverlay extends CustomPainter {
  BarcodeOverlay({
    required this.barcodeCorners,
    required this.barcodeSize,
    required this.boxFit,
    required this.cameraPreviewSize,
  });

  final List<Offset> barcodeCorners;
  final Size barcodeSize;
  final BoxFit boxFit;
  final Size cameraPreviewSize;

  @override
  void paint(Canvas canvas, Size size) {
    if (barcodeCorners.isEmpty ||
        barcodeSize.isEmpty ||
        cameraPreviewSize.isEmpty) {
      return;
    }

    final adjustedSize = applyBoxFit(boxFit, cameraPreviewSize, size);

    double verticalPadding = size.height - adjustedSize.destination.height;
    double horizontalPadding = size.width - adjustedSize.destination.width;
    if (verticalPadding > 0) {
      verticalPadding = verticalPadding / 2;
    } else {
      verticalPadding = 0;
    }

    if (horizontalPadding > 0) {
      horizontalPadding = horizontalPadding / 2;
    } else {
      horizontalPadding = 0;
    }

    final double ratioWidth;
    final double ratioHeight;

    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      ratioWidth = barcodeSize.width / adjustedSize.destination.width;
      ratioHeight = barcodeSize.height / adjustedSize.destination.height;
    } else {
      ratioWidth = cameraPreviewSize.width / adjustedSize.destination.width;
      ratioHeight = cameraPreviewSize.height / adjustedSize.destination.height;
    }

    final List<Offset> adjustedOffset = [
      for (final offset in barcodeCorners)
        Offset(
          offset.dx / ratioWidth + horizontalPadding,
          offset.dy / ratioHeight + verticalPadding,
        ),
    ];

    final cutoutPath = Path()..addPolygon(adjustedOffset, true);

    final backgroundPaint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    canvas.drawPath(cutoutPath, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
