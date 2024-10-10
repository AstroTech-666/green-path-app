import 'package:flutter/material.dart';

class RecyclingGuidelinesPage extends StatelessWidget {
  const RecyclingGuidelinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recycling Guidelines'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Recycling Guidelines',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildRecyclingList(),
            const SizedBox(height: 32), // Add some space before the next section
            _buildTrashCanIllustration(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecyclingList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recyclable Materials',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildRecyclableItem('Plastic Bottles', Icons.check_circle),
              _buildRecyclableItem('Aluminum Cans', Icons.check_circle),
              _buildRecyclableItem('Glass Bottles', Icons.check_circle),
              _buildRecyclableItem('Cardboard Boxes', Icons.check_circle),
              _buildRecyclableItem('Paper', Icons.check_circle),
              _buildRecyclableItem('Newspapers', Icons.check_circle),
              _buildRecyclableItem('Magazines', Icons.check_circle),
              _buildRecyclableItem('Milk Cartons', Icons.check_circle),
              _buildRecyclableItem('Tetra Paks', Icons.check_circle),
              _buildRecyclableItem('Food Containers (clean)', Icons.check_circle),
              _buildRecyclableItem('Steel Cans', Icons.check_circle),
              _buildRecyclableItem('Yard Waste', Icons.check_circle),
              _buildRecyclableItem('Batteries (check local rules)', Icons.check_circle),
              _buildRecyclableItem('Old Electronics (check local rules)', Icons.check_circle),
              _buildRecyclableItem('Textiles (check local rules)', Icons.check_circle),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Non-Recyclable Materials',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildNonRecyclableItem('Pizza Boxes', Icons.cancel),
              _buildNonRecyclableItem('Polystyrene Foam (Styrofoam)', Icons.cancel),
              _buildNonRecyclableItem('Plastic Bags', Icons.cancel),
              _buildNonRecyclableItem('Tissue Paper', Icons.cancel),
              _buildNonRecyclableItem('Ceramics', Icons.cancel),
              _buildNonRecyclableItem('Glass Cookware', Icons.cancel),
              _buildNonRecyclableItem('Used Paper Towels', Icons.cancel),
              _buildNonRecyclableItem('Food-Soiled Containers', Icons.cancel),
              _buildNonRecyclableItem('Plastic Wrap', Icons.cancel),
              _buildNonRecyclableItem('Chip Bags', Icons.cancel),
              _buildNonRecyclableItem('Foil Wrap', Icons.cancel),
              _buildNonRecyclableItem('Frozen Food Packaging', Icons.cancel),
              _buildNonRecyclableItem('Batteries (unless specified)', Icons.cancel),
              _buildNonRecyclableItem('Hazardous Waste', Icons.cancel),
              _buildNonRecyclableItem('Paint Cans (unless specified)', Icons.cancel),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecyclableItem(String material, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(material),
      trailing: const Icon(Icons.check, color: Colors.green),
    );
  }

  Widget _buildNonRecyclableItem(String material, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.red),
      title: Text(material),
      trailing: const Icon(Icons.close, color: Colors.red),
    );
  }

  Widget _buildTrashCanIllustration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Trash Can Sorting',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTrashCan(Icons.recycling, 'Recyclables', Colors.green),
            _buildTrashCan(Icons.delete, 'Trash', Colors.red),
            _buildTrashCan(Icons.battery_full, 'Hazardous Waste', Colors.orange),
          ],
        ),
        const SizedBox(height: 16),
        _buildConnectionArrows(),
      ],
    );
  }

  Widget _buildTrashCan(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, size: 50, color: color),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildConnectionArrows() {
    return Column(
      children: [
        const SizedBox(height: 8),
        CustomPaint(
          size: const Size(double.infinity, 60),
          painter: ArrowPainter(),
        ),
      ],
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Draw arrows
    final path1 = Path()
      ..moveTo(size.width * 0.2, 10)
      ..lineTo(size.width * 0.3, 10)
      ..lineTo(size.width * 0.3, 20)
      ..lineTo(size.width * 0.25, 15)
      ..lineTo(size.width * 0.3, 10)
      ..lineTo(size.width * 0.35, 15)
      ..lineTo(size.width * 0.3, 20)
      ..lineTo(size.width * 0.3, 10);

    final path2 = Path()
      ..moveTo(size.width * 0.5, 10)
      ..lineTo(size.width * 0.6, 10)
      ..lineTo(size.width * 0.6, 20)
      ..lineTo(size.width * 0.55, 15)
      ..lineTo(size.width * 0.6, 10)
      ..lineTo(size.width * 0.65, 15)
      ..lineTo(size.width * 0.6, 20)
      ..lineTo(size.width * 0.6, 10);

    final path3 = Path()
      ..moveTo(size.width * 0.8, 10)
      ..lineTo(size.width * 0.9, 10)
      ..lineTo(size.width * 0.9, 20)
      ..lineTo(size.width * 0.85, 15)
      ..lineTo(size.width * 0.9, 10)
      ..lineTo(size.width * 0.95, 15)
      ..lineTo(size.width * 0.9, 20)
      ..lineTo(size.width * 0.9, 10);

    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
    canvas.drawPath(path3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
