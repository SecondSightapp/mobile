import 'package:flutter/material.dart';

class Star extends StatelessWidget {
  final Color color;

  const Star({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // set today's mood
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: ShapeDecoration(
          color: color,
          shape: const StarBorder(
            innerRadiusRatio: 0.5,
            pointRounding: 0.5,
          ),
        ),
      ),
    );
  }
}