import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HazardousWasteDisposalPage extends StatefulWidget {
  const HazardousWasteDisposalPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HazardousWasteDisposalPageState createState() =>
      _HazardousWasteDisposalPageState();
}

class _HazardousWasteDisposalPageState
    extends State<HazardousWasteDisposalPage> {
  final CarouselSliderController _carouselController =
      CarouselSliderController(); // Correct controller type
  int _activeIndex = 0;

  final List<String> disposalImages = [
    'assets/images/chemical_waste.jpg',
    'assets/images/electronic_waste.jpg',
    'assets/images/battery_disposal.jpg',
    'assets/images/paint_disposal.jpg',
  ];

  final List<String> disposalTitles = [
    'Chemical Waste',
    'Electronic Waste',
    'Battery Disposal',
    'Paint Disposal',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hazardous Waste Disposal'),
        backgroundColor: Colors.red[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Proper Disposal of Hazardous Waste',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildCarouselSlider(),
            const SizedBox(height: 16),
            Center(child: _buildIndicator()),
            const SizedBox(height: 24),
            _buildTipSection('1. Chemical Waste', _chemicalWasteTips()),
            const SizedBox(height: 24),
            _buildTipSection('2. Electronic Waste', _electronicWasteTips()),
            const SizedBox(height: 24),
            _buildTipSection('3. Battery Disposal', _batteryDisposalTips()),
            const SizedBox(height: 24),
            _buildTipSection('4. Paint Disposal', _paintDisposalTips()),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return CarouselSlider.builder(
      itemCount: disposalImages.length,
      carouselController:
          _carouselController, // This should be the correct type
      options: CarouselOptions(
        height: 220,
        autoPlay: true,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          setState(() {
            _activeIndex = index;
          });
        },
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        final imageUrl = disposalImages[index];
        final title = disposalTitles[index];

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageUrl, fit: BoxFit.cover, height: 140),
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
      count: disposalImages.length,
      effect: ExpandingDotsEffect(
        dotHeight: 10,
        dotWidth: 10,
        activeDotColor: Colors.red[700]!,
      ),
    );
  }

  Widget _buildTipSection(String title, List<String> tips) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
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
          const Icon(Icons.check_circle, color: Colors.red, size: 20),
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

  List<String> _chemicalWasteTips() {
    return [
      'Never pour chemicals down the drain or toilet.',
      'Store chemical waste in original containers with labels intact.',
      'Check with local hazardous waste facilities for proper disposal instructions.',
      'Wear protective gear when handling hazardous chemicals.',
    ];
  }

  List<String> _electronicWasteTips() {
    return [
      'Donate or recycle old electronics through certified e-waste programs.',
      'Remove personal data from devices before disposal.',
      'Don’t throw electronics in the trash—most contain harmful materials.',
      'Look for electronics recycling drop-off events in your area.',
    ];
  }

  List<String> _batteryDisposalTips() {
    return [
      'Dispose of batteries at designated battery recycling locations.',
      'Never throw batteries in regular trash bins as they can leak hazardous chemicals.',
      'Use rechargeable batteries to reduce battery waste.',
      'Tape over battery terminals before disposal to prevent short circuits.',
    ];
  }

  List<String> _paintDisposalTips() {
    return [
      'Dry out leftover paint by leaving the lid off before disposal.',
      'Donate unused paint to community organizations or recycling programs.',
      'Dispose of paint cans at local hazardous waste collection centers.',
      'Never pour paint down the drain as it can contaminate water supplies.',
    ];
  }
}
