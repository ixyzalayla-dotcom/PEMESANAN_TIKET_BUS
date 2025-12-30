import 'package:flutter/material.dart';
import '../shared.dart';
import 'bus_list_screen.dart';
import 'admin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _from = 'Malang';
  String? _to;
  DateTime? _date;

  final List<String> destinations = [
    'Surabaya',
    'Sidoarjo',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderForm(context),
            _buildQuickBooking(),
            _buildRecommendationSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderForm(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.darkBlue,
            AppColors.lightBlue,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBlue.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
      child: Stack(
        children: [
          // Background bus illustration - large and centered at top
          Positioned(
            top: -50,
            right: -50,
            child: Opacity(
              opacity: 0.12,
              child: Transform.scale(
                scale: 2.5,
                child: _buildBusIllustration(),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Singa Bus", style: AppTextStyles.heading),
                  Text(
                    "Pesan Tiket Bus Online",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
              ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.admin_panel_settings,
                          color: Colors.white, size: 20),
                      tooltip: 'Admin Panel',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Icon(Icons.person, color: Colors.white, size: 24),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 35),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  "Cari Tiket Bus",
                  style: AppTextStyles.subHeading,
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  label: "Dari",
                  icon: Icons.location_on_outlined,
                  value: _from ?? "Malang",
                  readOnly: true,
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                _buildDropdownField(
                  label: "Tujuan",
                  icon: Icons.location_on,
                  value: _to,
                  items: destinations,
                  onChanged: (value) {
                    setState(() => _to = value);
                  },
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  label: "Tanggal",
                  icon: Icons.calendar_today_outlined,
                  value: _date != null
                      ? '${_date!.day}/${_date!.month}/${_date!.year}'
                      : "Pilih Tanggal",
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) {
                      setState(() => _date = picked);
                    }
                  },
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _to != null && _date != null
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BusListScreen(
                                  from: _from ?? 'Malang',
                                  to: _to!,
                                  date: _date!,
                                ),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _to != null && _date != null
                          ? AppColors.orangeAccent
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 4,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Cari Tiket Bus",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
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

  Widget _buildInputField({
    required String label,
    required IconData icon,
    required String value,
    required VoidCallback onTap,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            child: Row(
              children: [
                Icon(icon, color: AppColors.lightBlue, size: 20),
                const SizedBox(width: 12),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButton<String>(
              isExpanded: true,
              underline: const SizedBox(),
              value: value,
              hint: Row(
                children: [
                  Icon(icon, color: AppColors.lightBlue, size: 20),
                  const SizedBox(width: 12),
                  Text(label, style: const TextStyle(color: AppColors.textLight)),
                ],
              ),
              onChanged: onChanged,
              items: items
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickBooking() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Rute Populer", style: AppTextStyles.subHeading),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BusListScreen(
                    from: 'Malang',
                    to: 'Surabaya',
                    date: DateTime.now(),
                  ),
                ),
              );
            },
            child: _buildRouteCard(
              'Malang → Surabaya',
              '~2h 30m',
              Icons.trending_up,
              AppColors.orangeAccent,
              '8 bus tersedia',
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BusListScreen(
                    from: 'Malang',
                    to: 'Sidoarjo',
                    date: DateTime.now(),
                  ),
                ),
              );
            },
            child: _buildRouteCard(
              'Malang → Sidoarjo',
              '~1h 30m',
              Icons.route,
              AppColors.success,
              '4 bus tersedia',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteCard(
    String title,
    String duration,
    IconData icon,
    Color color,
    String buses,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    )),
                const SizedBox(height: 4),
                Text(
                  '$duration • $buses',
                  style: AppTextStyles.bodyText,
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 18),
        ],
      ),
    );
  }

  Widget _buildRecommendationSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Mengapa Pilih Singa Bus?", style: AppTextStyles.subHeading),
          const SizedBox(height: 16),
          _buildBenefitCard(
            Icons.verified,
            'Bus Terpercaya',
            'Semua bus terverifikasi dan terpercaya',
            AppColors.success,
          ),
          const SizedBox(height: 12),
          _buildBenefitCard(
            Icons.payment,
            'Pembayaran Aman',
            'Sistem pembayaran tersertifikasi dan aman',
            AppColors.lightBlue,
          ),
          const SizedBox(height: 12),
          _buildBenefitCard(
            Icons.support_agent,
            'Customer Support 24/7',
            'Dukungan pelanggan siap membantu',
            AppColors.orangeAccent,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildBenefitCard(
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.bodyText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusIllustration() {
    return CustomPaint(
      painter: BusPainter(),
      size: const Size(200, 100),
    );
  }
}

class BusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    final bodyPaint = Paint()
      ..color = Colors.white;

    // Main body
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(20, 30, 160, 50),
        const Radius.circular(8),
      ),
      bodyPaint,
    );

    // Front cabin
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(140, 15, 40, 25),
        const Radius.circular(4),
      ),
      bodyPaint,
    );

    // Windows
    final windowPaint = Paint()
      ..color = Colors.blue[200]!
      ..strokeWidth = 1;

    // Front window
    canvas.drawRect(Rect.fromLTWH(145, 18, 30, 18), windowPaint);

    // Side windows
    for (int i = 0; i < 3; i++) {
      canvas.drawRect(
        Rect.fromLTWH(25 + (i * 40), 35, 30, 20),
        windowPaint,
      );
    }

    // Wheels
    final wheelPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final wheelFillPaint = Paint()
      ..color = Colors.grey[600]!;

    // Left wheel
    canvas.drawCircle(Offset(45, 85), 8, wheelFillPaint);
    canvas.drawCircle(Offset(45, 85), 6, wheelPaint);

    // Right wheel
    canvas.drawCircle(Offset(155, 85), 8, wheelFillPaint);
    canvas.drawCircle(Offset(155, 85), 6, wheelPaint);

    // Door lines
    canvas.drawLine(const Offset(90, 30), const Offset(90, 80), paint);
  }

  @override
  bool shouldRepaint(BusPainter oldDelegate) => false;
}