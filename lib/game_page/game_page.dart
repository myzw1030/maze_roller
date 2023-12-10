import 'dart:math';
import 'package:flutter/material.dart';
import 'package:maze_roller/game_page/game_common/ball_controller.dart';
import 'package:maze_roller/game_page/game_common/game_logic.dart';
import 'package:maze_roller/game_page/maze_data/maze_data_test.dart';

// 迷路データ
List<List<int>> mazeData = mazeDataTest;

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // 共通ロジック呼び出し
  final GameLogic gameLogic = GameLogic();
  final BallController ballController = BallController();
  // ボールの初期位値
  double dx = 200;
  double dy = 200;
  // ボールの大きさ
  double ballDiameter = 0;
  double cellWidth = 0;
  double cellHeight = 0;
  Size? screenSize;

  // デバイスを傾けた時のボールの位置を更新する
  void updateBallPosition() {
    // 加速度センサーからの新しい位置データがあるたびに実行されるコールバック関数を呼び出す
    ballController.updateBallPosition((newDx, newDy) {
      setState(() {
        // ボールの位置を更新
        dx -= newDx;
        dy += newDy;
        // 画面の範囲を超えないように座標は 0 と (画面の幅 - ボールの直径) の間に制限
        dx = dx.clamp(0, MediaQuery.sizeOf(context).width - ballDiameter);
        dy = dy.clamp(0, MediaQuery.sizeOf(context).height - ballDiameter);
      });
    });
  }

  @override
  void initState() {
    super.initState();

    updateBallPosition();
  }

  @override
  // initStateの直後に呼ばれ、contextにアクセスすることが可能
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenSize = MediaQuery.sizeOf(context);
    // スクリーン幅を列の数で割ることで、各セルの幅を計算
    cellWidth = screenSize!.width / mazeData[0].length;
    // スクリーンの高さを行の数で割ることで、各セルの高さを計算
    cellHeight = screenSize!.height / mazeData.length;
    // ボールの大きさは壁より少し小さくする
    ballDiameter = min(cellWidth, cellHeight) * 0.9;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 迷路描画
          CustomPaint(
            painter: MazePainter(
              cellWidth: cellWidth,
              cellHeight: cellHeight,
            ),
            size: Size(screenSize!.width, screenSize!.height),
          ),
          // ボール
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            left: dx,
            top: dy,
            child: BallWidget(ballDiameter: ballDiameter),
          ),
        ],
      ),
    );
  }
}

class MazePainter extends CustomPainter {
  MazePainter({
    required this.cellWidth,
    required this.cellHeight,
  });
  final double cellWidth;
  final double cellHeight;
  @override
  // 描画ロジック
  void paint(Canvas canvas, Size size) {
    // どのように図形を描画するか定義
    final paint = Paint()..color = Colors.green;
    // 迷路の描画
    for (var i = 0; i < mazeData.length; i++) {
      for (var j = 0; j < mazeData[i].length; j++) {
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
