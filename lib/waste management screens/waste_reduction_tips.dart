import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WasteReductionTipsPage extends StatefulWidget {
  const WasteReductionTipsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WasteReductionTipsPageState createState() => _WasteReductionTipsPageState();
}

class _WasteReductionTipsPageState extends State<WasteReductionTipsPage> {
  int _activeIndex = 0;

  final List<String> wasteImages = [
    'assets/images/plastic_bottle.jpg', // Replace with your own image paths
    'assets/images/reusable_bag.jpg',
    'assets/images/compost_bin.jpg',
    'assets/images/recycle_paper.jpg',
  ];

  final List<String> wasteTitles = [
    'Plastic Bottle',
    'Reusable Bag',
    'Compost Bin',
    'Recycling Paper',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Reduction Tips'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Waste Reduction Tips',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 16),
            _buildCarouselSlider(),
            const SizedBox(height: 16),
            Center(child: _buildIndicator()),
            const SizedBox(height: 24),
            _buildTipSection('1. Reduce', Icons.remove, _reduceTips()),
            const SizedBox(height: 24),
            _buildTipSection('2. Reuse', Icons.refresh, _reuseTips()),
            const SizedBox(height: 24),
            _buildTipSection('3. Recycle', Icons.recycling, _recycleTips()),
            const SizedBox(height: 24),
            _buildTipSection('4. Compost', Icons.eco, _compostTips()),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return CarouselSlider.builder(
      itemCount: wasteImages.length,
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          setState(() {
            _activeIndex = index;
          });
        },
      ),
      itemBuilder: (context, index, realIndex) {
        final imageUrl = wasteImages[index];
        final title = wasteTitles[index];

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageUrl, fit: BoxFit.cover, height: 120),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }

  Widget _buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: _activeIndex,
      count: wasteImages.length,
      effect: ExpandingDotsEffect(
        dotHeight: 10,
        dotWidth: 10,
        activeDotColor: Colors.green[700]!,
      ),
    );
  }

  Widget _buildTipSection(String title, IconData icon, List<String> tips) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.green[700], size: 28),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...tips.map((tip) => _buildTipItem(tip)),
      ],
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _reduceTips() {
    return [
      'Avoid single-use products, such as plastic utensils and straws.',
      'Buy products with minimal packaging or in bulk to reduce waste.',
      'Switch to digital versions of documents and receipts to reduce paper waste.',
      'Consider reducing food waste by planning meals ahead of time and storing food properly.',
      'Use energy-efficient appliances to reduce the need for frequent replacements.',
    ];
  }

  List<String> _reuseTips() {
    return [
      'Repurpose old jars and containers for storage or crafts.',
      'Bring your own reusable bags, bottles, and containers when shopping.',
      'Donate clothes, furniture, and electronics instead of throwing them away.',
      'Reuse wrapping paper, gift bags, or fabric for presents.',
      'Repair damaged items, such as clothing or furniture, rather than replacing them.',
    ];
  }

  List<String> _recycleTips() {
    return [
      'Separate recyclable materials like paper, glass, and plastic from non-recyclable waste.',
      'Check local recycling guidelines to ensure proper disposal of batteries, electronics, and hazardous waste.',
      'Use recycling drop-off locations for items not picked up curbside, such as electronics.',
      'Flatten cardboard boxes to save space in recycling bins.',
      'Rinse food containers before placing them in the recycling bin to avoid contamination.',
    ];
  }

  List<String> _compostTips() {
    return [
      'Compost food scraps like fruit peels, vegetable ends, and coffee grounds.',
      'Use compostable bags or containers for kitchen waste collection.',
      'Add yard waste, such as leaves and grass clippings, to your compost pile.',
      'Ensure your compost has a good balance of green (food scraps) and brown (dry leaves) materials.',
      'Use your finished compost to enrich the soil in your garden or plants.',
    ];
  }
}
