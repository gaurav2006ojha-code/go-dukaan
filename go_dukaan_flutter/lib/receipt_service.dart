import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart'
    as thermal;
import 'package:flutter_thermal_printer/utils/printer.dart' as thermal_utils;
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart' as escpos;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReceiptLine {
  final String name;
  final int quantity;
  final double unitPrice;
  final double lineTotal;

  const ReceiptLine({
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.lineTotal,
  });
}

class ReceiptData {
  final String shopName;
  final String ownerName;
  final String invoiceNumber;
  final DateTime createdAt;
  final List<ReceiptLine> items;
  final double subtotal;
  final double discount;
  final double tax;
  final double total;
  final double paid;
  final double due;
  final String paymentMethod;

  const ReceiptData({
    required this.shopName,
    required this.ownerName,
    required this.invoiceNumber,
    required this.createdAt,
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.total,
    required this.paid,
    required this.due,
    required this.paymentMethod,
  });
}

class ReceiptService {
  static String _money(num value) => 'Rs. ${value.toStringAsFixed(2)}';

  static Future<Uint8List> buildPdf(ReceiptData receipt) async {
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        build: (context) => [
          pw.Center(
            child: pw.Column(
              children: [
                pw.Text(
                  receipt.shopName,
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                if (receipt.ownerName.trim().isNotEmpty) ...[
                  pw.SizedBox(height: 4),
                  pw.Text(receipt.ownerName),
                ],
                pw.SizedBox(height: 10),
                pw.Text(
                  'TAX INVOICE / SALES RECEIPT',
                  style: pw.TextStyle(
                    fontSize: 13,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 18),
          pw.Divider(),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(child: pw.Text('Invoice: ${receipt.invoiceNumber}')),
              pw.SizedBox(width: 12),
              pw.Text(
                'Date: ${receipt.createdAt.toLocal().toString().substring(0, 16)}',
              ),
            ],
          ),
          pw.SizedBox(height: 14),
          pw.TableHelper.fromTextArray(
            headers: const ['Item', 'Qty', 'Rate', 'Amount'],
            data: receipt.items
                .map(
                  (item) => [
                    item.name,
                    '${item.quantity}',
                    _money(item.unitPrice),
                    _money(item.lineTotal),
                  ],
                )
                .toList(),
            headerStyle: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.blueGrey800,
            ),
            cellPadding: const pw.EdgeInsets.all(7),
            border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.5),
            columnWidths: {
              0: const pw.FlexColumnWidth(4),
              1: const pw.FlexColumnWidth(1),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(2),
            },
          ),
          pw.SizedBox(height: 18),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.SizedBox(
              width: 230,
              child: pw.Column(
                children: [
                  _pdfTotalRow('Subtotal', _money(receipt.subtotal)),
                  _pdfTotalRow('Discount', '- ${_money(receipt.discount)}'),
                  _pdfTotalRow('Tax', _money(receipt.tax)),
                  pw.Divider(),
                  _pdfTotalRow('TOTAL', _money(receipt.total), bold: true),
                  _pdfTotalRow('Paid', _money(receipt.paid)),
                  _pdfTotalRow('Due', _money(receipt.due)),
                ],
              ),
            ),
          ),
          pw.SizedBox(height: 22),
          pw.Center(
            child: pw.Text('Payment method: ${receipt.paymentMethod}'),
          ),
          pw.SizedBox(height: 10),
          pw.Center(child: pw.Text('Thank you for shopping with us!')),
        ],
      ),
    );

    return doc.save();
  }

  static pw.Widget _pdfTotalRow(
    String label,
    String value, {
    bool bold = false,
  }) {
    final style = pw.TextStyle(
      fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
    );

    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: style),
          pw.Text(value, style: style),
        ],
      ),
    );
  }

  /// Saves an app-private copy and opens the share sheet for export to
  /// Downloads, Drive, email, or other apps.
  static Future<String> saveAndSharePdf(ReceiptData receipt) async {
  final bytes = await buildPdf(receipt);

  final safeInvoice = receipt.invoiceNumber.replaceAll(
    RegExp(r'[^A-Za-z0-9_-]'),
    '_',
  );

  // Chrome/Web: use the browser's print dialog.
  // The user can select TVS RP3230 or Save as PDF.
  if (kIsWeb) {
    await Printing.layoutPdf(
      name: '$safeInvoice.pdf',
      onLayout: (_) async => bytes,
    );
    return 'Browser print dialog opened';
  }

  // Native Windows/Android: save a private copy and share it.
  final directory = await getApplicationDocumentsDirectory();
  final invoiceDirectory = Directory(
    '${directory.path}${Platform.pathSeparator}GO_Dukaan_Invoices',
  );

  if (!await invoiceDirectory.exists()) {
    await invoiceDirectory.create(recursive: true);
  }

  final file = File(
    '${invoiceDirectory.path}${Platform.pathSeparator}$safeInvoice.pdf',
  );

  await file.writeAsBytes(bytes, flush: true);

  await Printing.sharePdf(
    bytes: bytes,
    filename: '$safeInvoice.pdf',
  );

  return file.path;
}

  static Future<List<int>> buildThermalBytes(
    ReceiptData receipt, {
    escpos.PaperSize paperSize = escpos.PaperSize.mm80,
  }) async {
    final profile = await escpos.CapabilityProfile.load();
    final generator = escpos.Generator(paperSize, profile);
    final bytes = <int>[];

    bytes.addAll(
      generator.text(
        receipt.shopName,
        styles: const escpos.PosStyles(
          align: escpos.PosAlign.center,
          bold: true,
          height: escpos.PosTextSize.size2,
          width: escpos.PosTextSize.size2,
        ),
      ),
    );

    if (receipt.ownerName.trim().isNotEmpty) {
      bytes.addAll(
        generator.text(
          receipt.ownerName,
          styles: const escpos.PosStyles(align: escpos.PosAlign.center),
        ),
      );
    }

    bytes.addAll(generator.hr());
    bytes.addAll(generator.text('Invoice: ${receipt.invoiceNumber}'));
    bytes.addAll(
      generator.text(
        'Date: ${receipt.createdAt.toLocal().toString().substring(0, 16)}',
      ),
    );
    bytes.addAll(generator.hr());

    for (final item in receipt.items) {
      bytes.addAll(
        generator.text(
          item.name,
          styles: const escpos.PosStyles(bold: true),
        ),
      );
      bytes.addAll(
        generator.row([
          escpos.PosColumn(
            text: '${item.quantity} x ${_money(item.unitPrice)}',
            width: 7,
          ),
          escpos.PosColumn(
            text: _money(item.lineTotal),
            width: 5,
            styles: const escpos.PosStyles(align: escpos.PosAlign.right),
          ),
        ]),
      );
    }

    bytes.addAll(generator.hr());
    bytes.addAll(
      generator.row([
        escpos.PosColumn(text: 'Subtotal', width: 6),
        escpos.PosColumn(
          text: _money(receipt.subtotal),
          width: 6,
          styles: const escpos.PosStyles(align: escpos.PosAlign.right),
        ),
      ]),
    );
    bytes.addAll(
      generator.row([
        escpos.PosColumn(text: 'Discount', width: 6),
        escpos.PosColumn(
          text: _money(receipt.discount),
          width: 6,
          styles: const escpos.PosStyles(align: escpos.PosAlign.right),
        ),
      ]),
    );
    bytes.addAll(
      generator.row([
        escpos.PosColumn(text: 'Tax', width: 6),
        escpos.PosColumn(
          text: _money(receipt.tax),
          width: 6,
          styles: const escpos.PosStyles(align: escpos.PosAlign.right),
        ),
      ]),
    );
    bytes.addAll(generator.hr());
    bytes.addAll(
      generator.row([
        escpos.PosColumn(
          text: 'TOTAL',
          width: 5,
          styles: const escpos.PosStyles(
            bold: true,
            height: escpos.PosTextSize.size2,
          ),
        ),
        escpos.PosColumn(
          text: _money(receipt.total),
          width: 7,
          styles: const escpos.PosStyles(
            align: escpos.PosAlign.right,
            bold: true,
            height: escpos.PosTextSize.size2,
          ),
        ),
      ]),
    );
    bytes.addAll(generator.text('Paid: ${_money(receipt.paid)}'));
    bytes.addAll(generator.text('Due: ${_money(receipt.due)}'));
    bytes.addAll(generator.text('Payment: ${receipt.paymentMethod}'));
    bytes.addAll(generator.feed(2));
    bytes.addAll(
      generator.text(
        'Thank you!',
        styles: const escpos.PosStyles(
          align: escpos.PosAlign.center,
          bold: true,
        ),
      ),
    );
    bytes.addAll(generator.feed(3));
    bytes.addAll(generator.cut());
    return bytes;
  }
}

