import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:green_path/carbon_footprint_screen.dart';
import 'package:green_path/eco_friendly_product_finder.dart';
import 'package:green_path/educational_resources.dart';
import 'package:green_path/energy_tracker.dart';
import 'package:green_path/personal_goals_screen.dart';
import 'package:green_path/sustainability_tips.dart';
import 'package:green_path/water_survey_screen.dart';

import 'waste management screens/waste_management_guide.dart';

class FeatureScreen extends StatelessWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Features'),
        backgroundColor: Colors.green[700],
      ),
      body: Stack(
        children: [
          // Custom Paint for leaves in the background
          CustomPaint(
            painter: LeafPainter(), // Custom painter for leaves
            child:
                Container(), // Empty container to provide size for CustomPaint
          ),
          // White background for buttons
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  GlassyButton(
                    text: 'Carbon Footprint Calculator',
                    imagePath:
                        'assets/icons/carbon_footprint_icon.png', // Update with your image
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CarbonFootprintScreen()),
                      );
                    },
                  ),
                  GlassyButton(
                    text: 'Energy Consumption Tracker',
                    imagePath:
                        'assets/icons/energy_tracker_icon.png', // Update with your image
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EnergyTrackerScreen(),
                        ),
                      );
                    },
                  ),
                  GlassyButton(
                    text: 'Water Usage Tracker',
                    imagePath:
                        'assets/icons/water_usage_icon.png', // Update with your image
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WaterSurveyScreen()),
                      );
                    },
                  ),
                  GlassyButton(
                    text: 'Eco-Friendly Product Finder',
                    imagePath:
                        'assets/icons/eco_product_icon.png', // Update with your image
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const EcoFriendlyProductFinderScreen(),
                        ),
                      );
                    },
                  ),
                  GlassyButton(
                    text: 'Waste Management Guide',
                    imagePath:
                        'assets/icons/waste_management_icon.png', // Update with your image
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const WasteManagementGuideScreen(),
                        ),
                      );
                    },
                  ),
                  GlassyButton(
                    text: 'Sustainability Tips',
                    imagePath:
                        'assets/icons/sustainability_tips_icon.png', // Update with your image
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SustainabilityTips(),
                        ),
                      );
                    },
                  ),
                  GlassyButton(
                    text: 'Personal Goals',
                    imagePath:
                        'assets/icons/personal_goals_icon.png', // Update with your image
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PersonalGoalsScreen(),
                        ),
                      );
                    },
                  ),
                  GlassyButton(
                    text: 'Educational Resources',
                    imagePath:
                        'assets/icons/educational_resources_icon.png', // Update with your image
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const EducationalResourcesScreen(),
                          ));
                    },
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

// Custom Painter for drawing leaves
class LeafPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.green.withOpacity(0.1); // Adjust opacity

    // Draw multiple leaves
    for (int i = 0; i < 20; i++) {
      final double x =
          size.width * (0.05 + (i % 5) * 0.18); // Spread across width
      final double y =
          size.height * (0.1 + (i ~/ 5) * 0.15); // Spread across height

      // Create leaf shape
      Path leafPath = Path();
      leafPath.moveTo(x, y);
      leafPath.quadraticBezierTo(x + 10, y - 10, x + 20, y); // Right curve
      leafPath.quadraticBezierTo(x + 10, y + 10, x, y); // Left curve
      leafPath.close();

      canvas.drawPath(leafPath, paint); // Draw the leaf shape
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class GlassyButton extends StatelessWidget {
  final String text;
  final String imagePath; // New field for the image path
  final VoidCallback onPressed;

  const GlassyButton({
    super.key,
    required this.text,
    required this.imagePath, // New parameter for the image
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: Row(
                  // Change to Row for side-by-side layout
                  children: [
                    // Square Image
                    SizedBox(
                      width: 60, // Width of the square image
                      height: 60, // Height of the square image
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover, // Cover the entire space
                      ),
                    ),
                    // Text Container
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        height: 80, // Increased height for the button
                        child: Text(
                          text,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 0),
                                blurRadius: 5.0,
                                color: Colors.black26,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.green.withOpacity(0.5),
                  onTap: onPressed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
