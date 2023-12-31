import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maze_roller/models/game.dart';

class CollisionDialog extends ConsumerWidget {
  const CollisionDialog({
    super.key,
    required this.mazeData,
  });

  final List<List<int>> mazeData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameNotifier = ref.read(gameProvider.notifier);
    return AlertDialog(
      title: const Text('ゲームオーバー'),
      content: const Text('もう一度やりますか？'),
      actions: <Widget>[
        TextButton(
          child: const Text('最初から'),
          onPressed: () {
            gameNotifier.collisionBoolChange();
            gameNotifier.dispose();
            Navigator.of(context).pop();
            gameNotifier.initializeGame(context, mazeData);
          },
        ),
      ],
    );
  }
}
