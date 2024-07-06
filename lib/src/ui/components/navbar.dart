import 'package:flutter/material.dart';
import '../themes/source_colors.dart';

class NavBar extends StatefulWidget {
  int selectedIndex;

  NavBar({super.key, required this.selectedIndex});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  void _onItemTapped(int index) {
    setState(() => widget.selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    // icons for navbar, filled in if selected, otherwise outlined
    
    Icon homepage = Icon(
      widget.selectedIndex == 0 ? Icons.home : Icons.home_outlined,
      color: themePurple,
    );

    Icon starboard = Icon(
      widget.selectedIndex == 1 ? Icons.star : Icons.star_outline,
      color: themePurple,
    );

    Icon journal = Icon(
      widget.selectedIndex == 2 ? Icons.book : Icons.book_outlined,
      color: themePurple,
    );

    Icon calendar = Icon(
      widget.selectedIndex == 3 ? Icons.calendar_month : Icons.calendar_month_outlined,
      color: themePurple,
    );

    return NavigationBar(
      selectedIndex: widget.selectedIndex,
      onDestinationSelected: _onItemTapped,
      destinations: <NavigationDestination> [
        NavigationDestination(
          icon: homepage,
          label: "Home",
        ),
        NavigationDestination(
          icon: starboard,
          label: "Starboard",
        ),
        NavigationDestination(
          icon: journal,
          label: "Journal",
        ),
        NavigationDestination(
          icon: calendar,
          label: "Calendar",
        ),
      ],
    );
  }
}