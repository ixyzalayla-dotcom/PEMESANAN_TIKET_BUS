import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'shared.dart';

void main() {
  runApp(const SingaBusApp());
}

class SingaBusApp extends StatelessWidget {
  const SingaBusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Singa Bus - Pesan Tiket Bus Online',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.darkBlue,
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}