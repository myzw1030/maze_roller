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
    final ballDiameter = min(cellWidth, cellHeight) * 0.6;

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
      // 衝突していない場合ボールの位置を更新
      if (state.mazeDate != null && !isCollision(state.mazeDate!)) {
        state = state.copyWith(dx: tentativeDx, dy: tentativeDy);
        print('更新中');
      } else {
        // 衝突した場合の処理（例：ボールを停止、ゲームオーバー処理など）
        state = state.copyWith(hasCollided: true);
        print('衝突: ${state.hasCollided}');
      }
    });
  }

  // 判定リセット
  void collisionBoolChange() {
    state = state.copyWith(hasCollided: false);
  }

  // 衝突判定
  bool isCollision(List<List<int>> mazeData) {
    // ボールの円周上でチェックする点の数
    int pointsToCheck = 24;
    // ボールの円周上の各点間の角度を計算（等間隔の角度）
    double angleStep = 2 * pi / pointsToCheck;
    // ボールの円周上の各点の座標を計算
    for (int i = 0; i < pointsToCheck; i++) {
      // ボールの中心からの各点の角度を計算
      double angle = i * angleStep;
      // 円周上の点の座標
      double pointX = state.dx + cos(angle) * state.ballDiameter / 2 * 0.1;
      double pointY = state.dy + sin(angle) * state.ballDiameter / 2 * 0.1;
      // 計算された点がどの迷路のセルにあるか
      int cellX = (pointX / state.cellWidth).floor();
      int cellY = (pointY / state.cellHeight).floor();
      // 計算されたセル座標が迷路の範囲内にあることを確認
      if (cellX >= 0 &&
          cellX < mazeData[0].length &&
          cellY >= 0 &&
          cellY < mazeData.length) {
        if (mazeData[cellY][cellX] == 1) {
          // 壁に当たった
          return true;
        }
      }
    }
    // 壁に当たっていない
    return false;
  }

  // 破棄
  void dispose() {
    ballController.dispose();
  }
}

final gameProvider =
    NotifierProvider<GameNotifier, GameState>(GameNotifier.new);
