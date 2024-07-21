import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondsight/src/ui/screens/home.dart';
import 'dart:async';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _showFirstImage = true;
  Timer? _timer;  

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // image switch every 1 second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _showFirstImage = !_showFirstImage;
      });
    });

    // navigation to HomePage after 5 seconds
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        debugPrint("navigating to HomePage");
        // it cant go back since itss a loading screen
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const HomePage(),
        ));
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); 
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: _showFirstImage
                  ? Image.asset(
                      "assets/images/loading1.png",
                      key: const ValueKey(1),
                      width: 80,
                      height: 80,
                    )
                  : Image.asset(
                      "assets/images/loading2.png",
                      key: const ValueKey(2),
                      width: 80,
                      height: 80,
                    ),
            ),
            const SizedBox(height: 20),
            Text(
              "welcome to",
              style: GoogleFonts.lexend(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFBDACC6),
                fontSize: 32,
              ),
            ),
            Text(
              "second sight",
              style: GoogleFonts.lexend(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFD1C4C5),
                fontSize: 32,
                shadows: [
                  const Shadow(
                    blurRadius: 10.0,
                    color: Colors.white,
                    offset: Offset(0, 0),
                  )
                ]
              ),
            ),
            Text(
              "ai powered journaling",
              style: GoogleFonts.crimsonText(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
