import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: Colors.transparent,
        backgroundColor: Colors.white,
        labelTextStyle: WidgetStateProperty.all(
          GoogleFonts.inter(
            textStyle: const TextStyle(
              color: themePurple,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      child: NavigationBar(
        height: MediaQuery.of(context).size.height * 0.07,
        selectedIndex: widget.selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const <NavigationDestination> [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: themePurple),
            selectedIcon: Icon(Icons.home, color: themePurple),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.star_outline_rounded, color: themePurple),
            selectedIcon: Icon(Icons.star_rounded, color: themePurple),
            label: "Starboard",
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined, color: themePurple),
            selectedIcon: Icon(Icons.book, color: themePurple),
            label: "Journal",
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined, color: themePurple),
            selectedIcon: Icon(Icons.calendar_month, color: themePurple),
            label: "Calendar",
          ),
        ],
      ),
    );
  }
}