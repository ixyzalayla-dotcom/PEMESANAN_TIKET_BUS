import '../models/route_model.dart';
import '../models/seat_model.dart';

class RouteService {
  static final RouteService _instance = RouteService._internal();
  late List<RouteModel> _routes;
  late Map<String, List<SeatModel>> _routeSeats; // Map routeId ke seats

  factory RouteService() {
    return _instance;
  }

  RouteService._internal() {
    _routes = [];
    _routeSeats = {};
    _initializeDummyRoutes();
  }

  void _initializeDummyRoutes() {
    _routes = [
      RouteModel(
        id: 'RT001',
        from: 'Malang',
        to: 'Surabaya',
        departureTime: '08:00',
        arrivalTime: '10:30',
        totalSeats: 32,
        price: 150000,
        busType: 'AC',
      ),
      RouteModel(
        id: 'RT002',
        from: 'Malang',
        to: 'Surabaya',
        departureTime: '14:00',
        arrivalTime: '16:30',
        totalSeats: 32,
        price: 150000,
        busType: 'AC',
      ),
      RouteModel(
        id: 'RT003',
        from: 'Malang',
        to: 'Sidoarjo',
        departureTime: '10:00',
        arrivalTime: '11:30',
        totalSeats: 32,
        price: 80000,
        busType: 'Standard',
      ),
    ];

    // Initialize seats for each route
    for (var route in _routes) {
      _initializeSeats(route.id, route.totalSeats);
    }
  }

  void _initializeSeats(String routeId, int totalSeats) {
    List<SeatModel> seats = [];
    int seatCount = 0;
    
    // Create seats: A1-A8, B1-B8, C1-C8, D1-D8 (32 seats total)
    List<String> rows = ['A', 'B', 'C', 'D'];
    for (String row in rows) {
      for (int i = 1; i <= 8; i++) {
        seats.add(SeatModel(seatNumber: '$row$i'));
      }
    }
    
    _routeSeats[routeId] = seats;
  }

  // Route Management
  void addRoute(RouteModel route) {
    _routes.add(route);
    _initializeSeats(route.id, route.totalSeats);
  }

  void updateRoute(RouteModel route) {
    final index = _routes.indexWhere((r) => r.id == route.id);
    if (index != -1) {
      _routes[index] = route;
    }
  }

  void deleteRoute(String routeId) {
    _routes.removeWhere((r) => r.id == routeId);
    _routeSeats.remove(routeId);
  }

  List<RouteModel> getAllRoutes() {
    return _routes;
  }

  List<RouteModel> getRoutesByLocation(String from, String to) {
    return _routes.where((r) => r.from == from && r.to == to).toList();
  }

  RouteModel? getRouteById(String routeId) {
    try {
      return _routes.firstWhere((r) => r.id == routeId);
    } catch (e) {
      return null;
    }
  }

  String generateRouteId() {
    final random = DateTime.now().millisecondsSinceEpoch;
    return 'RT${random.toString().substring(random.toString().length - 5)}';
  }

  // Seat Management
  List<SeatModel> getSeatsForRoute(String routeId) {
    return _routeSeats[routeId] ?? [];
  }

  void bookSeat(String routeId, String seatNumber, String bookingId) {
    final seats = _routeSeats[routeId];
    if (seats != null) {
      final index = seats.indexWhere((s) => s.seatNumber == seatNumber);
      if (index != -1) {
        seats[index] = seats[index].copyWith(isBooked: true, bookedBy: bookingId);
      }
    }
  }

  void unBookSeat(String routeId, String seatNumber) {
    final seats = _routeSeats[routeId];
    if (seats != null) {
      final index = seats.indexWhere((s) => s.seatNumber == seatNumber);
      if (index != -1) {
        seats[index] = seats[index].copyWith(isBooked: false, bookedBy: null);
      }
    }
  }

  int getAvailableSeats(String routeId) {
    final seats = _routeSeats[routeId];
    if (seats == null) return 0;
    return seats.where((s) => !s.isBooked).length;
  }

  int getBookedSeats(String routeId) {
    final seats = _routeSeats[routeId];
    if (seats == null) return 0;
    return seats.where((s) => s.isBooked).length;
  }
}
