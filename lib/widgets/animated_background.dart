import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/settings_manager.dart';

class AnimatedBackgroundWidget extends StatefulWidget {
  final Widget child;

  const AnimatedBackgroundWidget({super.key, required this.child});

  @override
  State<AnimatedBackgroundWidget> createState() => _AnimatedBackgroundWidgetState();
}

class _AnimatedBackgroundWidgetState extends State<AnimatedBackgroundWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late SettingsManager _settings;

  @override
  void initState() {
    super.initState();
    _settings = SettingsManager();
    _settings.addListener(_onThemeChanged);

    _controller = AnimationController(
        vsync: this, 
        duration: const Duration(seconds: 15)
    )..repeat();
  }

  @override
  void dispose() {
    _settings.removeListener(_onThemeChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onThemeChanged() {
    setState(() {}); // Rebuild with new colors
  }

  @override
  Widget build(BuildContext context) {
    final colors = _settings.getThemeColors();

    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _blendColors(colors[0], colors[1], _controller.value),
                      _blendColors(colors[1], colors[2], _controller.value),
                      _blendColors(colors[2], colors[0], _controller.value),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                    transform: GradientRotation(_controller.value * 2 * math.pi),
                  ),
                ),
              );
            },
          ),
        ),
        // Overlay a slight noise or blur layer if desired, or just glass
        Positioned.fill(
           child: Container(color: Colors.white.withAlpha(20))
        ),
        // The actual child content (e.g. game board or screens)
        Positioned.fill(
          child: widget.child,
        ),
      ],
    );
  }

  Color _blendColors(Color a, Color b, double t) {
    // A simple sine wave ping-pong blend based on the controller value 0..1
    double pingPong = math.sin(t * math.pi * 2) * 0.5 + 0.5; 
    return Color.lerp(a, b, pingPong) ?? a;
  }
}
