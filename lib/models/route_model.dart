class RouteModel {
  final String id;
  final String from;
  final String to;
  final String departureTime;
  final String arrivalTime;
  final int totalSeats;
  final double price;
  final String busType; // AC, Premium, Standard
  final DateTime createdAt;

  RouteModel({
    required this.id,
    required this.from,
    required this.to,
    required this.departureTime,
    required this.arrivalTime,
    required this.totalSeats,
    required this.price,
    required this.busType,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'from': from,
    'to': to,
    'departureTime': departureTime,
    'arrivalTime': arrivalTime,
    'totalSeats': totalSeats,
    'price': price,
    'busType': busType,
    'createdAt': createdAt.toIso8601String(),
  };

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      id: json['id'],
      from: json['from'],
      to: json['to'],
      departureTime: json['departureTime'],
      arrivalTime: json['arrivalTime'],
      totalSeats: json['totalSeats'],
      price: json['price'],
      busType: json['busType'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
