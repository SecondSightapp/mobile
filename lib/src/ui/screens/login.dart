import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:secondsight/src/data/token.dart';
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
                  onPressed: _launchOAuthURL,
                  icon: const Icon(Icons.account_circle), // Add an icon to the button
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
                  icon: const Icon(Icons.facebook), // Add an icon to the button
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
                  icon: const Icon(Icons.apple), // Add an icon to the button
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
}
  