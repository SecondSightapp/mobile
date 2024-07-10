import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const LoginBody(),
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
                const Text(
                  'create new account',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Ensure text is visible on the background
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const Text(
                  'login or signup here',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Ensure text is visible on the background
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                ElevatedButton.icon(
                  onPressed: _handleGoogleSignIn,
                  icon: Icon(Icons.account_circle), // Add an icon to the button
                  label: const Text('Sign in with Google'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement Facebook Sign In
                  },
                  icon: Icon(Icons.facebook), // Add an icon to the button
                  label: const Text('Sign in with Facebook'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.blue[800],
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement Apple Sign In
                  },
                  icon: Icon(Icons.apple), // Add an icon to the button
                  label: const Text('Sign in with Apple'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
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
