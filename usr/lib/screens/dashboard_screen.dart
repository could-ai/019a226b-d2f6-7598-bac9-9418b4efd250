import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/consultation_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final consultationProvider = Provider.of<ConsultationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.logout();
              context.go('/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${authProvider.currentUser?.name ?? 'User'}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            const Text('Quick Actions:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildActionCard(context, 'Book Consultation', Icons.calendar_today, () => context.go('/symptom-entry')),
                _buildActionCard(context, 'My Consultations', Icons.list, () => _showConsultations(context, consultationProvider)),
                _buildActionCard(context, 'Health Community', Icons.forum, () => context.go('/forum')),
                _buildActionCard(context, 'Webinars', Icons.video_call, () => context.go('/webinar')),
                _buildActionCard(context, 'Corporate Health', Icons.business, () => context.go('/corporate-dashboard')),
                _buildActionCard(context, 'Admin Panel', Icons.admin_panel_settings, () => context.go('/admin-panel')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Theme.of(context).primaryColor),
              const SizedBox(height: 8),
              Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  void _showConsultations(BuildContext context, ConsultationProvider provider) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        itemCount: provider.consultations.length,
        itemBuilder: (context, index) {
          final consultation = provider.consultations[index];
          return ListTile(
            title: Text('Consultation ${consultation.id}'),
            subtitle: Text('Status: ${consultation.status}'),
            onTap: () => context.go('/consultation'),
          );
        },
      ),
    );
  }
}
