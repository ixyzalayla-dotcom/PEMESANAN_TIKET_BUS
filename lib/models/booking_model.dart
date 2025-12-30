class BookingModel {
  final String id;
  final String passengerName;
  final String busName;
  final String from;
  final String to;
  final String busType;
  final DateTime bookingDate;
  final DateTime departureDate;
  final String departureTime;
  final String arrivalTime;
  final int seats;
  final double totalPrice;
  final String status; // "Confirmed", "Pending", "Cancelled"
  final String paymentMethod;
  final List<String> selectedSeats; // New field for selected seats

  BookingModel({
    required this.id,
    required this.passengerName,
    required this.busName,
    required this.from,
    required this.to,
    required this.busType,
    required this.bookingDate,
    required this.departureDate,
    required this.departureTime,
    required this.arrivalTime,
    required this.seats,
    required this.totalPrice,
    this.status = "Confirmed",
    required this.paymentMethod,
    this.selectedSeats = const [],
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'passengerName': passengerName,
    'busName': busName,
    'from': from,
    'to': to,
    'busType': busType,
    'bookingDate': bookingDate.toIso8601String(),
    'departureDate': departureDate.toIso8601String(),
    'departureTime': departureTime,
    'arrivalTime': arrivalTime,
    'seats': seats,
    'totalPrice': totalPrice,
    'status': status,
    'paymentMethod': paymentMethod,
    'selectedSeats': selectedSeats,
  };
}
