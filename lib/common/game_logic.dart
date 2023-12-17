import 'dart:math';
import 'package:flutter/material.dart';
import 'package:maze_roller/common/ball_controller.dart';

class GameLogic {
  final BallController ballController = BallController();
  // ボールの初期位値
  double dx = 0;
  double dy = 0;
  // ボールの大きさ
  double ballDiameter = 0;
  // 迷路のセル
  double cellWidth = 0;
  double cellHeight = 0;
  // 画面幅
  Size screenSize = Size.zero;
  // 衝突したかどうか
  bool hasCollided = false;

  // 衝突判定
  bool isCollision(
    double dx,
    double dy,
    double ballDiameter,
    double cellWidth,
    double cellHeight,
    List<List<int>> mazeData,
  ) {
    // ボールの中心座標
    final centerX = dx + ballDiameter / 2;
    final centerY = dy + ballDiameter / 2;

    // ボールの辺縁が含まれるセルの範囲を計算
    final leftCellX = ((centerX - ballDiameter / 2) / cellWidth).floor();
    final rightCellX = ((centerX + ballDiameter / 2) / cellWidth).floor();
    final topCellY = ((centerY - ballDiameter / 2) / cellHeight).floor();
    final bottomCellY = ((centerY + ballDiameter / 2) / cellHeight).floor();

    // これらのセルが壁かどうかをチェック
    for (var y = topCellY; y <= bottomCellY; y++) {
      for (var x = leftCellX; x <= rightCellX; x++) {
        if (mazeData[y][x] == 1) {
          // 壁に当たった
          return true;
        }
      }
    }
    // 壁に当たっていない
    return false;
  }

  void dispose() {
    ballController.dispose();
  }

  // デバイスの傾きに基づくボールの位置の更新と衝突判定
  void updateBallPositionAndCheckCollision(
    BuildContext context,
    Function() onCollision,
    List<List<int>> mazeData,
  ) {
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
        print('tentativeDx:$tentativeDx');
        print('tentativeDy:$tentativeDy');
        // 衝突判定
        if (!isCollision(
          tentativeDx,
          tentativeDy,
          ballDiameter,
          cellWidth,
          cellHeight,
          mazeData,
        )) {
          // 衝突していない場合
          // ボールの位置を更新
          dx = tentativeDx;
          dy = tentativeDy;
        } else {
          // 衝突した場合の処理（例：ボールを停止、ゲームオーバー処理など）
          print('衝突');
          hasCollided = true;
          onCollision();
        }
      }
    });
  }

  // 初期位置をセットする
  void setInitialBallPosition(
    List<List<int>> mazeData,
  ) {
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

  void initializeGame(BuildContext context, List<List<int>> mazeData) {
    // Size? screenSize;
    screenSize = MediaQuery.sizeOf(context);
    // スクリーン幅を列の数で割ることで、各セルの幅を計算
    cellWidth = screenSize.width / mazeData[0].length;
    // スクリーンの高さを行の数で割ることで、各セルの高さを計算
    cellHeight = screenSize.height / mazeData.length;
    // ボールの大きさは壁より少し小さくする
    ballDiameter = min(cellWidth, cellHeight) * 0.9;

    setInitialBallPosition(mazeData);
    updateBallPositionAndCheckCollision(
        context, () => gameOverDialog(context), mazeData);
  }

  void gameOverDialog(
    BuildContext context,
  ) {
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
                // setInitialBallPosition();
              },
            ),
          ],
        );
      },
    );
  }
}
