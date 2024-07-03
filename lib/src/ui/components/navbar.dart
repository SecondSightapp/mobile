import 'dart:ffi';

import 'package:flutter/material.dart';

// purple theme color
const themePurple = Color.fromRGBO(56, 48, 115, 1);

class NavBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  NavBar({required this.selectedIndex, required this.onItemTapped});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: widget.selectedIndex,
      onDestinationSelected: widget.onItemTapped,
      destinations: const <NavigationDestination> [
        NavigationDestination(
          icon: Icon(
            Icons.home,
            color: themePurple,
          ),
          label: "Home",
        ),
        NavigationDestination(
          icon: Icon(
            Icons.star_outline,
            color: themePurple,
          ),
          label: "Starboard",
        ),
        NavigationDestination(
          icon: Icon(
            Icons.book_outlined,
            color: themePurple,
          ),
          label: "Journal",
        ),
        NavigationDestination(
          icon: Icon(
            Icons.calendar_month_outlined,
            color: themePurple,
          ),
          label: "Calendar",
        ),
      ],
    );
  }
}