class ThermalPrinterScreen extends StatefulWidget {
  final ReceiptData receipt;

  const ThermalPrinterScreen({super.key, required this.receipt});

  @override
  State<ThermalPrinterScreen> createState() => _ThermalPrinterScreenState();
}

class _ThermalPrinterScreenState extends State<ThermalPrinterScreen> {
  final thermal.FlutterThermalPrinter _plugin =
      thermal.FlutterThermalPrinter.instance;
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portController =
      TextEditingController(text: '9100');

  StreamSubscription<List<thermal_utils.Printer>>? _subscription;
  List<thermal_utils.Printer> _printers = [];
  bool _scanning = false;
  bool _busy = false;
  String? _message;

  @override
  void initState() {
    super.initState();
    scanPrinters();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _ipController.dispose();
    _portController.dispose();
    _plugin.stopScan();
    super.dispose();
  }

  Future<void> scanPrinters() async {
    if (!mounted) return;
    setState(() {
      _scanning = true;
      _message = null;
    });

    await _subscription?.cancel();
    _subscription = _plugin.devicesStream.listen(
      (devices) {
        if (!mounted) return;
        setState(() {
          _printers = devices;
        });
      },
      onError: (Object error) {
        if (!mounted) return;
        setState(() => _message = 'Printer scan failed: $error');
      },
    );

    try {
      await _plugin.getPrinters(
        connectionTypes: const [
          thermal_utils.ConnectionType.USB,
          thermal_utils.ConnectionType.BLE,
        ],
      );
    } catch (error) {
      if (mounted) setState(() => _message = 'Printer scan failed: $error');
    } finally {
      if (mounted) setState(() => _scanning = false);
    }
  }

