import 'package:flutter/material.dart';
import '../models/tile.dart';

class TileColors {
  static const Color empty = Color(0xFFCDC1B4);
  static const Color bg = Color(0xFFBBADA0);
  static const Color f1 = Color(0xFF776E65);
  static const Color f2 = Color(0xFFF9F6F2);

  static Color getTileColor(int value) {
    switch (value) {
      case 2: return const Color(0xFFEEE4DA);
      case 4: return const Color(0xFFede0c8);
      case 8: return const Color(0xFFf2b179);
      case 16: return const Color(0xFFf59563);
      case 32: return const Color(0xFFf67c5f);
      case 64: return const Color(0xFFf65e3b);
      case 128: return const Color(0xFFedcf72);
      case 256: return const Color(0xFFedcc61);
      case 512: return const Color(0xFFedc850);
      case 1024: return const Color(0xFFedc53f);
      case 2048: return const Color(0xFFedc22e);
      default: return const Color(0xFFCDC1B4);
    }
  }

  static Color getTextColor(int value) {
    return value <= 4 ? f1 : f2;
  }
}

class AnimatedTileWidget extends StatefulWidget {
  final Tile tile;
  final double size;
  final double padding;

  const AnimatedTileWidget({
    super.key,
    required this.tile,
    required this.size,
    required this.padding,
  });

  @override
  State<AnimatedTileWidget> createState() => _AnimatedTileWidgetState();
}

class _AnimatedTileWidgetState extends State<AnimatedTileWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 150)
    );
    
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.tile.isNew || widget.tile.isMerged) {
        if (widget.tile.isNew) {
            _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
        }
        _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedTileWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tile.isMerged && !oldWidget.tile.isMerged) {
         _scaleAnimation = TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
        ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
        _controller.forward(from: 0.0);
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final left = widget.tile.column * (widget.size + widget.padding) + widget.padding;
    final top = widget.tile.row * (widget.size + widget.padding) + widget.padding;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      left: left,
      top: top,
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
              return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                      width: widget.size,
                      height: widget.size,
                      decoration: BoxDecoration(
                          color: TileColors.getTileColor(widget.tile.value),
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withAlpha(20),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                              )
                          ],
                      ),
                      child: Center(
                          child: Text(
                              '${widget.tile.value}',
                              style: TextStyle(
                                  fontSize: widget.size * 0.4,
                                  fontWeight: FontWeight.bold,
                                  color: TileColors.getTextColor(widget.tile.value),
                              ),
                          ),
                      ),
                  ),
              );
          },
      ),
    );
  }
}
