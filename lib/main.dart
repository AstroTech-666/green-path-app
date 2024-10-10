import 'package:firebase_core/firebase_core.dart'; // Ensure this import is present
import 'package:flutter/material.dart';
import 'package:green_path/feature_screen.dart';
import 'firebase_options.dart'; // Import the generated file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase with the options
  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions.currentPlatform, // Provide the required options
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Green Path',
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/startingscreen.jpg'),
                fit: BoxFit.cover, // Ensure it covers the screen
              ),
            ),
          ),
          // Transparent overlay and text/button on top of the image
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo above the title
                  Image.asset(
                    'assets/images/green_path_logo.png',
                    height: 150, // Increased height for the logo
                  ),
                  const SizedBox(height: 16), // Space between logo and title
                  const Text(
                    'Green Path',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 5, 77, 8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Every Action Counts: Learn, Act, Inspire!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 15, 95, 19),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the feature screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FeatureScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 15, 92, 19),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 8),
                    ),
                    child: const Text(
                      'Go',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
