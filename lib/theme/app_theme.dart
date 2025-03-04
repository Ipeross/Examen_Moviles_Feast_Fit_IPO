import 'package:flutter/material.dart';

class AppTheme {
    static const Color cafeOscuro = Color(0xFF3C2A21);
  static const Color cafeMedio = Color(0xFF5C3D2E);
  static const Color cafeClaro = Color(0xFF8B6D5A);
  static const Color cafeCrema = Color(0xFFB99B6B);
  
  static const Color cafeCanela = Color(0xFFD2A76A);
  static const Color cafeVainilla = Color(0xFFE6D2AA);
  static const Color cafeEspuma = Color(0xFFF2ECDC);
  
  static const Color cafeOscuroNight = Color(0xFF251811);
  static const Color cafeMedioNight = Color(0xFF3B2920);
  static const Color cafeClaroNight = Color(0xFF614C3E);
  static const Color cafeCremaNight = Color(0xFF7D6949);
  
  static const Color cafeCanelaNight = Color(0xFF8F7245);
  static const Color cafeVainillaNight = Color(0xFF9F8E6C);
  static const Color cafeEspumaNight = Color(0xFF423631);
  
  static const Color cafeError = Color(0xFFA94438);
  static const Color cafeExito = Color(0xFF5A7D5A);
  static const Color cafeAlerta = Color(0xFFCC9542);
  static const Color cafeInfo = Color(0xFF6B8BA4);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: cafeMedio,
      primaryColorDark: cafeOscuro,
      primaryColorLight: cafeClaro,
      scaffoldBackgroundColor: cafeEspuma,
      
      appBarTheme: const AppBarTheme(
        backgroundColor: cafeOscuro,
        foregroundColor: Color.fromARGB(255, 180, 169, 137),
        elevation: 0,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cafeMedio,
          foregroundColor: cafeEspuma,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: cafeMedio,
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cafeMedio,
          side: const BorderSide(color: cafeMedio),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: cafeCanela,
        foregroundColor: cafeOscuro,
      ),
      
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(color: cafeClaro, width: 0.5),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        fillColor: cafeEspuma,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: cafeMedio, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: cafeClaro),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: cafeError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: cafeError, width: 2.0),
        ),
      ),
      
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: cafeMedio,
        onPrimary: cafeEspuma,
        secondary: cafeCanela,
        onSecondary: cafeOscuro,
        error: cafeError,
        onError: Colors.white,
        surface: Colors.white,
        onSurface: cafeOscuro,
      ),
      
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: cafeOscuro),
        displayMedium: TextStyle(color: cafeOscuro),
        displaySmall: TextStyle(color: cafeOscuro),
        headlineMedium: TextStyle(color: cafeOscuro),
        headlineSmall: TextStyle(color: cafeMedio),
        titleLarge: TextStyle(color: cafeMedio, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: cafeMedio),
        titleSmall: TextStyle(color: cafeClaro),
        bodyLarge: TextStyle(color: cafeOscuro),
        bodyMedium: TextStyle(color: cafeOscuro),
        bodySmall: TextStyle(color: cafeClaro),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: cafeMedioNight,
      primaryColorDark: const Color.fromARGB(255, 63, 44, 34),
      primaryColorLight: cafeClaroNight,
      scaffoldBackgroundColor: const Color.fromARGB(255, 63, 44, 34),
      
      appBarTheme: const AppBarTheme(
        backgroundColor: cafeOscuroNight,
        foregroundColor: cafeVainillaNight,
        elevation: 0,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cafeMedioNight,
          foregroundColor: const Color.fromARGB(255, 175, 164, 141),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: cafeCanelaNight,
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cafeVainillaNight,
          side: const BorderSide(color: cafeClaroNight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: cafeCanelaNight,
        foregroundColor: cafeOscuroNight,
      ),
      
      cardTheme: CardTheme(
        color: cafeEspumaNight,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(color: cafeClaroNight, width: 0.5),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        fillColor: cafeEspumaNight,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: cafeCanelaNight, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: cafeClaroNight),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: cafeError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: cafeError, width: 2.0),
        ),
      ),
      
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: cafeMedioNight,
        onPrimary: cafeVainillaNight,
        secondary: cafeCanelaNight,
        onSecondary: cafeVainillaNight,
        error: cafeError,
        onError: Colors.white,
        surface: cafeEspumaNight,
        onSurface: cafeVainillaNight,
      ),
      
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: cafeVainillaNight),
        displayMedium: TextStyle(color: cafeVainillaNight),
        displaySmall: TextStyle(color: cafeVainillaNight),
        headlineMedium: TextStyle(color: cafeVainillaNight),
        headlineSmall: TextStyle(color: cafeVainillaNight),
        titleLarge: TextStyle(color: cafeVainillaNight, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: cafeVainillaNight),
        titleSmall: TextStyle(color: cafeClaroNight),
        bodyLarge: TextStyle(color: cafeVainillaNight),
        bodyMedium: TextStyle(color: cafeVainillaNight),
        bodySmall: TextStyle(color: cafeClaroNight),
      ),
    );
  }
}


