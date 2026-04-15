import 'dart:math';

class Tile {
  final String id;
  final int value;
  final int row;
  final int column;
  final int? prevRow;
  final int? prevCol;
  final bool isMerged;
  final bool isNew;

  Tile(
    this.value,
    this.row,
    this.column, {
    String? id,
    this.prevRow,
    this.prevCol,
    this.isMerged = false,
    this.isNew = true,
  }) : id = id ?? _generateId();

  static String _generateId() {
    return DateTime.now().microsecondsSinceEpoch.toString() + Random().nextInt(10000).toString();
  }

  Tile copyWith({
    int? value,
    int? row,
    int? column,
    int? prevRow,
    int? prevCol,
    bool? isMerged,
    bool? isNew,
  }) {
    return Tile(
      value ?? this.value,
      row ?? this.row,
      column ?? this.column,
      id: id,
      prevRow: prevRow,
      prevCol: prevCol,
      isMerged: isMerged ?? this.isMerged,
      isNew: isNew ?? this.isNew,
    );
  }
}
