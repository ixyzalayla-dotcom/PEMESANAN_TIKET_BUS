import 'package:flutter/material.dart';
import '../shared.dart';
import '../models/route_model.dart';
import '../models/seat_model.dart';
import '../services/route_service.dart';

class SeatSelectionScreen extends StatefulWidget {
  final RouteModel route;

  const SeatSelectionScreen({
    super.key,
    required this.route,
  });

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final RouteService _routeService = RouteService();
  late List<SeatModel> _seats;
  final List<String> _selectedSeats = [];

  @override
  void initState() {
    super.initState();
    _loadSeats();
  }

  void _loadSeats() {
    setState(() {
      _seats = _routeService.getSeatsForRoute(widget.route.id);
    });
  }

  void _toggleSeat(String seatNumber) {
    setState(() {
      if (_selectedSeats.contains(seatNumber)) {
        _selectedSeats.remove(seatNumber);
      } else {
        _selectedSeats.add(seatNumber);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Kursi'),
        backgroundColor: AppColors.darkBlue,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRouteInfo(),
            const SizedBox(height: 24),
            _buildLegend(),
            const SizedBox(height: 24),
            _buildSeatGrid(),
            const SizedBox(height: 24),
            _buildSelectedSeatsInfo(),
            const SizedBox(height: 24),
            _buildBookButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteInfo() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.route.from} → ${widget.route.to}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkBlue,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.orangeAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.orangeAccent),
                  ),
                  child: Text(
                    'Rp ${widget.route.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.orangeAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoItem(Icons.schedule, widget.route.departureTime),
                const Icon(Icons.arrow_forward, color: Colors.grey),
                _buildInfoItem(Icons.schedule, widget.route.arrivalTime),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Tersedia: ${_routeService.getAvailableSeats(widget.route.id)} kursi',
              style: TextStyle(
                fontSize: 12,
                color: Colors.green[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.lightBlue),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.darkBlue,
          ),
        ),
      ],
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildLegendItem('Tersedia', AppColors.lightBlue),
        _buildLegendItem('Terpilih', AppColors.orangeAccent),
        _buildLegendItem('Terboking', Colors.grey),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSeatGrid() {
    return Center(
      child: Column(
        children: [
          // Screen representation
          Container(
            width: 200,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.darkBlue,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: const Center(
              child: Text(
                'Layar',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Seats grid
          Column(
            children: [
              for (int row = 0; row < 4; row++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ['A', 'B', 'C', 'D'][row],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 16),
                      for (int col = 0; col < 8; col++)
                        _buildSeatWidget(
                          _seats[row * 8 + col],
                          () => _toggleSeat(_seats[row * 8 + col].seatNumber),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSeatWidget(SeatModel seat, VoidCallback onTap) {
    bool isSelected = _selectedSeats.contains(seat.seatNumber);
    Color bgColor;

    if (seat.isBooked) {
      bgColor = Colors.grey;
    } else if (isSelected) {
      bgColor = AppColors.orangeAccent;
    } else {
      bgColor = AppColors.lightBlue;
    }

    return GestureDetector(
      onTap: seat.isBooked ? null : onTap,
      child: Container(
        width: 35,
        height: 35,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: bgColor.withOpacity(0.3),
          border: Border.all(
            color: bgColor,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            seat.seatNumber.replaceFirst(RegExp(r'[A-D]'), ''),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: seat.isBooked ? Colors.grey[700] : AppColors.darkBlue,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedSeatsInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightBlue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kursi Terpilih',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          if (_selectedSeats.isEmpty)
            const Text(
              'Belum ada kursi yang dipilih',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            )
          else
            Text(
              _selectedSeats.join(', '),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.orangeAccent,
              ),
            ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Kursi: ${_selectedSeats.length}',
                style: const TextStyle(fontSize: 13),
              ),
              Text(
                'Total: Rp ${(widget.route.price * _selectedSeats.length).toStringAsFixed(0)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: AppColors.orangeAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _selectedSeats.isEmpty
            ? null
            : () {
                Navigator.pop(context, _selectedSeats);
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: _selectedSeats.isEmpty
              ? Colors.grey
              : AppColors.orangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Lanjut ke Pembayaran',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
