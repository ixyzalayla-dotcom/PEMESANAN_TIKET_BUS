import 'package:flutter/material.dart';

class AppColors {
  static const Color darkBlue = Color(0xFF1E3A8A);
  static const Color lightBlue = Color(0xFF3B82F6);
  static const Color orangeAccent = Color(0xFFF97316);
  static const Color lightGrey = Color(0xFFF3F4F6);
  static const Color background = Color(0xFFFAFBFC);
  static const Color success = Color(0xFF10B981);
  static const Color textDark = Color(0xFF1F2937);
  static const Color textLight = Color(0xFF6B7280);
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 0.5,
  );
  
  static const TextStyle subHeading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );
  
  static const TextStyle bodyText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textLight,
  );
}