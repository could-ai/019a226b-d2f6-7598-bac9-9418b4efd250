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
      body: RefreshIndicator(
        onRefresh: () async {
          await consultationProvider.loadConsultations('1'); // Load with user ID
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Theme.of(context).primaryColor, Theme.of(context).colorScheme.secondary],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back, ${authProvider.currentUser?.name ?? 'User'}!',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'How are you feeling today?',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
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
              const SizedBox(height: 24),
              if (consultationProvider.consultations.isNotEmpty) ...[
                const Text('Recent Activity:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: consultationProvider.consultations.length,
                    itemBuilder: (context, index) {
                      final consultation = consultationProvider.consultations[index];
                      return Card(
                        child: ListTile(
                          title: Text('Consultation ${consultation.id}'),
                          subtitle: Text('Status: ${consultation.status} • ${consultation.scheduledDate.toString().split(' ')[0]}'),
                          trailing: Icon(
                            consultation.status == 'completed' ? Icons.check_circle : Icons.schedule,
                            color: consultation.status == 'completed' ? Colors.green : Colors.orange,
                          ),
                          onTap: () {
                            if (consultation.status == 'scheduled') {
                              context.go('/consultation');
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey[50]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: Theme.of(context).primaryColor),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConsultations(BuildContext context, ConsultationProvider provider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text('My Consultations', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: provider.consultations.length,
                  itemBuilder: (context, index) {
                    final consultation = provider.consultations[index];
                    return Card(
                      child: ListTile(
                        title: Text('Consultation ${consultation.id}'),
                        subtitle: Text('Status: ${consultation.status}'),
                        onTap: () => Navigator.pop(context),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
