import 'package:flutter/material.dart';

void main() {
  runApp(const SingaBusApp());
}

class SingaBusApp extends StatelessWidget {
  const SingaBusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Singa Bus UI',
      theme: ThemeData(
        fontFamily: 'Roboto', // Menggunakan font default, bisa diganti Poppins/Inter
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOneWay = true; // State untuk toggle Sekali Jalan/Pulang Pergi

  // Warna sesuai gambar
  final Color darkBlue = const Color(0xFF0D2855);
  final Color orangeAccent = const Color(0xFFF06523);
  final Color lightGreyField = const Color(0xFFF0F2F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // 1. Background Biru
                Container(
                  height: 320,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: darkBlue,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                
                // 2. Konten Utama
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header (Judul & Avatar)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Singa Bus",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // Di gambar hitam, tapi karena bg biru saya buat putih agar terbaca
                                  // Jika ingin persis gambar (bg putih di atas), struktur stack perlu diubah sedikit.
                                  // Namun, desain mobile modern biasanya teks putih di atas bg gelap.
                                  // *Koreksi*: Gambar menunjukkan teks hitam di area putih paling atas (AppBar).
                                  // Mari kita sesuaikan warnanya di bawah agar mirip gambar asli.
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Hai, mau kemana hari ini?",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                          const CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person, color: Color(0xFF0D2855)),
                          )
                        ],
                      ),
                      
                      const SizedBox(height: 25),

                      // Card Pencarian Utama
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Toggle Sekali Jalan / Pulang Pergi
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: lightGreyField,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  _buildTabButton("Sekali Jalan", true),
                                  _buildTabButton("Pulang Pergi", false),
                                ],
                              ),
                            ),
                            
                            const SizedBox(height: 20),

                            // Input Asal & Tujuan dengan Swap Icon
                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel("Pilih Asal"),
                                    _buildTextField("Jakarta", Icons.location_on_outlined),
                                    const SizedBox(height: 15),
                                    _buildLabel("Pilih Tujuan"),
                                    _buildTextField("Bandung", Icons.location_on),
                                  ],
                                ),
                                // Swap Icon
                                Positioned(
                                  right: 20,
                                  top: 65, // Posisi manual agar pas di tengah
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey.shade300),
                                      boxShadow: [
                                         BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 5,
                                        )
                                      ]
                                    ),
                                    child: Icon(Icons.swap_vert, color: darkBlue),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 15),

                            // Tanggal & Penumpang
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildLabel("Tanggal Pergi"),
                                      _buildTextField("25 Okt 2023", null, isCenter: true),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildLabel("1 Penumpang"),
                                      _buildTextField("1 Penumpang", null, isCenter: true),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 25),

                            // Tombol Cari
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: orangeAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  "Cari Tiket Bus",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Bagian Pencarian Terakhir
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pencarian Terakhir",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  // Horizontal List View
                  SizedBox(
                    height: 140, // Tinggi card history
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildHistoryCard("Jakarta - Jogja", "08:00 (Pulo Gebang) - 3j - 11:00"),
                        _buildHistoryCard("Jakarta - Solo", "07:00 (Kp. Rambutan) - 4j - 12:00"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Helper: Tab Button (Sekali Jalan / PP)
  Widget _buildTabButton(String text, bool isSelectedTab) {
    bool active = isOneWay == isSelectedTab;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isOneWay = isSelectedTab;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: active
                ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)]
                : [],
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: active ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  // Widget Helper: Label Kecil di atas Input
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Widget Helper: Text Field Style
  Widget _buildTextField(String text, IconData? icon, {bool isCenter = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: lightGreyField,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          if (icon != null) ...[
             // Icon(icon, size: 20, color: Colors.grey),
             // const SizedBox(width: 10),
             // Note: Di gambar tidak ada icon di dalam field, hanya text
          ],
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Widget Helper: History Card
  Widget _buildHistoryCard(String route, String details) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 15, bottom: 5), // margin bottom untuk shadow
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            route,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            details,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
          ),
          const SizedBox(height: 12),
          // Fasilitas Icons
          Row(
            children: [
              _buildFeatureIcon(Icons.ac_unit),
              _buildFeatureIcon(Icons.power),
              _buildFeatureIcon(Icons.wifi),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(icon, size: 16, color: Colors.black54),
    );
  }
}