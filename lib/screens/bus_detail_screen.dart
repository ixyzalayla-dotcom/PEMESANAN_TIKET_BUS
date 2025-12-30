import 'package:flutter/material.dart';
import '../models/bus_model.dart';
import '../models/booking_model.dart';
import '../models/route_model.dart';
import '../services/booking_service.dart';
import '../services/route_service.dart';
import '../shared.dart';
import 'seat_selection_screen.dart';
import 'ticket_print_screen.dart';

class BusDetailScreen extends StatefulWidget {
  final BusModel bus;
  final DateTime date;

  const BusDetailScreen({
    super.key,
    required this.bus,
    required this.date,
  });

  @override
  State<BusDetailScreen> createState() => _BusDetailScreenState();
}

class _BusDetailScreenState extends State<BusDetailScreen> {
  int selectedSeats = 1;
  String passengerName = '';
  String paymentMethod = 'Credit Card';
  List<String> selectedSeatNumbers = []; // New: store selected seat numbers
  final TextEditingController _nameController = TextEditingController();
  final BookingService _bookingService = BookingService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detail Bus',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Bus Header
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.lightBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.bus.image,
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.bus.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.bus.busType,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.orangeAccent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.star, size: 16, color: Colors.amber),
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.bus.rating} (${widget.bus.reviews} review)',
                                  style: AppTextStyles.bodyText,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Journey Info
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.bus.departureTime,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.bus.from,
                              style: AppTextStyles.bodyText,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.arrow_forward,
                              color: AppColors.lightBlue,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${widget.bus.duration ~/ 60}h ${widget.bus.duration % 60}m',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.bus.arrivalTime,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.bus.to,
                              style: AppTextStyles.bodyText,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Driver & Facilities
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Informasi Pengemudi',
                    style: AppTextStyles.subHeading,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.lightBlue.withOpacity(0.2),
                        child: const Icon(Icons.person, color: AppColors.lightBlue),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.bus.driverName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppColors.textDark,
                            ),
                          ),
                          Text(
                            'Pengemudi Berpengalaman',
                            style: AppTextStyles.bodyText,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Fasilitas Bus',
                    style: AppTextStyles.subHeading,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.bus.facilities
                        .map(
                          (facility) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.lightBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.lightBlue.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              facility,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.lightBlue,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Seat Info
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.event_seat, color: AppColors.success, size: 28),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.bus.availableSeats}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.success,
                        ),
                      ),
                      const Text(
                        'Kursi Tersedia',
                        style: AppTextStyles.bodyText,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.event_seat, color: Colors.grey, size: 28),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.bus.totalSeats - widget.bus.availableSeats}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        'Terisi',
                        style: AppTextStyles.bodyText,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Passenger Info Section
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Informasi Pemesan',
                    style: AppTextStyles.subHeading,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    onChanged: (value) {
                      setState(() => passengerName = value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Nama Lengkap Pemesan',
                      hintText: 'Contoh: Budi Santoso',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.person, color: AppColors.lightBlue),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Jumlah Kursi',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: selectedSeats > 1
                              ? () => setState(() => selectedSeats--)
                              : null,
                          icon: const Icon(Icons.remove, color: AppColors.lightBlue),
                        ),
                        Text(
                          '$selectedSeats Kursi',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                        IconButton(
                          onPressed: selectedSeats < widget.bus.availableSeats
                              ? () => setState(() => selectedSeats++)
                              : null,
                          icon: const Icon(Icons.add, color: AppColors.lightBlue),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Metode Pembayaran',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: paymentMethod,
                    items: [
                      'Credit Card',
                      'Transfer Bank',
                      'E-Wallet',
                      'Cash at Counter',
                    ]
                        .map((method) => DropdownMenuItem(
                              value: method,
                              child: Text(method),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => paymentMethod = value);
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Harga',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textLight,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp ${(widget.bus.price * selectedSeats).toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkBlue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: passengerName.isNotEmpty && widget.bus.availableSeats > 0
                    ? () => _showBookingDialog(context)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: passengerName.isNotEmpty && widget.bus.availableSeats > 0
                      ? AppColors.orangeAccent
                      : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                child: const Text(
                  'Pesan Sekarang',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookingDialog(BuildContext context) {
    final totalPrice = widget.bus.price * selectedSeats;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Pemesanan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBookingInfo('Nama Pemesan', passengerName),
            _buildBookingInfo('Bus', widget.bus.name),
            _buildBookingInfo(
              'Rute',
              '${widget.bus.from} → ${widget.bus.to}',
            ),
            _buildBookingInfo('Waktu Berangkat', widget.bus.departureTime),
            _buildBookingInfo('Jumlah Kursi', '$selectedSeats Kursi'),
            if (selectedSeatNumbers.isNotEmpty)
              _buildBookingInfo('Kursi Terpilih', selectedSeatNumbers.join(', ')),
            _buildBookingInfo('Metode Pembayaran', paymentMethod),
            _buildBookingInfo(
              'Total Harga',
              'Rp ${totalPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _openSeatSelection(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.lightBlue,
            ),
            child: const Text('Pilih Kursi'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _saveBookingAndShowSuccess(context, totalPrice);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orangeAccent,
            ),
            child: const Text(
              'Pesan',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openSeatSelection(BuildContext context) async {
    final _routeService = RouteService();
    
    // Try to find matching route in RouteService, otherwise create new one
    List<RouteModel> matchingRoutes = _routeService.getRoutesByLocation(
      widget.bus.from,
      widget.bus.to,
    );
    
    RouteModel route;
    if (matchingRoutes.isNotEmpty) {
      // Use first matching route from service
      route = matchingRoutes.first;
    } else {
      // Create a new route and add to service
      route = RouteModel(
        id: _routeService.generateRouteId(),
        from: widget.bus.from,
        to: widget.bus.to,
        departureTime: widget.bus.departureTime,
        arrivalTime: widget.bus.arrivalTime,
        totalSeats: 32,
        price: widget.bus.price,
        busType: widget.bus.busType,
      );
      _routeService.addRoute(route);
    }

    final selected = await Navigator.push<List<String>>(
      context,
      MaterialPageRoute(
        builder: (context) => SeatSelectionScreen(route: route),
      ),
    );

    if (selected != null && selected.isNotEmpty) {
      setState(() {
        selectedSeatNumbers = selected;
        selectedSeats = selected.length;
      });
      // Show dialog again after seat selection
      _showBookingDialog(context);
    }
  }

  void _saveBookingAndShowSuccess(BuildContext context, double totalPrice) {
    final booking = BookingModel(
      id: _bookingService.generateBookingId(),
      passengerName: passengerName,
      busName: widget.bus.name,
      from: widget.bus.from,
      to: widget.bus.to,
      busType: widget.bus.busType,
      bookingDate: DateTime.now(),
      departureDate: widget.date,
      departureTime: widget.bus.departureTime,
      arrivalTime: widget.bus.arrivalTime,
      seats: selectedSeats,
      totalPrice: totalPrice,
      paymentMethod: paymentMethod,
      selectedSeats: selectedSeatNumbers, // Add selected seats
    );

    _bookingService.addBooking(booking);
    _showSuccessDialog(context, booking);
  }

  void _showSuccessDialog(BuildContext context, BookingModel booking) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pemesanan Berhasil!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Nomor Booking: ${booking.id}\nTiket sudah dikirim ke email',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyText,
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to ticket print screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TicketPrintScreen(booking: booking),
                  ),
                ).then((_) {
                  Navigator.pop(context); // Back to home
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
              ),
              child: const Text(
                'Lihat & Cetak Tiket',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textLight,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