  Future<void> _printToDevice(thermal_utils.Printer printer) async {
    if (!mounted) return;
    setState(() {
      _busy = true;
      _message = 'Connecting to ${printer.name ?? "printer"}...';
    });

    try {
      if (!(printer.isConnected ?? false)) {
        await _plugin.connect(printer);
      }

      final bytes = await ReceiptService.buildThermalBytes(widget.receipt);
      await _plugin.printData(printer, bytes, longData: true);

      if (mounted) {
        setState(() => _message = 'Print command sent. Check the printer.');
      }
    } catch (error) {
      if (mounted) setState(() => _message = 'Print failed: $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _toggleConnection(thermal_utils.Printer printer) async {
    if (!mounted) return;
    setState(() {
      _busy = true;
      _message = 'Updating printer connection...';
    });

    try {
      if (printer.isConnected ?? false) {
        await _plugin.disconnect(printer);
      } else {
        await _plugin.connect(printer);
      }
      if (mounted) {
        setState(
          () => _message = 'Connection request completed for ${printer.name ?? "printer"}.',
        );
      }
      await scanPrinters();
    } catch (error) {
      if (mounted) setState(() => _message = 'Connection failed: $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _printNetwork() async {
    final ip = _ipController.text.trim();
    final port = int.tryParse(_portController.text.trim());

    if (ip.isEmpty || port == null || port < 1 || port > 65535) {
      setState(() => _message = 'Enter a valid printer IP and port (usually 9100).');
      return;
    }

    setState(() {
      _busy = true;
      _message = 'Connecting to network printer...';
    });

    final service = thermal.FlutterThermalPrinterNetwork(ip, port: port);
    try {
      await service.connect();
      final bytes = await ReceiptService.buildThermalBytes(widget.receipt);
      await service.printTicket(bytes);
      await service.disconnect();

      if (mounted) setState(() => _message = 'Network print command sent.');
    } catch (error) {
      try {
        await service.disconnect();
      } catch (_) {
        // Ignore disconnect errors after a failed print.
      }
      if (mounted) setState(() => _message = 'Network print failed: $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF19B5FE);

    return Scaffold(
      backgroundColor: const Color(0xFF07111F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF07111F),
        title: const Text('Connect Thermal Printer'),
        actions: [
          IconButton(
            onPressed: _busy || _scanning ? null : scanPrinters,
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Scan again',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              'USB/OTG and Bluetooth: pair/connect the printer first, then scan. '
              'USB requires OTG support on the phone. Standard ESC/POS printers work best.',
              style: TextStyle(height: 1.5),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'USB / Bluetooth / BLE printers',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
              ),
              if (_scanning)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (_printers.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Text(
                _scanning
                    ? 'Searching for printers...'
                    : 'No printer detected yet. Tap refresh after pairing/connecting.',
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          for (final printer in _printers)
            Card(
              color: const Color(0xFF101D30),
              child: ListTile(
                leading: const Icon(Icons.print_rounded, color: blue),
                title: Text(printer.name ?? 'Unknown printer'),
                subtitle: Text(
                  '${printer.connectionTypeString} • ${printer.address ?? "No address"}\n'
                  'Connected: ${printer.isConnected ?? false}',
                ),
                isThreeLine: true,
                trailing: IconButton(
                  onPressed: _busy ? null : () => _printToDevice(printer),
                  icon: const Icon(Icons.print_rounded),
                  tooltip: 'Print invoice',
                ),
                onTap: _busy ? null : () => _toggleConnection(printer),
              ),
            ),
          const Divider(height: 32),
          const Text(
            'Wi-Fi / LAN printer',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _ipController,
            keyboardType: TextInputType.url,
            decoration: const InputDecoration(
              labelText: 'Printer IP address',
              hintText: 'e.g. 192.168.1.100',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _portController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Port',
              helperText: 'Many ESC/POS network printers use port 9100',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _busy ? null : _printNetwork,
            icon: const Icon(Icons.wifi_rounded),
            label: const Text('Print over Wi-Fi / LAN'),
          ),
          if (_busy) ...[
            const SizedBox(height: 16),
            const LinearProgressIndicator(),
          ],
          if (_message != null) ...[
            const SizedBox(height: 16),
            SelectableText(_message!, style: const TextStyle(color: blue)),
          ],
          const SizedBox(height: 12),
          Text(
            'Compatibility note: the printer must accept ESC/POS commands for direct thermal output. '
            'Some Bluetooth printers use proprietary protocols; Windows USB devices may require a manufacturer driver.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.55),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
