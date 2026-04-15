import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/settings_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SettingsManager _settings;

  @override
  void initState() {
    super.initState();
    _settings = SettingsManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Let AnimatedBackground show through
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Row(
              children: [
                CupertinoButton(
                  padding: const EdgeInsets.all(16),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Icon(CupertinoIcons.back, color: _settings.getTextColor(), size: 28),
                ),
                Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _settings.getTextColor(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Theme selection
            Text(
              'Background Theme',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _settings.getTextColor(),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: BackgroundTheme.values.map((theme) {
                 return _buildThemeOption(theme);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(BackgroundTheme theme) {
    final isSelected = _settings.currentTheme == theme;
    final name = theme.toString().split('.').last.toUpperCase();

    return GestureDetector(
      onTap: () {
        setState(() {
          _settings.setTheme(theme);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withAlpha(80) : Colors.white.withAlpha(20),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected ? [
             BoxShadow(
                 color: Colors.white.withAlpha(50),
                 blurRadius: 10,
             )
          ] : [],
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _settings.getTextColor(),
            ),
          ),
        ),
      ),
    );
  }
}
