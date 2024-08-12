import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:secondsight/src/ui/themes/source_colors.dart';
import 'package:http/http.dart' as http;
import 'package:secondsight/src/data/token.dart';
import 'package:secondsight/src/ui/screens/loading_screen.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

void _launchOAuthURL() async {
  const oauthUrl = 'https://secondsight-backend.onrender.com/authenticate/android';

  try {
    await launchUrl(
      Uri.parse(oauthUrl),      
      customTabsOptions: CustomTabsOptions(
        colorSchemes: CustomTabsColorSchemes.defaults(),
        shareState: CustomTabsShareState.on,
        urlBarHidingEnabled: true,
        showTitle: true,
        closeButton: CustomTabsCloseButton(
          icon: CustomTabsCloseButtonIcons.back,
        ),
      ),
    );
  } catch (e) {
    print("Error launching OAuth URL: $e");
  }
}

class _LoginPageState extends State<LoginPage> {
  final String initialURL = "https://secondsight-backend.onrender.com/authenticate?device_id=meow&device_name=kitty";
  final String validURL = "https://secondsight-backend.onrender.com/authenticate?continue";

  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    // Listen for incoming deep links
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        print("Received URI: $uri");

        // Handle the received deep link
        _handleDeepLink(uri);
      }
    }, onError: (err) {
      print("Failed to receive URI: $err");
    });
  }

  void _handleDeepLink(Uri uri) {
    // Ensure the scheme, host, and path are what you expect
    if (uri.scheme == 'secondsight' && uri.host == 'oauth' && uri.path == '/callback') {
      // Extract the authorization code from the query parameters
      String? authCode = uri.queryParameters['token'];
      if (authCode != null) {
        print("Authorization code: $authCode");
        TokenService.setToken(authCode);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const LoadingScreen(),
        ));
        // Continue with your OAuth flow, such as exchanging the code for an access token
      } else {
        print("Authorization code not found in the URL");
      }
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/background.jpg', // Update with your image path
          fit: BoxFit.cover,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Text(
                //   'create new account',
                //   style: GoogleFonts.lexend(
                //     textStyle: const TextStyle(
                //       color: Color.fromRGBO(189, 172, 198, 1),
                //       fontSize: 40,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                // const SizedBox(height: 24),
                // Text(
                //   'login or signup here',
                //   style: GoogleFonts.lexend(
                //     textStyle: const TextStyle(
                //       color: Color.fromRGBO(189, 172, 198, 1),
                //       fontSize: 16,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                Center(
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                    "welcome to",
                    style: GoogleFonts.lexend(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFBDACC6),
                      fontSize: 32,
                    ),
                    ),
                  ),
                ),
                Center(
                  child: Material(
                    color: Colors.transparent,
                    child: 
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
                  ) 
                ),
                const SizedBox(height: 48),

                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: ElevatedButton.icon(
                    onPressed: _launchOAuthURL,
                    icon: Image.asset(
                      'assets/images/logos/google.png', // Update with your image path
                      width: 24,
                      height: 24,
                    ), // Add an icon to the button
                    label: Text(
                      'Continue with Google',
                        style: GoogleFonts.lexend(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          color: themePurple,
                          fontSize: 16,
                        ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Implement Facebook Sign In
                    },
                    icon: Image.asset(
                      'assets/images/logos/facebook.png', // Update with your image path
                      width: 24,
                      height: 24,
                    ), // Add an icon to the button
                    label: Text(
                      'Continue with Facebook',
                        style: GoogleFonts.lexend(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          color: themePurple,
                          fontSize: 16,
                        ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Implement Apple Sign In
                    },
                    icon: Image.asset(
                      'assets/images/logos/apple.png', // Update with your image path
                      width: 24,
                      height: 24,
                    ), // Add an icon to the button
                    label: Text(
                      'Continue with Apple',
                        style: GoogleFonts.lexend(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          color: themePurple,
                          fontSize: 16,
                        ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
  