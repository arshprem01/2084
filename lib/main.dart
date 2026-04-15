import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'widgets/animated_background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048 Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF Pro Display', // Default fallback usually looks ok, or uses system fonts
      ),
      builder: (context, child) {
         return AnimatedBackgroundWidget(
            child: child ?? const SizedBox.shrink(),
         );
      },
      home: const SplashScreen(),
    );
  }
}
