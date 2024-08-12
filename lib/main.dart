import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondsight/src/ui/screens/homepage.dart';
import 'package:secondsight/src/ui/screens/journal_screen.dart';
import 'package:secondsight/src/ui/screens/loading_screen.dart';
import 'package:secondsight/src/ui/screens/login.dart';
import 'package:secondsight/src/ui/screens/starboard.dart';
import 'package:secondsight/src/ui/screens/calendar.dart';
import 'package:secondsight/src/ui/themes/source_colors.dart';
import 'package:provider/provider.dart';
import 'package:secondsight/src/data/mood_state.dart';

void main() {
  runApp(const SecondSightApp());
}

class SecondSightApp extends StatelessWidget {
  const SecondSightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MoodState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(56, 48, 115, 1)),
        ),
        // making this home for now for testing purposes, will be login page otherwise and should only go to homepage if logged in
        home: const LoginPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = <Widget>[
    const Homepage(),
    const JournalScreen(),
    const Starboard(),
    const Calendar(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar with title and buttons for menu and settings
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
      body: _pages[_selectedIndex],
      // navbar
      
      bottomNavigationBar: NavigationBarTheme(
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
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          destinations: const <NavigationDestination> [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: themePurple),
              selectedIcon: Icon(Icons.home, color: themePurple),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.book_outlined, color: themePurple),
              selectedIcon: Icon(Icons.book, color: themePurple),
              label: "Journal",
            ),
            NavigationDestination(
              icon: Icon(Icons.star_outline_rounded, color: themePurple),
              selectedIcon: Icon(Icons.star_rounded, color: themePurple),
              label: "Starboard",
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined, color: themePurple),
              selectedIcon: Icon(Icons.calendar_month, color: themePurple),
              label: "Calendar",
            ),
          ],
        ),
      ),
    );
  }
}