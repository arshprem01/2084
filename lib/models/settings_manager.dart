import 'package:flutter/material.dart';

enum BackgroundTheme {
  orange,
  ocean,
  neon,
  sunset,
}

class SettingsManager extends ChangeNotifier {
  static final SettingsManager _instance = SettingsManager._internal();
  factory SettingsManager() => _instance;
  SettingsManager._internal();

  BackgroundTheme _currentTheme = BackgroundTheme.orange;

  BackgroundTheme get currentTheme => _currentTheme;

  void setTheme(BackgroundTheme theme) {
    if (_currentTheme != theme) {
      _currentTheme = theme;
      notifyListeners();
    }
  }

  // Get colors based on the selected theme to use in the animated background
  List<Color> getThemeColors() {
    switch (_currentTheme) {
      case BackgroundTheme.orange:
        return [
          const Color(0xFFFAF8EF),
          const Color(0xFFF2ECD3),
          const Color(0xFFE4DFCA),
        ]; // Classic 2048 cream/beige colors
      case BackgroundTheme.ocean:
        return [
          const Color(0xFFE0F7FA), // Light cyan
          const Color(0xFF80DEEA), // Cyan
          const Color(0xFF4DD0E1), // Dark cyan
        ];
      case BackgroundTheme.neon:
        return [
          const Color(0xFF1E1E24), // Dark
          const Color(0xFF2A0845), // Deep purple
          const Color(0xFF6441A5), // Vibrant purple
        ];
      case BackgroundTheme.sunset:
        return [
          const Color(0xFFFFE0B2), // Light peach
          const Color(0xFFFFB74D), // Orange
          const Color(0xFFF06292), // Pink
        ];
    }
  }
  
  // Gets text color based on background darkness
  Color getTextColor() {
     if (_currentTheme == BackgroundTheme.neon) {
         return Colors.white;
     }
     return const Color(0xFF776E65);
  }
}
