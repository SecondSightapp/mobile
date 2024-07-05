import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../themes/source_colors.dart';

class Star extends StatelessWidget {
  final Color color;

  const Star({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 89,
      height: 85,
      decoration: ShapeDecoration(
        color: color,
        shape: const StarBorder(
          innerRadiusRatio: 0.4,
          pointRounding: 0.5,
        ),
      ),
    );
  }
}