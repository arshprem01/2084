import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'game_screen.dart';
import 'settings_screen.dart';
import 'credits_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Show AnimatedBackground
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo with Glassmorphism
                ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: Colors.white.withAlpha(100), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(20),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          '2048',
                          style: TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),

                // Menu Buttons Container (Glass effect)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withAlpha(50), width: 1),
                  ),
                  child: Column(
                    children: [
                      _buildMenuButton(context, 'PLAY', () {
                         Navigator.of(context).push(CupertinoPageRoute(builder: (_) => const GameScreen()));
                      }),
                      const SizedBox(height: 16),
                      _buildMenuButton(context, 'SETTINGS', () {
                         Navigator.of(context).push(CupertinoPageRoute(builder: (_) => const SettingsScreen()));
                      }),
                      const SizedBox(height: 16),
                      _buildMenuButton(context, 'CREDITS', () {
                         Navigator.of(context).push(CupertinoPageRoute(builder: (_) => const CreditsScreen()));
                      }),
                    ],
                  ),
                ),
                
                const SizedBox(height: 48),
                Text(
                  'Swipe to move tiles.\nTiles with the same number merge into one.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withAlpha(200),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        color: Colors.white.withAlpha(80),
        borderRadius: BorderRadius.circular(16),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
