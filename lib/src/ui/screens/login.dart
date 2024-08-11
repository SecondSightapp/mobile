import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:secondsight/src/ui/themes/source_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginBody(),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

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
                Center(
                  child: Text(
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
                ),
                const SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: ElevatedButton.icon(
                    onPressed: _handleGoogleSignIn,
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

  Future<void> _handleGoogleSignIn() async {
    // try {
    //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    //   if (googleUser != null) {
    //     // Successfully signed in
    //     print('Signed in: ${googleUser.displayName}');
    //   }
    // } catch (error) {
    //   print('Error signing in with Google: $error');
    // }
  }
}
