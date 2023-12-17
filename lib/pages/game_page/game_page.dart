import 'package:flutter/material.dart';
import 'package:maze_roller/common/game_logic.dart';

class GamePage extends StatefulWidget {
  // 迷路データ
  final List<List<int>> mazeData;

  const GamePage({super.key, required this.mazeData});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final GameLogic gameLogic = GameLogic();

  @override
  // initStateの直後に呼ばれ、contextにアクセスすることが可能
  void didChangeDependencies() {
    super.didChangeDependencies();
    gameLogic.initializeGame(context, widget.mazeData);
  }

  @override
  void dispose() {
    gameLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 迷路描画
          CustomPaint(
            painter: MazePainter(
              cellWidth: gameLogic.cellWidth,
              cellHeight: gameLogic.cellHeight,
              mazeData: widget.mazeData,
            ),
            size: Size(gameLogic.screenSize.width, gameLogic.screenSize.height),
          ),
          // ボール
          AnimatedPositioned(
            duration: const Duration(milliseconds: 220),
            left: gameLogic.dx,
            top: gameLogic.dy,
            child: BallWidget(ballDiameter: gameLogic.ballDiameter),
          ),
        ],
      ),
    );
  }
}

class MazePainter extends CustomPainter {
  MazePainter(
      {required this.cellWidth,
      required this.cellHeight,
      required this.mazeData});
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

class BallWidget extends StatelessWidget {
  const BallWidget({
    super.key,
    required this.ballDiameter,
  });

  final double ballDiameter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ballDiameter,
      height: ballDiameter,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
    );
  }
}
