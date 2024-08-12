import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Image.asset(
                'assets/images/constellation.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Text(
                'lets reflect on this month',
                style: GoogleFonts.lexend(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
          ],
        ),
      )
    );
  }
}