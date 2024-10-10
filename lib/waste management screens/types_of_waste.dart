import 'package:flutter/material.dart';

class TypesOfWastePage extends StatelessWidget {
  const TypesOfWastePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Types of Waste'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Understanding Types of Waste',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Knowing the different types of waste is crucial for effective waste management. '
              'Each type has its own characteristics, environmental impact, and disposal methods.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildWasteSection(
                'Organic Waste',
                'Organic waste consists of biodegradable materials that come from plants and animals. '
                    'It includes food scraps, yard waste, and other compostable materials. '
                    'When disposed of in landfills, organic waste decomposes anaerobically, producing methane, a potent greenhouse gas. '
                    'Instead, organic waste can be composted to create nutrient-rich soil, reducing the need for chemical fertilizers. '
                    'Composting also lowers landfill volumes, thus conserving space and extending landfill life. '
                    'Best practices involve separating organic waste from other types of waste and using home or community composting systems. '
                    'Moreover, educating the public about the benefits of composting can promote higher participation rates. '
                    'Utilizing organic waste can lead to sustainable practices that enhance soil health and biodiversity. '
                    'Overall, managing organic waste effectively is a crucial step toward reducing overall waste generation.',
                'assets/images/organic_waste.jpg', // Replace with your image path
                [
                  'Food scraps',
                  'Yard trimmings',
                  'Fruits and vegetables',
                  'Coffee grounds'
                ],
                'Can produce methane in landfills, contributing to climate change.',
                'Composting to enrich soil and reducing landfill waste.'),
            _buildWasteSection(
                'Hazardous Waste',
                'Hazardous waste contains substances that can pose significant risks to human health and the environment. '
                    'Common examples include batteries, paints, pesticides, and certain electronic components. '
                    'These materials often contain heavy metals, solvents, and toxins that can contaminate soil and water if improperly disposed of. '
                    'Regulatory frameworks exist to manage hazardous waste, requiring special treatment and disposal processes. '
                    'Best practices include using hazardous waste collection programs and educating the public on safe disposal methods. '
                    'Additionally, businesses that generate hazardous waste are often required to track and report their waste management practices. '
                    'Public awareness campaigns can help inform communities about the dangers of hazardous waste. '
                    'In many regions, hazardous waste is processed at specialized facilities designed to neutralize harmful components. '
                    'Proper management is vital to prevent accidents, health risks, and environmental disasters.',
                'assets/images/hazardous_waste.jpg', // Replace with your image path
                ['Batteries', 'Paints', 'Chemicals', 'Pesticides'],
                'Can contaminate soil and water sources, posing health risks.',
                'Proper disposal through designated facilities and recycling programs.'),
            _buildWasteSection(
                'Solid Waste',
                'Solid waste refers to any non-liquid waste that is discarded by households, businesses, and industries. '
                    'This category includes municipal solid waste (MSW), which encompasses everyday items that are thrown away. '
                    'Common examples include plastic bottles, food wrappers, and electronic waste. '
                    'Solid waste can be problematic when not managed correctly, leading to overflowing landfills and environmental pollution. '
                    'Recycling programs can significantly reduce the amount of solid waste that ends up in landfills. '
                    'Composting organic components can also mitigate the solid waste problem. '
                    'Educational initiatives that promote waste segregation at the source can lead to better waste management. '
                    'Innovative solutions, such as waste-to-energy technologies, can help convert solid waste into usable energy. '
                    'Effective management of solid waste is essential for maintaining public health and environmental sustainability.',
                'assets/images/solid_waste.jpg', // Replace with your image path
                ['Plastic containers', 'Old furniture', 'Cans', 'Batteries'],
                'Leads to landfill overflow and environmental pollution.',
                'Implementing recycling and composting initiatives.'),
            _buildWasteSection(
                'Liquid Waste',
                'Liquid waste is defined as any waste material that is in liquid form, including wastewater from households and industries. '
                    'Examples of liquid waste include sewage, industrial effluents, and used cooking oil. '
                    'This type of waste can pose significant risks to human health and the environment if not treated properly. '
                    'Wastewater treatment plants are essential for processing liquid waste before it is released into the environment. '
                    'Proper management can prevent the contamination of water sources and the spread of diseases. '
                    'Recycling certain types of liquid waste, such as used oils, can help recover valuable resources. '
                    'Regular monitoring and regulation of liquid waste disposal practices are critical for protecting public health. '
                    'Community education on the dangers of improper disposal of liquid waste is vital. '
                    'Ultimately, effective management of liquid waste contributes to sustainable water resources.',
                'assets/images/liquid_waste.jpg', // Replace with your image path
                [
                  'Sewage',
                  'Industrial effluents',
                  'Used oils',
                  'Cleaning solutions'
                ],
                'Can contaminate water sources and cause health hazards.',
                'Treatment through wastewater facilities and safe disposal methods.'),
            _buildWasteSection(
                'Recyclable Waste',
                'Recyclable waste includes materials that can be processed and repurposed into new products. '
                    'Common recyclable materials include paper, cardboard, glass, metals, and certain plastics. '
                    'Recycling reduces the need for new raw materials, conserves energy, and reduces greenhouse gas emissions. '
                    'Effective recycling programs can significantly decrease the amount of waste sent to landfills. '
                    'Public participation is essential for the success of recycling initiatives. '
                    'Many municipalities offer curbside recycling services to facilitate waste separation. '
                    'Educational campaigns can raise awareness about which materials are recyclable. '
                    'Implementing deposit-return schemes can incentivize recycling behavior. '
                    'Ultimately, recycling plays a key role in promoting a circular economy and reducing environmental impacts.',
                'assets/images/recyclable_waste.jpg', // Replace with your image path
                [
                  'Glass bottles',
                  'Plastic containers',
                  'Aluminum cans',
                  'Paper'
                ],
                'Decreases landfill waste and conserves natural resources.',
                'Participating in recycling programs and educating others on recycling practices.'),
            _buildWasteSection(
                'Packaging Waste',
                'Packaging waste is generated from the materials used to package goods for distribution and sale. '
                    'This waste can include plastic, paper, cardboard, and foam packaging materials. '
                    'With the rise of online shopping, packaging waste has significantly increased in recent years. '
                    'Improper disposal of packaging materials can lead to environmental pollution and wildlife harm. '
                    'Sustainable packaging solutions, such as biodegradable and compostable materials, are gaining popularity. '
                    'Consumers can reduce packaging waste by choosing products with minimal or reusable packaging. '
                    'Retailers are also encouraged to adopt sustainable practices to reduce packaging waste. '
                    'Regulations are being introduced to limit single-use plastics and promote recycling. '
                    'Addressing packaging waste is critical for achieving broader waste management goals.',
                'assets/images/packaging_waste.jpg', // Replace with your image path
                [
                  'Plastic wrappers',
                  'Cardboard boxes',
                  'Styrofoam containers',
                  'Bubble wrap'
                ],
                'Contributes to pollution and resource depletion.',
                'Adopting sustainable packaging practices and recycling.'),
            _buildWasteSection(
                'Post-Consumer Waste',
                'Post-consumer waste refers to materials discarded by consumers after they have served their intended purpose. '
                    'Examples include used newspapers, empty containers, and food packaging. '
                    'This type of waste is significant because it represents the end of the product lifecycle. '
                    'Proper management of post-consumer waste is crucial for recycling initiatives to succeed. '
                    'Increased consumer awareness can drive more effective recycling efforts. '
                    'Many companies now focus on reducing post-consumer waste through sustainable product design. '
                    'Composting post-consumer organic materials can also contribute to waste reduction. '
                    'Collaboration between manufacturers, consumers, and waste managers is essential. '
                    'Ultimately, addressing post-consumer waste is key to promoting sustainability.',
                'assets/images/post_consumer_waste.jpg', // Replace with your image path
                [
                  'Used newspapers',
                  'Empty bottles',
                  'Food wrappers',
                  'Old clothing'
                ],
                'Can impact recycling rates and environmental sustainability.',
                'Encouraging recycling and reducing consumer waste.'),
            _buildWasteSection(
                'Residual Waste',
                'Residual waste is the waste that remains after recycling, composting, and other recovery efforts. '
                    'It typically includes non-recyclable materials that cannot be processed further. '
                    'Common examples of residual waste are contaminated plastics and certain types of packaging. '
                    'Managing residual waste is crucial to minimize its environmental impact. '
                    'Many communities have adopted zero waste goals to reduce residual waste generation. '
                    'Innovative waste-to-energy technologies can help convert residual waste into energy. '
                    'Educating the public about waste segregation can lead to lower residual waste levels. '
                    'Proper disposal methods are necessary to prevent environmental contamination. '
                    'Ultimately, reducing residual waste contributes to a more sustainable waste management system.',
                'assets/images/residual_waste.jpg', // Replace with your image path
                [
                  'Contaminated plastics',
                  'Mixed materials',
                  'Certain packaging'
                ],
                'Can lead to landfill overflow and resource waste.',
                'Innovating waste-to-energy solutions and improving recycling processes.'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildWasteSection(String title, String description, String imagePath,
      List<String> examples, String impact, String management) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Image.asset(
          imagePath,
          height: 150, // Adjust height as needed
          width: double.infinity,
          fit: BoxFit.contain, // Change to BoxFit.contain
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          'Examples: ${examples.join(', ')}',
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
        Text(
          'Environmental Impact: $impact',
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
        Text(
          'Management Practices: $management',
          style: const TextStyle(fontSize: 14),
        ),
        const Divider(),
        const SizedBox(height: 16),
      ],
    );
  }
}
