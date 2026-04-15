import 'dart:math';
import 'package:flutter/foundation.dart';
import 'tile.dart';

enum SwipeDirection { up, down, left, right }

class GameManager extends ChangeNotifier {
  final int size = 4;
  List<Tile> tiles = [];
  int score = 0;
  int bestScore = 0; // In a real app, load/save from SharedPreferences
  bool isGameOver = false;
  bool isGameWon = false;

  void initGame() {
    tiles.clear();
    score = 0;
    isGameOver = false;
    isGameWon = false;
    _spawnTile();
    _spawnTile();
    notifyListeners();
  }

  void _spawnTile() {
    if (tiles.length >= size * size) return;
    
    final random = Random();
    int row, col;
    do {
      row = random.nextInt(size);
      col = random.nextInt(size);
    } while (tiles.any((t) => t.row == row && t.column == col));

    // 10% chance of 4, 90% chance of 2
    final value = random.nextDouble() < 0.9 ? 2 : 4;
    tiles.add(Tile(value, row, col));
  }

  void swipe(SwipeDirection direction) {
    if (isGameOver) return;

    bool moved = false;
    int pointsGained = 0;

    // Reset merged and new states
    for (int i = 0; i < tiles.length; i++) {
        tiles[i] = tiles[i].copyWith(
            isMerged: false,
            isNew: false,
            prevRow: tiles[i].row,
            prevCol: tiles[i].column,
        );
    }

    // Temporary list to hold new tile states
    List<Tile> newTiles = [];
    
    // Sort and process lines based on direction
    for (int i = 0; i < size; i++) {
        List<Tile> line;
        
        // Extract line
        if (direction == SwipeDirection.left || direction == SwipeDirection.right) {
            line = tiles.where((t) => t.row == i).toList();
            if (direction == SwipeDirection.left) {
                line.sort((a, b) => a.column.compareTo(b.column));
            } else {
                line.sort((a, b) => b.column.compareTo(a.column));
            }
        } else {
            line = tiles.where((t) => t.column == i).toList();
            if (direction == SwipeDirection.up) {
                line.sort((a, b) => a.row.compareTo(b.row));
            } else {
                line.sort((a, b) => b.row.compareTo(a.row));
            }
        }

        // Process line merging and sliding
        List<Tile> processedLine = [];
        for (int j = 0; j < line.length; j++) {
            Tile currentTile = line[j];
            
            if (processedLine.isEmpty) {
                processedLine.add(currentTile);
            } else {
                Tile previousTile = processedLine.last;
                if (previousTile.value == currentTile.value && !previousTile.isMerged) {
                    // Merge
                    processedLine.removeLast();
                    processedLine.add(Tile(
                        currentTile.value * 2,
                        0, 0, // Pos assigned later
                        id: currentTile.id, // Keep current id to animate merge target
                        isMerged: true,
                        isNew: false,
                        prevRow: currentTile.row,
                        prevCol: currentTile.column,
                    ));
                    pointsGained += currentTile.value * 2;
                    moved = true;
                } else {
                    processedLine.add(currentTile);
                }
            }
        }

        // Reassign coordinates to the processed line
        for (int j = 0; j < processedLine.length; j++) {
            Tile t = processedLine[j];
            int newRow = t.row;
            int newCol = t.column;

            if (direction == SwipeDirection.left) {
                newRow = i; newCol = j;
            } else if (direction == SwipeDirection.right) {
                newRow = i; newCol = size - 1 - j;
            } else if (direction == SwipeDirection.up) {
                newRow = j; newCol = i;
            } else if (direction == SwipeDirection.down) {
                newRow = size - 1 - j; newCol = i;
            }

            if (t.row != newRow || t.column != newCol) {
                moved = true;
                processedLine[j] = t.copyWith(row: newRow, column: newCol, prevRow: t.row, prevCol: t.column);
            } else {
                 processedLine[j] = t;
            }
        }
        
        newTiles.addAll(processedLine);
    }

    if (moved) {
        tiles = newTiles;
        score += pointsGained;
        if (score > bestScore) bestScore = score;
        
        _spawnTile();
        
        if (_checkWin()) {
            isGameWon = true;
        } else if (_checkGameOver()) {
            isGameOver = true;
        }
        
        notifyListeners();
    }
  }

  bool _checkWin() {
    return tiles.any((t) => t.value >= 2048);
  }

  bool _checkGameOver() {
    if (tiles.length < size * size) return false;
    
    // Check for possible merges
    for (int r = 0; r < size; r++) {
      for (int c = 0; c < size; c++) {
        Tile current = tiles.firstWhere((t) => t.row == r && t.column == c);
        
        // Check right
        if (c < size - 1) {
            Tile right = tiles.firstWhere((t) => t.row == r && t.column == c + 1);
            if (current.value == right.value) return false;
        }
        // Check down
        if (r < size - 1) {
            Tile down = tiles.firstWhere((t) => t.row == r + 1 && t.column == c);
            if (current.value == down.value) return false;
        }
      }
    }
    return true; // Board full and no merges possible
  }
}
