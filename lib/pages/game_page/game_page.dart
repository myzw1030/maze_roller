import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maze_roller/models/game.dart';
import 'package:maze_roller/pages/game_page/components/ball_widget.dart';
import 'package:maze_roller/pages/game_page/components/collision_dialog.dart';
import 'package:maze_roller/pages/game_page/components/maze_painter.dart';

class GamePage extends ConsumerStatefulWidget {
  // 迷路データ
  final List<List<int>> mazeData;

  const GamePage({super.key, required this.mazeData});

  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends ConsumerState<GamePage> {
  late GameNotifier gameNotifier;

  @override
  void initState() {
    super.initState();
    // GameNotifier のインスタンスを初期化
    gameNotifier = ref.read(gameProvider.notifier);
    // 初回ビルドが終了するまで状態変更を待つことで、ビルド中に状態変更してクラッシュすることを防ぐ
    WidgetsBinding.instance.addPostFrameCallback((_) {
      gameNotifier.initializeGame(context, widget.mazeData);
    });
  }

  @override
  void dispose() {
    gameNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameProvider);

    // 衝突が発生した場合、ダイアログを表示
    if (gameState.hasCollided) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) => CollisionDialog(mazeData: widget.mazeData),
        );
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          // 迷路描画
          CustomPaint(
            painter: MazePainter(
              cellWidth: gameState.cellWidth,
              cellHeight: gameState.cellHeight,
              mazeData: widget.mazeData,
            ),
            size: Size(
              gameState.screenSize.width,
              gameState.screenSize.height,
            ),
          ),
          // ボール
          AnimatedPositioned(
            duration: const Duration(milliseconds: 240),
            left: gameState.dx,
            top: gameState.dy,
            child: BallWidget(ballDiameter: gameState.ballDiameter),
          ),
        ],
      ),
    );
  }
}
