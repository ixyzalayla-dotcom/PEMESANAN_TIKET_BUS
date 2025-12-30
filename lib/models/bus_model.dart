class BusModel {
  final String id;
  final String name;
  final String from;
  final String to;
  final String departureTime;
  final String arrivalTime;
  final int duration; // in minutes
  final double price;
  final int availableSeats;
  final int totalSeats;
  final double rating;
  final int reviews;
  final String driverName;
  final String busType; // "AC", "Executive", "Premium"
  final List<String> facilities;
  final String image;

  BusModel({
    required this.id,
    required this.name,
    required this.from,
    required this.to,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.price,
    required this.availableSeats,
    required this.totalSeats,
    required this.rating,
    required this.reviews,
    required this.driverName,
    required this.busType,
    required this.facilities,
    this.image = '🚌',
  });
}