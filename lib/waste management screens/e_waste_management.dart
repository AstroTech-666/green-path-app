import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Define a class for the detail pages
class EWasteDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String learnMoreUrl; // Add a field for the URL

  const EWasteDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.learnMoreUrl, // Initialize the URL
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                imageUrl,
                height: 250, // Bigger image height
                fit: BoxFit.contain, // Center the image
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Check if the URL is not empty
                  if (learnMoreUrl.isNotEmpty) {
                    // Use a method to launch the URL (url_launcher package)
                    Uri url = Uri.parse(learnMoreUrl);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $learnMoreUrl';
                    }
                  }
                },
                child: const Text('Learn More'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EWasteManagementPage extends StatelessWidget {
  EWasteManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Waste Management'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Proper E-Waste Disposal',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Did you know? Over 50 million tons of e-waste is generated every year, and only 20% is recycled properly. E-waste contains toxic substances that can harm the environment and human health. Here’s how you can help manage e-waste responsibly:',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: _buildTipCards(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTipCards(BuildContext context) {
    final tips = [
      {
        "title": "Recycle Old Electronics",
        "description":
            "Donate or recycle old electronics through certified e-waste programs.",
        "imageUrl": "assets/images/recycle.jpg",
        "learnMoreUrl":
            "https://www.epa.gov/recycle/electronics-donation-and-recycling", // URL for "Learn More"
      },
      {
        "title": "Data Safety",
        "description": "Remove personal data from devices before disposal.",
        "imageUrl": "assets/images/data_safety.jpg",
        "learnMoreUrl":
            "https://recycleyourelectricals.org.uk/faq/how-do-i-delete-my-data",
      },
      {
        "title": "Avoid Landfills",
        "description":
            "Don’t throw electronics in the trash—most contain harmful materials.",
        "imageUrl": "assets/images/avoid_landfills.jpg",
        "learnMoreUrl":
            "https://www.sciencedirect.com/topics/engineering/avoid-landfill",
      },
      {
        "title": "Local Recycling Events",
        "description":
            "Look for electronics recycling drop-off events in your area.",
        "imageUrl": "assets/images/local_events.jpg",
        "learnMoreUrl":
            "https://dca.ga.gov/sites/default/files/speceventrecycle.pdf",
      },
      {
        "title": "Understand E-Waste Impact",
        "description":
            "E-waste contains lead, mercury, and cadmium that can pollute the environment.",
        "imageUrl": "assets/images/impact.jpg",
        "websiteUrl":
            "https://www.who.int/news-room/fact-sheets/detail/electronic-waste-(e-waste)#:~:text=E%2Dwaste%20contains%20several%20known,and%20function%20of%20the%20lungs.", // Added URL
      },
      {
        "title": "Repair Instead of Replace",
        "description":
            "Consider repairing devices instead of replacing them to reduce waste.",
        "imageUrl": "assets/images/repair.jpg",
        "websiteUrl":
            "https://www.marthastewart.com/1540722/items-you-should-repair-instead-replace", // Added URL
      },
      {
        "title": "Support Eco-Friendly Brands",
        "description":
            "Choose brands that prioritize sustainability and eco-friendly materials.",
        "imageUrl": "assets/images/eco_friendly.jpg",
        "websiteUrl":
            "https://www.vistaprint.com/hub/eco-friendly-brands?srsltid=AfmBOoqWnLSf0oTgXA5yqQnbVBtbyDo5nf2II8z9iOvUedsfMFMKEDL0", // Added URL
      },
      {
        "title": "Educate Others",
        "description":
            "Spread awareness about the importance of e-waste management.",
        "imageUrl": "assets/images/educate.jpg",
        "websiteUrl":
            "https://hummingbirdinternational.net/raising-awareness-about-ewaste/", // Added URL
      },
    ];

    return tips.map((tip) {
      final title = tip['title'] as String;
      return Card(
        color: titleColorMap[title], // Use the color mapping
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EWasteDetailPage(
                  title: title,
                  description: tip['description'] as String,
                  imageUrl: tip['imageUrl'] as String,
                  learnMoreUrl: tip['learnMoreUrl'] as String, // Pass the URL
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center everything
              children: [
                Image.network(
                  tip['imageUrl'] as String,
                  height: 120,
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  tip['description'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  final Map<String, Color> titleColorMap = {
    "Recycle Old Electronics": Colors.green,
    "Data Safety": Colors.orange,
    "Avoid Landfills": Colors.red,
    "Local Recycling Events": Colors.blue,
    "Understand E-Waste Impact": Colors.purple,
    "Repair Instead of Replace": Colors.teal,
    "Support Eco-Friendly Brands": Colors.lightGreen,
    "Educate Others": Colors.yellow,
  };

  final Map<String, IconData> titleIconMap = {
    "Recycle Old Electronics": Icons.recycling,
    "Data Safety": Icons.lock,
    "Avoid Landfills": Icons.delete,
    "Local Recycling Events": Icons.event,
    "Understand E-Waste Impact": Icons.warning,
    "Repair Instead of Replace": Icons.build,
    "Support Eco-Friendly Brands": Icons.thumb_up,
    "Educate Others": Icons.school,
  };
}
