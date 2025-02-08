  import 'package:feast_fit/screens/login_screen.dart';
  import 'package:feast_fit/theme/theme_provider.dart';
  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';



  void main() {
    runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const MyApp(),
      ),
    );
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      final themeProvider = Provider.of<ThemeProvider>(context);

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: themeProvider.themeMode,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: const LoginScreen(),
      );
    }
  }