class SeatModel {
  final String seatNumber; // A1, A2, B1, etc
  final bool isBooked;
  final String? bookedBy; // booking ID yang menggunakan seat ini

  SeatModel({
    required this.seatNumber,
    this.isBooked = false,
    this.bookedBy,
  });

  SeatModel copyWith({
    String? seatNumber,
    bool? isBooked,
    String? bookedBy,
  }) {
    return SeatModel(
      seatNumber: seatNumber ?? this.seatNumber,
      isBooked: isBooked ?? this.isBooked,
      bookedBy: bookedBy ?? this.bookedBy,
    );
  }

  Map<String, dynamic> toJson() => {
    'seatNumber': seatNumber,
    'isBooked': isBooked,
    'bookedBy': bookedBy,
  };

  factory SeatModel.fromJson(Map<String, dynamic> json) {
    return SeatModel(
      seatNumber: json['seatNumber'],
      isBooked: json['isBooked'],
      bookedBy: json['bookedBy'],
    );
  }
}
