// 迷路の各セルが壁か通路かを表す整数の配列
// 0:通路
// 1:壁
// 2:スタート位置
// 3:ゴール位置
final List<List<int>> mazeData1 = [
  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
  [1, 0, 2, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1],
  [1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1],
  [1, 0, 1, 1, 0, 1, 3, 1, 0, 0, 0, 1, 0, 1],
  [1, 0, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1],
  [1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1],
  [1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1],
  [1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1],
  [1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1],
  [1, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1],
  [1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1],
  [1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1],
  [1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1],
  [1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1],
  [1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1],
  [1, 1, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1],
  [1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1],
  [1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1],
  [1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1],
  [1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1],
  [1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1],
  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
];
