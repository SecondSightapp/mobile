import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/insight.dart';
import '../../data/insight_service.dart';
import '../themes/source_colors.dart';
import 'insight_page.dart';

class Starboard extends StatefulWidget {
  const Starboard({super.key});

  @override
  State<Starboard> createState() => _StarboardState();
}

class _StarboardState extends State<Starboard> {
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => InsightPage()));
                },
                icon: Image.asset('assets/images/ai_stars.png'),
                label: Text(
                  'get ai insights',
                  style: GoogleFonts.lexend(
                    textStyle: const TextStyle(
                      color: themePurple,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ),
            ),
          ),
        ],
      )
    );
  }
}