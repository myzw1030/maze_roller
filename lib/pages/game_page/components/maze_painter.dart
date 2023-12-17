import 'package:flutter/material.dart';

class MazePainter extends CustomPainter {
  MazePainter({
    required this.cellWidth,
    required this.cellHeight,
    required this.mazeData,
  });

  final double cellWidth;
  final double cellHeight;
  final List<List<int>> mazeData;

  @override
  // 描画ロジック
  void paint(Canvas canvas, Size size) {
    // どのように図形を描画するか定義
    final paint = Paint()..color = Colors.green;
    // 迷路の描画
    for (int i = 0; i < mazeData.length; i++) {
      for (int j = 0; j < mazeData[i].length; j++) {
        if (mazeData[i][j] == 1) {
          // 描画する四角形の位置とサイズを定義
          final rect = Rect.fromLTWH(
            j * cellWidth,
            i * cellHeight,
            cellWidth,
            cellHeight,
          );
          // 四角形をキャンバスに描画
          canvas.drawRect(rect, paint);
        }
      }
    }
  }

  @override
  // 再描画するか定義
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
