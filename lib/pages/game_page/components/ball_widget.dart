import 'package:flutter/material.dart';

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
