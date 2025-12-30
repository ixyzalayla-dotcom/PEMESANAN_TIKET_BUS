import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../shared.dart';
import '../models/booking_model.dart';

class TicketPrintScreen extends StatelessWidget {
  final BookingModel booking;

  const TicketPrintScreen({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tiket Perjalanan'),
        backgroundColor: AppColors.darkBlue,
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () => _printTicket(context),
            icon: const Icon(Icons.print),
            tooltip: 'Cetak Tiket',
          ),
          IconButton(
            onPressed: () => _downloadTicket(context),
            icon: const Icon(Icons.download),
            tooltip: 'Download Tiket',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTicketCard(),
            const SizedBox(height: 24),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.darkBlue, AppColors.lightBlue],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SINGA BUS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Tiket Perjalanan',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'ID: ${booking.id}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Passenger Info
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildTicketRow('Nama Penumpang', booking.passengerName),
                const Divider(height: 20),
                _buildTicketRow('Nama Bus', booking.busName),
                const Divider(height: 20),
                _buildTicketRow('Tipe Bus', booking.busType),
                const Divider(height: 20),
              ],
            ),
          ),

          // Route Info
          Container(
            color: AppColors.lightBlue.withOpacity(0.1),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.from,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBlue,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          booking.departureTime,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDate(booking.departureDate),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(Icons.arrow_forward,
                            color: AppColors.lightBlue),
                        const SizedBox(height: 8),
                        Text(
                          '${_calculateDuration(booking.departureTime, booking.arrivalTime)}h',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          booking.to,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBlue,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          booking.arrivalTime,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Seat & Price
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildTicketRow('Jumlah Penumpang', '${booking.seats} orang'),
                const Divider(height: 20),
                _buildTicketRow(
                  'Metode Pembayaran',
                  booking.paymentMethod,
                ),
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Harga',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Rp ${booking.totalPrice.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.orangeAccent,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 20),
                _buildTicketRow('Status', booking.status,
                    isStatus: true),
              ],
            ),
          ),

          // Footer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Center(
              child: Text(
                'Terima kasih telah menggunakan Singa Bus',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketRow(String label, String value, {bool isStatus = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
        if (isStatus)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.green),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
          )
        else
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.darkBlue,
            ),
          ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: () => _printTicket(context),
            icon: const Icon(Icons.print),
            label: const Text('Cetak Tiket'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: () => _downloadTicket(context),
            icon: const Icon(Icons.download),
            label: const Text('Download Tiket (PDF)'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Kembali'),
          ),
        ),
      ],
    );
  }

  void _printTicket(BuildContext context) async {
    try {
      final pdf = _generatePDF();
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tiket berhasil dicetak!'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: Gagal mencetak tiket - ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _downloadTicket(BuildContext context) async {
    try {
      final pdf = _generatePDF();
      final pdfBytes = await pdf.save();
      
      if (kIsWeb) {
        // For web platform - trigger download using Printing package
        await Printing.sharePdf(
          bytes: pdfBytes,
          filename: 'tiket_${booking.id}.pdf',
        );
        
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tiket berhasil diunduh!'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        // For mobile platform
        final dir = await getApplicationDocumentsDirectory();
        final filePath = '${dir.path}/tiket_${booking.id}.pdf';
        final file = File(filePath);
        
        await file.writeAsBytes(pdfBytes);
        
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tiket berhasil diunduh ke: $filePath'),
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.green,
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {},
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: Gagal mengunduh tiket - ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  pw.Document _generatePDF() {
    final pdf = pw.Document();
    
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              // Header
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(20),
                color: PdfColor.fromHex('#003A7A'),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'SINGA BUS',
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'Tiket Perjalanan',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        color: PdfColors.white,
                      ),
                    ),
                    pw.SizedBox(height: 16),
                    pw.Text(
                      'ID: ${booking.id}',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              
              pw.SizedBox(height: 20),
              
              // Passenger Info
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Column(
                  children: [
                    _buildPdfRow('Nama Penumpang', booking.passengerName),
                    pw.Divider(),
                    _buildPdfRow('Nama Bus', booking.busName),
                    pw.Divider(),
                    _buildPdfRow('Tipe Bus', booking.busType),
                    pw.Divider(),
                  ],
                ),
              ),
              
              pw.SizedBox(height: 20),
              
              // Route Info
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(20),
                color: PdfColor.fromHex('#E3F2FD'),
                child: pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              booking.from,
                              style: pw.TextStyle(
                                fontSize: 18,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromHex('#003A7A'),
                              ),
                            ),
                            pw.SizedBox(height: 4),
                            pw.Text(
                              booking.departureTime,
                              style: const pw.TextStyle(
                                fontSize: 11,
                                color: PdfColors.grey,
                              ),
                            ),
                            pw.SizedBox(height: 4),
                            pw.Text(
                              _formatDate(booking.departureDate),
                              style: const pw.TextStyle(
                                fontSize: 10,
                                color: PdfColors.grey,
                              ),
                            ),
                          ],
                        ),
                        pw.Column(
                          children: [
                            pw.Text('→'),
                            pw.SizedBox(height: 8),
                            pw.Text(
                              '${_calculateDuration(booking.departureTime, booking.arrivalTime)}h',
                              style: const pw.TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                              booking.to,
                              style: pw.TextStyle(
                                fontSize: 18,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromHex('#003A7A'),
                              ),
                            ),
                            pw.SizedBox(height: 4),
                            pw.Text(
                              booking.arrivalTime,
                              style: const pw.TextStyle(
                                fontSize: 11,
                                color: PdfColors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              pw.SizedBox(height: 20),
              
              // Seat & Price
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Column(
                  children: [
                    _buildPdfRow('Jumlah Penumpang', '${booking.seats} orang'),
                    pw.Divider(),
                    _buildPdfRow('Metode Pembayaran', booking.paymentMethod),
                    pw.Divider(),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Total Harga',
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          'Rp ${booking.totalPrice.toStringAsFixed(0)}',
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#FF9800'),
                          ),
                        ),
                      ],
                    ),
                    pw.Divider(),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Status'),
                        pw.Container(
                          padding: const pw.EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                              color: PdfColors.green,
                            ),
                            borderRadius: const pw.BorderRadius.all(
                              pw.Radius.circular(20),
                            ),
                          ),
                          child: pw.Text(
                            booking.status,
                            style: pw.TextStyle(
                              fontSize: 11,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              pw.Spacer(),
              
              // Footer
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(20),
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'Terima kasih telah menggunakan Singa Bus',
                  style: const pw.TextStyle(
                    fontSize: 11,
                    color: PdfColors.grey,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );
    
    return pdf;
  }

  pw.Widget _buildPdfRow(String label, String value) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: const pw.TextStyle(fontSize: 12),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromHex('#003A7A'),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _calculateDuration(String departTime, String arrivalTime) {
    try {
      final depart = _timeToMinutes(departTime);
      final arrival = _timeToMinutes(arrivalTime);
      final duration = (arrival - depart).abs();
      return (duration / 60).ceil().toString();
    } catch (e) {
      return '2';
    }
  }

  int _timeToMinutes(String time) {
    final parts = time.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }
}
