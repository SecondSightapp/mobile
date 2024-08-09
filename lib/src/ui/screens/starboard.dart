import 'package:flutter/material.dart';
class Starboard extends StatelessWidget {
  const Starboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(56, 48, 115, 1),
            Color.fromRGBO(108, 132, 160, 1),
            Color.fromRGBO(247, 247, 247, 1),
          ],
        ),
      ),
    );
  }
}