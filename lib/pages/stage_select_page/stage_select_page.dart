import 'package:flutter/material.dart';
import 'package:maze_roller/data/maze_data_list.dart';
import 'package:maze_roller/pages/game_page/game_page.dart';

class StageSelectPage extends StatelessWidget {
  const StageSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemCount: stagesList.length,
          itemBuilder: ((context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamePage(
                      mazeData: stagesList[index],
                    ),
                  ),
                );
              },
              child: Card(
                clipBehavior: Clip.hardEdge,
                elevation: 4,
                child: Center(
                  child: Text('Stage.${index + 1}'),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
