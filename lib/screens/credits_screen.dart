import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/settings_manager.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = SettingsManager();
    final textColor = settings.getTextColor();

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
                  child: Icon(CupertinoIcons.back, color: textColor, size: 28),
                ),
                Text(
                  'Credits',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50), // Frosted glass look
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                        Text(
                          '2048 Game',
                          style: TextStyle(
                             fontSize: 28,
                             fontWeight: FontWeight.bold,
                             color: textColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Original concept by\nGabriele Cirulli',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                             fontSize: 16,
                             color: textColor.withAlpha(200),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Created with Flutter',
                          style: TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.w600,
                             color: textColor,
                          ),
                        ),
                     ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
