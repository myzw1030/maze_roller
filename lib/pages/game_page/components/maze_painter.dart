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
    // セルの値に応じて色を設定
    final paintWall = Paint()..color = Colors.black;
    final paintStart = Paint()..color = Colors.amber;
    final paintGoal = Paint()..color = Colors.green;
    // 迷路の描画
    for (int i = 0; i < mazeData.length; i++) {
      for (int j = 0; j < mazeData[i].length; j++) {
        // 描画する四角形の位置とサイズを定義
        final rect = Rect.fromLTWH(
          j * cellWidth,
          i * cellHeight,
          cellWidth,
          cellHeight,
        );
        switch (mazeData[i][j]) {
          case 1:
            canvas.drawRect(rect, paintWall);
            break;
          case 2:
            canvas.drawRect(rect, paintStart);
            break;
          case 3:
            canvas.drawRect(rect, paintGoal);
            break;
          default:
            break;
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
