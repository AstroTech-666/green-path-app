import 'package:flutter/material.dart';

class WasteSegregationTipsPage extends StatelessWidget {
  const WasteSegregationTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Segregation Tips'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top Tips for Effective Waste Segregation',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildTipCard(
              context,
              '1. Know Your Bins',
              'Familiarize yourself with the types of bins available in your area (e.g., organic, recyclable, and general waste). Make sure to label them clearly if possible.\n\n'
              'Understanding which bin to use is crucial. Each type of waste has a specific disposal method that prevents contamination. '
              'For example, organic waste should go in compost bins while recyclables like paper, plastic, and metals should be placed in their designated containers. '
              'Local governments may provide guidelines on bin colors and types, so take some time to research this information. '
              'By knowing your bins, you contribute to a cleaner environment and more efficient waste management in your community.',
              Colors.lightGreen[200]!,
            ),
            _buildTipCard(
              context,
              '2. Separate at Source',
              'Start the segregation process at home by keeping separate containers for different types of waste to avoid cross-contamination.\n\n'
              'This means having distinct bins for recyclables, compostables, and general waste right in your kitchen or workspace. '
              'By doing this, you ensure that your waste is sorted correctly from the beginning, which makes it easier for waste collectors to manage. '
              'You can use colorful containers or labels to make it clear which is which. '
              'Encouraging family members to participate in this practice not only improves waste management but also instills a sense of responsibility.',
              Colors.blue[200]!,
            ),
            _buildTipCard(
              context,
              '3. Rinse Before Recycling',
              'Clean containers and packaging before putting them in the recycling bin to ensure they are contamination-free.\n\n'
              'Leftover food and liquids can ruin entire batches of recyclables. '
              'Simply rinsing out bottles, jars, and containers helps maintain the quality of recyclable materials. '
              'Consider keeping a small sink or basin near your recycling station for quick rinsing. '
              'By practicing this step, you increase the chances of these materials being successfully recycled and reduce landfill waste.',
              Colors.orange[200]!,
            ),
            _buildTipCard(
              context,
              '4. Check Local Guidelines',
              'Different places have varying guidelines for waste segregation. Always check local rules for what can and cannot be recycled.\n\n'
              'These guidelines can vary widely based on location and can change over time. '
              'Many municipalities have websites or hotlines you can contact for up-to-date information. '
              'Make it a habit to stay informed about your local recycling policies and make sure to follow them to ensure proper waste disposal. '
              'Participating in community programs or workshops can also provide valuable insights into effective waste segregation.',
              Colors.purple[200]!,
            ),
            _buildTipCard(
              context,
              '5. Educate Family and Friends',
              'Spread awareness by educating your family and friends about the importance of waste segregation and how to do it correctly.\n\n'
              'Sharing knowledge can inspire others to adopt eco-friendly habits. '
              'Consider organizing a small get-together where you discuss waste management tips, share personal experiences, and maybe even host a fun quiz! '
              'Use social media platforms to share informative posts or resources about waste segregation. '
              'The more people are aware of these practices, the bigger impact we can make collectively towards a sustainable future.',
              Colors.teal[200]!,
            ),
            _buildTipCard(
              context,
              '6. Use Biodegradable Bags',
              'Opt for biodegradable or compostable bags for your organic waste to minimize plastic use and facilitate composting.\n\n'
              'Plastic bags contribute significantly to environmental pollution. By choosing biodegradable options, you can reduce plastic waste. '
              'These bags break down naturally over time, making them a better choice for organic waste. '
              'You can also create your own compostable bags using newspaper or other natural materials at home. '
              'Make sure to educate others about the benefits of using biodegradable bags, encouraging them to make similar choices.',
              Colors.red[200]!,
            ),
            _buildTipCard(
              context,
              '7. Reduce, Reuse, Recycle',
              'Remember the three Rs! Always try to reduce waste, reuse items, and recycle materials whenever possible.\n\n'
              'Start by evaluating your consumption habits—do you really need that extra plastic bag or packaging? '
              'Consider reusing items before tossing them away, such as using glass jars for storage or old t-shirts as cleaning rags. '
              'Implementing these practices not only helps the environment but can also save you money. '
              'Engaging in community swap events or donating items you no longer need can also encourage a culture of sharing and reusing.',
              Colors.yellow[200]!,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard(BuildContext context, String title, String description, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
