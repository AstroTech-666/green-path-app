// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

class SustainabilityTips extends StatefulWidget {
  const SustainabilityTips({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SustainabilityTipsState createState() => _SustainabilityTipsState();
}

class _SustainabilityTipsState extends State<SustainabilityTips> {
  List<String> savedTips = [];
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _loadSavedTips();
    _videoController =
        VideoPlayerController.asset('assets/videos/sustainability_video.mp4')
          ..initialize().then((_) {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _loadSavedTips() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedTips = prefs.getStringList('savedTips') ?? [];
    });
  }

  Future<void> _saveTip(String tip) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedTips.add(tip);
      prefs.setStringList('savedTips', savedTips);
    });
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Tip saved!'),
    ));
  }

  void _playVideo() {
    if (_videoController!.value.isPlaying) {
      _videoController!.pause();
    } else {
      _videoController!.play();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sustainability Tips'),
      ),
      body: ListView(
        children: [
          // Tip Cards
          TipCard(
            title: 'Daily Habits',
            tips: const [
              'Reduce, Reuse, Recycle: Minimize waste by following these steps.',
              'Energy Conservation: Turn off lights and unplug devices.',
              'Sustainable Transportation: Walk, bike, or use public transport.',
            ],
            onSaveTip: _saveTip,
          ),
          TipCard(
            title: 'Water Conservation',
            tips: const [
              'Shorter Showers: Set a timer for showers to save water.',
              'Fix Leaks: Check for leaks around the house and repair them.',
              'Water-Saving Fixtures: Install low-flow faucets and showerheads.',
            ],
            onSaveTip: _saveTip,
          ),
          TipCard(
            title: 'Food and Consumption',
            tips: const [
              'Plant-Based Meals: Try meatless meals a few times a week.',
              'Local and Seasonal Produce: Buy locally grown food.',
              'Composting: Start composting kitchen waste.',
            ],
            onSaveTip: _saveTip,
          ),
          TipCard(
            title: 'Eco-Friendly Products',
            tips: const [
              'Biodegradable Options: Choose eco-friendly products.',
              'Zero-Waste Swaps: Use reusable bags and straws.',
            ],
            onSaveTip: _saveTip,
          ),
          TipCard(
            title: 'Engagement and Community Action',
            tips: const [
              'Community Clean-ups: Participate in local clean-up events.',
              'Advocacy and Education: Educate others about sustainability.',
            ],
            onSaveTip: _saveTip,
          ),
          TipCard(
            title: 'Green Technology',
            tips: const [
              'Energy Monitoring Apps: Use apps to track your energy usage.',
              'Smart Home Devices: Invest in devices to reduce energy consumption.',
            ],
            onSaveTip: _saveTip,
          ),
          TipCard(
            title: 'Mindful Consumption',
            tips: const [
              'Minimalism: Declutter and prioritize what you really need.',
              'Research Products: Check the sustainability of brands.',
            ],
            onSaveTip: _saveTip,
          ),
          TipCard(
            title: 'Mental Well-Being and Nature Connection',
            tips: const [
              'Nature Walks: Spend time outdoors to appreciate nature.',
              'Mindfulness Practices: Engage in mindfulness to enhance environmental awareness.',
            ],
            onSaveTip: _saveTip,
          ),
          // Example image
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Image.asset('assets/images/sustainability_image.jpg'),
            ),
          ),
          // Example video
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (_videoController != null &&
                    _videoController!.value.isInitialized)
                  AspectRatio(
                    aspectRatio: _videoController!.value.aspectRatio,
                    child: VideoPlayer(_videoController!),
                  ),
                ElevatedButton(
                  onPressed: _playVideo,
                  child: Text(_videoController!.value.isPlaying
                      ? 'Pause Video'
                      : 'Play Video'),
                ),
              ],
            ),
          ),

          // Related Articles section
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Related Articles',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3, // Change this to 2 for two cards per row
            childAspectRatio:
                0.75, // Adjust this to control height and width ratio
// Related Articles section
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, // One card per row
              childAspectRatio: 2, // Adjust this for your desired aspect ratio
            ),
            itemCount: 10, // Change this to the number of ArticleCards
            itemBuilder: (context, index) {
              return ArticleCard(
                title: [
                  'What is Sustainability?',
                  'Sustainable Living at Home',
                  'Energy Efficiency in Daily Life',
                  'Green Building Practices',
                  'Sustainable Workspaces',
                  'Sustainable Fashion',
                  'Sustainable Transportation Habits',
                  'Conservation of Natural Resources',
                  'Community Involvement in Sustainability',
                  'Sustainable Mindset: Long-Term Changes for the Future'
                ][index],
                url: [
                  'https://www.mcgill.ca/sustainability/files/sustainability/what-is-sustainability.pdf',
                  'https://www.cbs.de/en/blog/sustainable-living-tips-for-a-more-sustainable-lifestyle/',
                  'https://www.researchgate.net/publication/286035847_Energy_efficiency_in_every-day_household_life_Three_scenarios',
                  'https://green.org/2024/01/30/sustainability-and-green-building-practices',
                  'https://uncommon.co.uk/what-makes-a-sustainable-workspace',
                  'https://immago.com/sustainable-fashion-important',
                  'https://www.joloda.com/news/a-guide-to-achieving-sustainable-transportation',
                  'https://www.turito.com/learn/earth-and-science-space/conservation-of-natural-resources',
                  'https://medium.com/@hikaeequs/community-engagement-in-sustainable-development-aa99b75c0d6f#:~:text=Community%20engagement%20plays%20a%20pivotal,environmental%20conservation%20and%20social%20equity',
                  'https://www.linkedin.com/pulse/embracing-sustainability-mindset-shaping-flourishing-kumar-s-r-s',
                ][index],
              );
            },
          ),
        ],
      ),
    );
  }
}

// TipCard Widget
class TipCard extends StatelessWidget {
  final String title;
  final List<String> tips;
  final Function(String) onSaveTip;

  const TipCard(
      {super.key,
      required this.title,
      required this.tips,
      required this.onSaveTip});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...tips.map((tip) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text('• $tip')),
                    IconButton(
                      icon: const Icon(Icons.save),
                      onPressed: () => onSaveTip(tip),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

// ArticleCard Widget
// ArticleCard Widget
class ArticleCard extends StatelessWidget {
  final String title;
  final String url;

  const ArticleCard({super.key, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 23, 100, 26), // Green background
      child: InkWell(
        onTap: () => _launchURL(url),
        child: Container(
          padding:
              const EdgeInsets.all(8.0), // Add padding for better appearance
          alignment: Alignment.center, // Center the content
          child: Text(
            title,
            textAlign: TextAlign.center, // Center the text
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white, // White text
            ),
          ),
        ),
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
}
