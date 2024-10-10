// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class SustainablePackagingPage extends StatelessWidget {
  const SustainablePackagingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sustainable Packaging'),
        backgroundColor: Colors.green[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality if needed
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(),
            _buildInfoSection(context),
            _buildResourceSection(),
            _buildFeedbackSection(context), // Added Feedback Section
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      height: 250,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/sustainable_packaging_header.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: const Center(
        child: Text(
          'Join the Movement',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 5.0,
                color: Colors.black54,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('What is Sustainable Packaging?'),
          const SizedBox(height: 8),
          const Text(
            'Sustainable packaging refers to the development of packaging solutions that have a reduced environmental impact. It aims to create packaging that is recyclable, compostable, or made from renewable materials.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('Why It Matters'),
          const SizedBox(height: 8),
          const Text(
            'Sustainable packaging reduces waste and carbon footprint, preserves resources, and promotes responsible consumerism. It encourages companies to rethink their packaging processes and find eco-friendly alternatives.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Add functionality for more information
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Learn More'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    );
  }

  Widget _buildResourceSection() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildResourceItem(
            'Biodegradable Packing Peanuts',
            'An eco-friendly alternative to traditional foam peanuts.',
            'assets/images/packing_peanuts.jpg',
          ),
          _buildResourceItem(
            'Recycled Paper Boxes',
            'Boxes made from 100% recycled materials.',
            'assets/images/recycled_boxes.jpg',
          ),
          _buildResourceItem(
            'Compostable Coffee Pods',
            'Coffee pods that break down naturally.',
            'assets/images/compostable_pods.jpg',
          ),
        ],
      ),
    );
  }

  Widget _buildResourceItem(String title, String description, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackSection(BuildContext context) {
    final TextEditingController feedbackController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('User Feedback'),
          const SizedBox(height: 8),
          const Text(
            'We value your thoughts! Please share your feedback about sustainable packaging.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: feedbackController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Your Feedback',
              hintText: 'Type your feedback here...',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              // Validate input
              if (feedbackController.text.isEmpty) {
                _showSnackbar(context, 'Please enter your feedback.');
                return;
              }

              String feedback = feedbackController.text;

              // Save feedback to the backend
              bool success =
                  (_submitFeedback(feedback)) as bool; // Ensure this is bool

              // Show confirmation message
              if (success) {
                feedbackController.clear(); // Clear the input field
                _showSnackbar(context, 'Thank you for your feedback!');
              } else {
                _showSnackbar(
                    context, 'Failed to submit feedback. Please try again.');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Submit Feedback'),
          ),

          const SizedBox(height: 16),

          // Button to open Google Form
          ElevatedButton(
            onPressed: () {
              // Open Google Form in a web browser
              _launchURL(
                  'https://docs.google.com/forms/d/1sTacooWMv-_WvcNbqHAb87Kmaav_7RLvziDbXHUY65o/viewform');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Provide Detailed Feedback (Google Form)'),
          ),

          const SizedBox(height: 16),
          _buildFeedbackList(), // Method to display submitted feedback
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildFeedbackList() {
    // This is a mockup. Replace with actual feedback fetching logic.
    List<String> feedbackList = [
      'Great tips on sustainable packaging!',
      'I love the resources you shared. Very helpful!',
      'Could you add more examples of eco-friendly materials?',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: feedbackList.map((feedback) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            '- $feedback',
            style: const TextStyle(fontSize: 16),
          ),
        );
      }).toList(),
    );
  }
}

// ignore: camel_case_types
class _submitFeedback {
  _submitFeedback(String feedback);
}
