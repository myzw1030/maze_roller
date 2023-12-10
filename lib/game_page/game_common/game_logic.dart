class GameLogic {
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
          return true; // 壁に当たった
        }
      }
    }
    return false; // 壁に当たっていない
  }
}
