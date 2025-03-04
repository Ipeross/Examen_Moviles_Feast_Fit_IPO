import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => 
    _themeMode == ThemeMode.dark || 
    (_themeMode == ThemeMode.system && 
      WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark);

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    notifyListeners();
  }

  void setLightMode() {
    _themeMode = ThemeMode.light;
    notifyListeners();
  }
  
  void setDarkMode() {
    _themeMode = ThemeMode.dark;
    notifyListeners();
  }
  
  void setSystemMode() {
    _themeMode = ThemeMode.system;
    notifyListeners();
  }
}
