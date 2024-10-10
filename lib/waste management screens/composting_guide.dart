import 'package:flutter/material.dart';

class CompostingTipsPage extends StatelessWidget {
  const CompostingTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Composting Tips'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Compostable Materials',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildCompostableList(),
            const SizedBox(height: 16),
            _buildCompostingGuide(),
          ],
        ),
      ),
    );
  }

  Widget _buildCompostableList() {
    final materials = [
      {
        'name': 'Fruit and Vegetable Scraps',
        'image': 'assets/images/fruit_vegetable_scraps.jpg',
        'guide': 'Chop up scraps into smaller pieces for faster decomposition. Add to your compost pile.'
      },
      {
        'name': 'Coffee Grounds and Filters',
        'image': 'assets/images/coffee_grounds.jpg',
        'guide': 'Mix coffee grounds with other compost materials to balance nitrogen levels.'
      },
      {
        'name': 'Eggshells',
        'image': 'assets/images/eggshells.jpg',
        'guide': 'Crush eggshells before adding to the compost to speed up decomposition and add calcium.'
      },
      {
        'name': 'Grass Clippings',
        'image': 'assets/images/grass_clippings.jpg',
        'guide': 'Layer with brown materials to avoid clumping. Add in moderation to maintain balance.'
      },
      {
        'name': 'Leaves',
        'image': 'assets/images/leaves.jpg',
        'guide': 'Shred leaves to help them break down more quickly. Use as a carbon source in your compost.'
      },
      {
        'name': 'Shredded Newspaper',
        'image': 'assets/images/shredded_newspaper.jpg',
        'guide': 'Use in moderation as it’s high in carbon. Ensure it’s not glossy or colored.'
      },
      {
        'name': 'Sawdust (Untreated Wood)',
        'image': 'assets/images/sawdust.jpg',
        'guide': 'Mix with nitrogen-rich materials and avoid using too much to maintain balance.'
      },
      {
        'name': 'Yard Waste',
        'image': 'assets/images/yard_waste.jpg',
        'guide': 'Chop large branches and twigs to speed up decomposition. Mix with other materials.'
      },
      {
        'name': 'Paper Towels (Unbleached)',
        'image': 'assets/images/paper_towels.jpg',
        'guide': 'Ensure they are free of chemical residues. Use to balance carbon content.'
      },
      {
        'name': 'Cardboard (Shredded)',
        'image': 'assets/images/cardboard.jpg',
        'guide': 'Shred cardboard into small pieces. Avoid using shiny or colored cardboard.'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: materials.map((material) {
        return _buildMaterialCard(material);
      }).toList(),
    );
  }

  Widget _buildMaterialCard(Map<String, String> material) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Image.asset(
            material['image']!,
            height: 200,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(
              material['name']!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              material['guide']!,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompostingGuide() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        'General Composting Guide:\n\n'
        '1. **Choose a Compost Bin**: Select a compost bin or create a compost pile in your yard. '
        'Ensure it is well-drained and in a convenient location.\n\n'
        '2. **Layering Materials**: Start with coarse materials like twigs or straw to create airflow. '
        'Add layers of green materials (nitrogen-rich) like fruit scraps and brown materials (carbon-rich) like dried leaves.\n\n'
        '3. **Keep it Balanced**: Aim for a balanced mix of green and brown materials to promote effective decomposition. '
        'A good ratio is about 2 parts brown to 1 part green.\n\n'
        '4. **Moisture Control**: Keep your compost pile moist, similar to a damp sponge. '
        'If it’s too dry, add water; if it’s too wet, add more dry materials.\n\n'
        '5. **Turn the Pile**: Every few weeks, turn the compost pile with a pitchfork or shovel to aerate it and speed up decomposition.\n\n'
        '6. **Monitor Temperature**: A hot compost pile (between 130°F to 160°F) decomposes faster. '
        'If it cools down, turn it to introduce more oxygen.\n\n'
        '7. **Use Finished Compost**: After a few months, your compost should be dark, crumbly, and earthy. '
        'Use it in your garden or potted plants to enrich the soil and provide nutrients.\n\n'
        'By composting, you not only reduce waste but also create nutrient-rich soil for your plants, promoting a sustainable ecosystem.',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
