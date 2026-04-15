import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/game_manager.dart';
import '../widgets/animated_tile.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameManager _gameManager;

  @override
  void initState() {
    super.initState();
    _gameManager = GameManager()..initGame();
    _gameManager.addListener(() {
      setState(() {});
    });
  }
  
  @override
  void dispose() {
    _gameManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Allow AnimatedBackground to show
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildGameBoard(),
              const SizedBox(height: 32),
              Text(
                'Join the numbers and get to the 2048 tile!',
                style: TextStyle(
                  color: Colors.white.withAlpha(200),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(CupertinoIcons.back, color: Colors.white, size: 28),
            ),
            const Text(
              '2048',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                _buildScoreBox('SCORE', _gameManager.score),
                const SizedBox(width: 8),
                _buildScoreBox('BEST', _gameManager.bestScore),
              ],
            ),
            const SizedBox(height: 12),
            CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.white.withAlpha(80),
              borderRadius: BorderRadius.circular(12),
              onPressed: () {
                _gameManager.initGame();
              },
              child: const Text('Restart', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            )
          ],
        )
      ],
    );
  }

  Widget _buildScoreBox(String label, int score) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withAlpha(80), width: 1),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: Colors.white.withAlpha(200), fontSize: 10, fontWeight: FontWeight.bold)),
          Text('$score', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildGameBoard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = 8.0;
        final boardSize = constraints.maxWidth;
        final tileSize = (boardSize - padding * (_gameManager.size + 1)) / _gameManager.size;

        return GestureDetector(
          onPanUpdate: (details) {
            if (_gameManager.isGameOver || _gameManager.isGameWon) return;
            
            // Adding a small threshold so accidental touches don't trigger.
            const threshold = 10.0; 
            
            if (details.delta.dx.abs() > details.delta.dy.abs()) {
               if (details.delta.dx > threshold) {
                 _gameManager.swipe(SwipeDirection.right);
               } else if (details.delta.dx < -threshold) {
                 _gameManager.swipe(SwipeDirection.left);
               }
            } else {
               if (details.delta.dy > threshold) {
                 _gameManager.swipe(SwipeDirection.down);
               } else if (details.delta.dy < -threshold) {
                 _gameManager.swipe(SwipeDirection.up);
               }
            }
          },
          child: Container(
            width: boardSize,
            height: boardSize,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50), // Frosted glass game board
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withAlpha(30), width: 1),
            ),
            child: Stack(
              children: [
                ..._buildBackgroundTiles(tileSize, padding),
                ..._gameManager.tiles.map((t) => AnimatedTileWidget(
                  key: ValueKey(t.id),
                  tile: t,
                  size: tileSize,
                  padding: padding,
                )),
                if (_gameManager.isGameOver || _gameManager.isGameWon) _buildOverlay(boardSize),
              ],
            ),
          ),
        );
      }
    );
  }

  List<Widget> _buildBackgroundTiles(double size, double padding) {
    List<Widget> bgTiles = [];
    for (int r = 0; r < _gameManager.size; r++) {
      for (int c = 0; c < _gameManager.size; c++) {
        final left = c * (size + padding) + padding;
        final top = r * (size + padding) + padding;
        bgTiles.add(
          Positioned(
            left: left,
            top: top,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(50), // Frosted glass empty tile
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );
      }
    }
    return bgTiles;
  }

  Widget _buildOverlay(double boardSize) {
    return Container(
      width: boardSize,
      height: boardSize,
      decoration: BoxDecoration(
        color: const Color(0xFFFAF8EF).withAlpha(178),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _gameManager.isGameWon ? 'You Win!' : 'Game Over!',
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Color(0xFF776E65)),
          ),
          const SizedBox(height: 16),
          CupertinoButton.filled(
            onPressed: () {
              _gameManager.initGame();
            },
            child: const Text('Try Again', style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
