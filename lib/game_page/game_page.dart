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
  double dx = 0;
  double dy = 0;
  // ボールの大きさ
  double ballDiameter = 0;
  double cellWidth = 0;
  double cellHeight = 0;
  Size? screenSize;
  // 衝突したかどうか
  bool hasCollided = false;

  // デバイスを傾けた時のボールの位置を更新する
  void updateBallPosition() {
    // 加速度センサーからの新しい位置データがあるたびに実行されるコールバック関数を呼び出す
    ballController.updateBallPosition((newDx, newDy) {
      if (!hasCollided) {
        // 新しい座標
        double tentativeDx = dx - newDx;
        double tentativeDy = dy + newDy;
        // 画面の範囲を超えないように座標は 0 と (画面の幅 - ボールの直径) の間に制限
        tentativeDx = tentativeDx.clamp(
          0,
          MediaQuery.sizeOf(context).width - ballDiameter,
        );
        tentativeDy = tentativeDy.clamp(
          0,
          MediaQuery.sizeOf(context).height - ballDiameter,
        );
        // 衝突判定
        if (!gameLogic.isCollision(
          tentativeDx,
          tentativeDy,
          ballDiameter,
          cellWidth,
          cellHeight,
          mazeData,
        )) {
          // 衝突していない場合
          setState(() {
            // ボールの位置を更新
            dx = tentativeDx;
            dy = tentativeDy;
          });
        } else {
          // 衝突した場合の処理（例：ボールを停止、ゲームオーバー処理など）
          print('衝突');
          setState(() {
            hasCollided = true;
          });
          // ダイアログ表示
          _gameOverDialog();
        }
      }
    });
  }

  void _setInitialBallPosition() {
    for (int y = 0; y < mazeData.length; y++) {
      for (int x = 0; x < mazeData[y].length; x++) {
        if (mazeData[y][x] == 2) {
          // ボールの初期位置をセルの中心に設定
          dx = x * cellWidth + cellWidth / 2;
          dy = y * cellHeight + cellHeight / 2;
          return;
        }
      }
    }
  }

  void _gameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ゲームオーバー'),
          content: const Text('もう一度やりますか？'),
          actions: <Widget>[
            TextButton(
              child: const Text('最初から'),
              onPressed: () {
                Navigator.of(context).pop();
                _setInitialBallPosition();
              },
            ),
          ],
        );
      },
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  void dispose() {
    ballController.dispose();
    super.dispose();
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

    _setInitialBallPosition();
    updateBallPosition();
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
            duration: const Duration(milliseconds: 220),
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
