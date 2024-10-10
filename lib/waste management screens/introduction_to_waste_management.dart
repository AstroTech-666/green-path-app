// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this for launching URLs

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Introduction to Waste Management'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center( // Center the entire body content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center the content
            children: [
              // Introduction Section
              const Text(
                'What is Waste Management?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, // Center text
              ),
              const SizedBox(height: 8),
              const Text(
                'Waste management refers to the collection, transport, processing, recycling, or disposal of waste materials. '
                'It is a critical component of environmental sustainability, aiming to reduce the adverse effects of waste on '
                'human health and the environment. Proper waste management practices help conserve resources, reduce pollution, '
                'and promote recycling efforts.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center, // Center text
              ),
              const SizedBox(height: 16),

              // 5 Rs Section
              const Text(
                'The 5 Rs of Waste Management',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, // Center text
              ),
              const SizedBox(height: 8),
              const Text(
                '1. Refuse: Avoid unnecessary products and packaging.\n'
                '2. Reduce: Minimize waste by using less.\n'
                '3. Reuse: Find ways to use items multiple times.\n'
                '4. Recycle: Sort materials for recycling to reduce landfill waste.\n'
                '5. Rot: Compost organic materials to enrich soil.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center, // Center text
              ),
              const SizedBox(height: 16),

              // Articles Section
              const Text(
                'Further Reading',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, // Center text
              ),
              const SizedBox(height: 8),
              _buildArticleBox(
                'Understanding Waste Management',
                'An in-depth look at the principles of waste management.',
                'https://forestnation.com/blog/what-is-waste-management-and-its-process/?srsltid=AfmBOopKDCb1IOIrY8vq0mySdLk1kIHHqGI9v-GBNURnO8QoAmvBKvsd', // Add the link here
                context,
              ),
              const SizedBox(height: 8),
              _buildArticleBox(
                'The Importance of Recycling',
                'Why recycling matters for our planet.',
                'https://www.recyclenow.com/how-to-recycle/why-is-recycling-important', // Add the link here
                context,
              ),
              const SizedBox(height: 8),
              _buildArticleBox(
                'Composting Basics',
                'Learn how to compost effectively at home.',
                'https://www.artinthepark128.org/post/composting-101-in-harlem-nyc?gad_source=1&gclid=Cj0KCQjw6oi4BhD1ARIsAL6pox0fGR0e34vmrJi4YujZUP1KDkkzf3fJq_GGJYKsSH7DfIoc1PFHMy8aAoVIEALw_wcB', // Add the link here
                context,
              ),
              const SizedBox(height: 16),

              // Videos Section
              const Text(
                'Educational Videos',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, // Center text
              ),
              const SizedBox(height: 8),
              _buildVideoBox('What is Waste Management?',
                  'https://youtu.be/K6ppCC3lboU?si=xZa2pn8ibfdQQyKz'),
              const SizedBox(height: 8),
              _buildVideoBox('How to Recycle Effectively',
                  'https://youtu.be/IsAg-JqJnA8?si=BCdzIGBH8k-duWF8'),
              const SizedBox(height: 8),
              _buildVideoBox('Composting Made Easy',
                  'https://youtu.be/_K25WjjCBuw?si=meYEvyooH-K7ycQN'),
              const SizedBox(height: 16),

              // Conclusion Section
              const Text(
                'Conclusion',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, // Center text
              ),
              const SizedBox(height: 8),
              const Text(
                'Effective waste management is crucial for ensuring a sustainable environment. By understanding the importance of '
                'waste management and adopting practices such as recycling and composting, we can contribute to a healthier planet '
                'for future generations.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center, // Center text
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticleBox(
      String title, String description, String link, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(link)) {
          await launch(link); // Launch the article link
        } else {
          throw 'Could not launch $link';
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.lightGreenAccent[100],
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.green, width: 1), // Border color
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center the text in the box
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // Center text
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center, // Center text
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoBox(String title, String videoUrl) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(videoUrl)) {
          await launch(videoUrl); // Launch the video link
        } else {
          throw 'Could not launch $videoUrl';
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center the text in the box
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center, // Center text
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.black, // Placeholder for video
                  child: const Center(
                    child: Text(
                      'Tap to play video',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
