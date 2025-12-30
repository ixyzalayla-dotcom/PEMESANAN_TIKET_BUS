import 'package:flutter/material.dart';
import '../models/bus_model.dart';
import '../shared.dart';
import '../widgets/bus_card.dart';
import 'bus_detail_screen.dart';

class BusListScreen extends StatefulWidget {
  final String from;
  final String to;
  final DateTime date;

  const BusListScreen({
    super.key,
    required this.from,
    required this.to,
    required this.date,
  });

  @override
  State<BusListScreen> createState() => _BusListScreenState();
}

class _BusListScreenState extends State<BusListScreen> {
  late List<BusModel> buses;

  @override
  void initState() {
    super.initState();
    buses = _getBusesForRoute(widget.from, widget.to);
  }

  List<BusModel> _getBusesForRoute(String from, String to) {
    final allBuses = [
      // Malang to Surabaya
      BusModel(
        id: 'BUS001',
        name: 'Singa Express',
        from: 'Malang',
        to: 'Surabaya',
        departureTime: '08:00',
        arrivalTime: '10:30',
        duration: 150,
        price: 75000,
        availableSeats: 12,
        totalSeats: 40,
        rating: 4.8,
        reviews: 234,
        driverName: 'Budi Santoso',
        busType: 'AC',
        facilities: ['AC', 'WiFi', 'USB Charger', 'Recline Seat'],
      ),
      BusModel(
        id: 'BUS002',
        name: 'Mitra Jaya',
        from: 'Malang',
        to: 'Surabaya',
        departureTime: '09:30',
        arrivalTime: '12:00',
        duration: 150,
        price: 65000,
        availableSeats: 5,
        totalSeats: 45,
        rating: 4.6,
        reviews: 189,
        driverName: 'Ahmad Wijaya',
        busType: 'AC',
        facilities: ['AC', 'WiFi', 'Toilet'],
      ),
      BusModel(
        id: 'BUS003',
        name: 'Premium Express',
        from: 'Malang',
        to: 'Surabaya',
        departureTime: '11:00',
        arrivalTime: '13:15',
        duration: 135,
        price: 80000,
        availableSeats: 18,
        totalSeats: 30,
        rating: 4.9,
        reviews: 456,
        driverName: 'Hendra Gunawan',
        busType: 'Premium',
        facilities: ['AC', 'WiFi', 'USB Charger', 'Recline Seat', 'Entertainment'],
      ),
      BusModel(
        id: 'BUS004',
        name: 'Sriwijaya',
        from: 'Malang',
        to: 'Surabaya',
        departureTime: '15:00',
        arrivalTime: '17:30',
        duration: 150,
        price: 75000,
        availableSeats: 25,
        totalSeats: 50,
        rating: 4.5,
        reviews: 156,
        driverName: 'Sumarno',
        busType: 'AC',
        facilities: ['AC', 'WiFi', 'Toilet', 'Snack'],
      ),
      // Malang to Sidoarjo
      BusModel(
        id: 'BUS005',
        name: 'Singa Local',
        from: 'Malang',
        to: 'Sidoarjo',
        departureTime: '07:00',
        arrivalTime: '08:30',
        duration: 90,
        price: 65000,
        availableSeats: 20,
        totalSeats: 45,
        rating: 4.7,
        reviews: 198,
        driverName: 'Dono Prabowo',
        busType: 'AC',
        facilities: ['AC', 'WiFi'],
      ),
      BusModel(
        id: 'BUS006',
        name: 'Citra Putri',
        from: 'Malang',
        to: 'Sidoarjo',
        departureTime: '10:00',
        arrivalTime: '11:30',
        duration: 90,
        price: 55000,
        availableSeats: 8,
        totalSeats: 40,
        rating: 4.4,
        reviews: 112,
        driverName: 'Ridho Pratama',
        busType: 'AC',
        facilities: ['AC'],
      ),
      BusModel(
        id: 'BUS007',
        name: 'Fajar Muda',
        from: 'Malang',
        to: 'Sidoarjo',
        departureTime: '12:30',
        arrivalTime: '14:00',
        duration: 90,
        price: 70000,
        availableSeats: 30,
        totalSeats: 45,
        rating: 4.6,
        reviews: 145,
        driverName: 'Yudi Hartono',
        busType: 'AC',
        facilities: ['AC', 'WiFi', 'USB Charger'],
      ),
      BusModel(
        id: 'BUS008',
        name: 'Rajawali',
        from: 'Malang',
        to: 'Sidoarjo',
        departureTime: '16:00',
        arrivalTime: '17:30',
        duration: 90,
        price: 60000,
        availableSeats: 15,
        totalSeats: 50,
        rating: 4.5,
        reviews: 134,
        driverName: 'Bambang Surya',
        busType: 'AC',
        facilities: ['AC', 'WiFi', 'Toilet'],
      ),
    ];

    return allBuses
        .where((bus) =>
            bus.from.toLowerCase() == from.toLowerCase() &&
            bus.to.toLowerCase() == to.toLowerCase())
        .toList();
  }

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
          'Pilih Bus',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Filter/Info Section
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.from} → ${widget.to}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ditemukan ${buses.length} bus tersedia',
                  style: AppTextStyles.bodyText,
                ),
              ],
            ),
          ),
          // Bus List
          Expanded(
            child: buses.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.directions_bus_outlined,
                          size: 64,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tidak ada bus tersedia',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: buses.length,
                    itemBuilder: (context, index) {
                      final bus = buses[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BusDetailScreen(bus: bus, date: widget.date),
                            ),
                          );
                        },
                        child: BusCard(bus: bus),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
