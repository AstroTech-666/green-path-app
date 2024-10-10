import 'package:flutter/material.dart';
import 'composting_guide.dart';
import 'e_waste_management.dart';
import 'hazardous_waste_disposal.dart';
import 'interactive_quizzes.dart';
import 'introduction_to_waste_management.dart';
import 'recycling_guidelines.dart';
import 'sustainable_packaging.dart';
import 'types_of_waste.dart';
import 'waste_reduction_tips.dart';
import 'waste_segregation_tips.dart'; // Import for interactive quizzes page

class WasteManagementGuideScreen extends StatelessWidget {
  const WasteManagementGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Management Guide'),
        backgroundColor: Colors.green[700],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16.0),
        crossAxisCount: 3, // Number of columns
        crossAxisSpacing: 10.0, // Spacing between columns
        mainAxisSpacing: 10.0, // Spacing between rows
        children: [
          _buildGridTile(
            context,
            'Introduction to Waste Management',
            const IntroductionPage(),
          ),
          _buildGridTile(
            context,
            'Types of Waste',
            const TypesOfWastePage(),
          ),
          _buildGridTile(
            context,
            'Waste Segregation Tips',
            const WasteSegregationTipsPage(),
          ),
          _buildGridTile(
            context,
            'Composting Guide',
            const CompostingTipsPage(),
          ),
          _buildGridTile(
            context,
            'Recycling Guidelines',
            const RecyclingGuidelinesPage(),
          ),
          _buildGridTile(
            context,
            'Waste Reduction Tips',
            const WasteReductionTipsPage(),
          ),
          _buildGridTile(
            context,
            'Hazardous Waste Disposal',
            const HazardousWasteDisposalPage(),
          ),
          _buildGridTile(
            context,
            'E_Waste Management',
            EWasteManagementPage(),
          ),
          _buildGridTile(
            context,
            'Sustainable Packaging',
            const SustainablePackagingPage(),
          ),
          // Add an empty tile as a placeholder
          const SizedBox.shrink(),
          // Center the Waste Management Quiz tile in the second row
// In WasteManagementGuideScreen.dart
          _buildGridTile(
            context,
            'Interactive Quizzes',
            const QuizScreen(), // Change this line to match the class name
          ),

          const SizedBox.shrink(),
        ],
      ),
    );
  }

  // Helper method to create the grid tile
  Widget _buildGridTile(BuildContext context, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        height: 100, // Set height for the tile
        decoration: BoxDecoration(
          color: const Color.fromARGB(
              255, 46, 71, 17), // Background color for the tile
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
