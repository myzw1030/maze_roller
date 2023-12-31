import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

class BallController {
  StreamSubscription<AccelerometerEvent>? _listener;

  // デバイスを傾けた時のボールの位置を更新する
  void updateBallPosition(
    void Function(double dx, double dy) onPositionChanged,
  ) {
    // 加速度センサーからのデータをリッスン
    _listener = accelerometerEventStream().listen((AccelerometerEvent event) {
      // 新しい位置を計算
      final newDx = event.x * 10;
      final newDy = event.y * 10;
      // コールバック関数を呼び出して、新しい位置を通知
      onPositionChanged(newDx, newDy);
    });
  }

  // リスナーを解除
  void dispose() {
    _listener?.cancel();
  }
}
