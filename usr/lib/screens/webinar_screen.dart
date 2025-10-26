import 'package:flutter/material.dart';

class WebinarScreen extends StatelessWidget {
  const WebinarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Webinars')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildWebinarCard('Preventive Health', 'Dr. Johnson', 'Weekly Q&A on wellness'),
          _buildWebinarCard('Mental Health Awareness', 'Dr. Okwu', 'Coping strategies'),
          _buildWebinarCard('Nutrition and Chronic Care', 'Pharm. Adebayo', 'Diet management'),
        ],
      ),
    );
  }

  Widget _buildWebinarCard(String title, String speaker, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Speaker: $speaker'),
            Text(description),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Join Webinar'),
            ),
          ],
        ),
      ),
    );
  }
}
