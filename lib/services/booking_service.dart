import '../models/booking_model.dart';

class BookingService {
  static final BookingService _instance = BookingService._internal();
  late List<BookingModel> _bookings;

  factory BookingService() {
    return _instance;
  }

  BookingService._internal() {
    _bookings = [];
    _initializeDummyData();
  }

  void _initializeDummyData() {
    _bookings = [
      BookingModel(
        id: 'BK001',
        passengerName: 'Budi Santoso',
        busName: 'Singa Express',
        from: 'Malang',
        to: 'Surabaya',
        busType: 'AC',
        bookingDate: DateTime.now().subtract(const Duration(days: 5)),
        departureDate: DateTime.now().subtract(const Duration(days: 3)),
        departureTime: '08:00',
        arrivalTime: '10:30',
        seats: 1,
        totalPrice: 150000,
        status: 'Confirmed',
        paymentMethod: 'Credit Card',
      ),
      BookingModel(
        id: 'BK002',
        passengerName: 'Siti Nurhaliza',
        busName: 'Mitra Jaya',
        from: 'Malang',
        to: 'Sidoarjo',
        busType: 'AC',
        bookingDate: DateTime.now().subtract(const Duration(days: 3)),
        departureDate: DateTime.now().subtract(const Duration(days: 1)),
        departureTime: '10:00',
        arrivalTime: '11:30',
        seats: 2,
        totalPrice: 160000,
        status: 'Confirmed',
        paymentMethod: 'Transfer Bank',
      ),
      BookingModel(
        id: 'BK003',
        passengerName: 'Ahmad Wijaya',
        busName: 'Premium Express',
        from: 'Malang',
        to: 'Surabaya',
        busType: 'Premium',
        bookingDate: DateTime.now().subtract(const Duration(days: 2)),
        departureDate: DateTime.now(),
        departureTime: '11:00',
        arrivalTime: '13:15',
        seats: 1,
        totalPrice: 200000,
        status: 'Confirmed',
        paymentMethod: 'E-Wallet',
      ),
      BookingModel(
        id: 'BK004',
        passengerName: 'Rina Wijayanti',
        busName: 'Sriwijaya',
        from: 'Malang',
        to: 'Surabaya',
        busType: 'AC',
        bookingDate: DateTime.now().subtract(const Duration(days: 1)),
        departureDate: DateTime.now().add(const Duration(days: 2)),
        departureTime: '15:00',
        arrivalTime: '17:30',
        seats: 3,
        totalPrice: 390000,
        status: 'Confirmed',
        paymentMethod: 'Credit Card',
      ),
    ];
  }

  void addBooking(BookingModel booking) {
    _bookings.add(booking);
  }

  List<BookingModel> getAllBookings() {
    return _bookings;
  }

  List<BookingModel> getBookingsByRoute(String from, String to) {
    return _bookings
        .where((b) => b.from == from && b.to == to)
        .toList();
  }

  List<BookingModel> getBookingsByPassenger(String passengerName) {
    return _bookings
        .where((b) => b.passengerName.toLowerCase().contains(passengerName.toLowerCase()))
        .toList();
  }

  List<BookingModel> getBookingsByBus(String busName) {
    return _bookings
        .where((b) => b.busName == busName)
        .toList();
  }

  int getTotalBookings() => _bookings.length;

  double getTotalRevenue() {
    return _bookings.fold(0, (sum, booking) => sum + booking.totalPrice);
  }

  int getTotalPassengers() {
    return _bookings.fold(0, (sum, booking) => sum + booking.seats);
  }

  String generateBookingId() {
    final random = DateTime.now().millisecondsSinceEpoch;
    return 'BK${random.toString().substring(random.toString().length - 6)}';
  }

  void deleteBooking(String bookingId) {
    _bookings.removeWhere((b) => b.id == bookingId);
  }

  void deleteAllBookings() {
    _bookings.clear();
  }

  BookingModel? getBookingById(String bookingId) {
    try {
      return _bookings.firstWhere((b) => b.id == bookingId);
    } catch (e) {
      return null;
    }
  }
}
