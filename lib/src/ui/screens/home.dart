import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/navbar.dart';

// purple theme color
const themePurple = Color.fromRGBO(56, 48, 115, 1);

class HomePage extends StatelessWidget {
  const HomePage({super. key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "second sight",
            style: GoogleFonts.lexend(
              textStyle: const TextStyle(
                color: Color.fromRGBO(209, 196, 197, 1),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: themePurple,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            // open the menu
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              // open settings
            }
          ),
        ],
      ),
      body: const HomePageBody(),
      bottomNavigationBar: NavBar(
        selectedIndex: 0,
        onItemTapped: (index) {

        }
      )
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            'how are you feeling today?',
            style: GoogleFonts.lexend(
              textStyle: const TextStyle(
                color: themePurple,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // add star components here
          ],
        ),
        // add calendar component here
        Center(
          child: Text(
            'start journaling',
            style: GoogleFonts.lexend(
              textStyle: const TextStyle(
                color: themePurple,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const <Widget>[
              // add card components here
            ],
          ),
        ),
      ],
    );
  }
}