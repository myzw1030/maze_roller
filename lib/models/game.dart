import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maze_roller/common/ball_controller.dart';
import 'package:maze_roller/models/game_state/game_state.dart';

class GameNotifier extends Notifier<GameState> {
  @override
  GameState build() {
    return GameState();
  }

  late BallController ballController = BallController();

  // アプリ起動時に設定する
  void initializeGame(
    BuildContext context,
    List<List<int>> mazeData,
  ) {
    final screenSize = MediaQuery.sizeOf(context);
    // スクリーン幅を列の数で割ることで、各セルの幅を計算
    final cellWidth = screenSize.width / mazeData[0].length;
    // スクリーンの高さを行の数で割ることで、各セルの高さを計算
    final cellHeight = screenSize.height / mazeData.length;
    // ボールの大きさは壁より少し小さくする
    final ballDiameter = min(cellWidth, cellHeight) * 0.8;

    print('screenSize:$screenSize');
    print('ballDiameter:$ballDiameter');

    setInitialBallPosition(
        mazeData, cellWidth, cellHeight, ballDiameter, screenSize);
    startListeningToSensor();
  }

  // 初期位置をセットする
  void setInitialBallPosition(
    List<List<int>> mazeData,
    double cellWidth,
    double cellHeight,
    double ballDiameter,
    Size screenSize,
  ) {
    for (int y = 0; y < mazeData.length; y++) {
      for (int x = 0; x < mazeData[y].length; x++) {
        if (mazeData[y][x] == 2) {
          final dx = x * cellWidth + cellWidth / 2 - ballDiameter / 2;
          final dy = y * cellHeight + cellHeight / 2 - ballDiameter / 2;
          state = state.copyWith(
            dx: dx,
            dy: dy,
            ballDiameter: ballDiameter,
            cellWidth: cellWidth,
            cellHeight: cellHeight,
            screenSize: screenSize,
            mazeDate: mazeData,
          );
          return;
        }
      }
    }
  }

  // 衝突判定ロジック
  void startListeningToSensor() {
    ballController.updateBallPosition((newDx, newDy) {
      if (state.hasCollided) return;

      // 新しい座標
      double tentativeDx = state.dx - newDx;
      double tentativeDy = state.dy + newDy;
      // 画面の範囲を超えないように座標は 0 と (画面の幅 - ボールの直径) の間に制限
      tentativeDx =
          tentativeDx.clamp(0, state.screenSize.width - state.ballDiameter);
      tentativeDy =
          tentativeDy.clamp(0, state.screenSize.height - state.ballDiameter);
      print('state.mazeDate:$state.mazeDate');
      // 衝突していない場合ボールの位置を更新
      if (state.mazeDate != null &&
          !isCollision(tentativeDx, tentativeDy, state.mazeDate!)) {
        state = state.copyWith(dx: tentativeDx, dy: tentativeDy);
        print('更新中');
      } else {
        // 衝突した場合の処理（例：ボールを停止、ゲームオーバー処理など）
        print('衝突');
        state = state.copyWith(hasCollided: true);
      }
    });
  }

  // 衝突判定
  bool isCollision(double dx, double dy, List<List<int>> mazeData) {
    // ボールの中心座標
    final centerX = dx + state.ballDiameter / 2;
    final centerY = dy + state.ballDiameter / 2;

    // ボールの辺縁が含まれるセルの範囲を計算
    final leftCellX =
        ((centerX - state.ballDiameter / 2) / state.cellWidth).floor();
    final rightCellX =
        ((centerX + state.ballDiameter / 2) / state.cellWidth).floor();
    final topCellY =
        ((centerY - state.ballDiameter / 2) / state.cellHeight).floor();
    final bottomCellY =
        ((centerY + state.ballDiameter / 2) / state.cellHeight).floor();

    print('centerX:$centerX');
    print('centerY:$centerY');
    print('leftCellX:$leftCellX');
    print('rightCellX:$rightCellX');
    print('topCellY:$topCellY');
    print('bottomCellY:$bottomCellY');
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

final gameProvider =
    NotifierProvider<GameNotifier, GameState>(GameNotifier.new);
