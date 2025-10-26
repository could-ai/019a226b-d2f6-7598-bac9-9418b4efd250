import 'package:flutter/material.dart';

class CorporateDashboardScreen extends StatelessWidget {
  const CorporateDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Corporate Health Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Employee Health Overview', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStatCard('Total Employees', '150'),
                _buildStatCard('Consultations', '45'),
                _buildStatCard('Health Checks', '78'),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Recent Consultations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(title: Text('Employee A - General Checkup'), subtitle: Text('Completed')),
                  ListTile(title: Text('Employee B - Mental Health'), subtitle: Text('Scheduled')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
