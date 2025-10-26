import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/consultation.dart';
import '../providers/consultation_provider.dart';
import 'package:provider/provider.dart';

class DoctorMatchingScreen extends StatefulWidget {
  const DoctorMatchingScreen({super.key});

  @override
  State<DoctorMatchingScreen> createState() => _DoctorMatchingScreenState();
}

class _DoctorMatchingScreenState extends State<DoctorMatchingScreen> {
  String _selectedSpecialty = 'General';
  String _selectedLanguage = 'English';
  List<Map<String, String>> _matchedProviders = [];

  @override
  void initState() {
    super.initState();
    _matchProviders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Matching')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select your preferred specialty and language:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedSpecialty,
              items: const [
                DropdownMenuItem(value: 'General', child: Text('General Practice')),
                DropdownMenuItem(value: 'Cardiology', child: Text('Cardiology')),
                DropdownMenuItem(value: 'Dermatology', child: Text('Dermatology')),
                DropdownMenuItem(value: 'Psychiatry', child: Text('Mental Health')),
              ],
              onChanged: (value) => setState(() {
                _selectedSpecialty = value!;
                _matchProviders();
              }),
            ),
            DropdownButton<String>(
              value: _selectedLanguage,
              items: const [
                DropdownMenuItem(value: 'English', child: Text('English')),
                DropdownMenuItem(value: 'French', child: Text('French')),
                DropdownMenuItem(value: 'Swahili', child: Text('Swahili')),
                DropdownMenuItem(value: 'Yoruba', child: Text('Yoruba')),
              ],
              onChanged: (value) => setState(() {
                _selectedLanguage = value!;
                _matchProviders();
              }),
            ),
            const SizedBox(height: 24),
            const Text('Matched Care Team:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: _matchedProviders.length,
                itemBuilder: (context, index) {
                  final provider = _matchedProviders[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(provider['initial']!, style: const TextStyle(color: Colors.white)),
                      ),
                      title: Text(provider['name']!),
                      subtitle: Text('${provider['role']} - Specialty: $_selectedSpecialty'),
                      trailing: Icon(
                        provider['role'] == 'Doctor' ? Icons.medical_services : Icons.local_pharmacy,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _bookConsultation,
              child: const Text('Book Consultation'),
            ),
          ],
        ),
      ),
    );
  }

  void _matchProviders() {
    // Enhanced AI-driven matching with more details
    setState(() {
      _matchedProviders = [
        {
          'name': 'Dr. Adebayo Johnson',
          'role': 'Doctor',
          'initial': 'AJ',
          'rating': '4.9',
          'experience': '10 years',
        },
        {
          'name': 'Pharm. Chioma Okwu',
          'role': 'Pharmacist',
          'initial': 'CO',
          'rating': '4.8',
          'experience': '8 years',
        },
      ];
    });
  }

  void _bookConsultation() async {
    final consultation = Consultation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      patientId: '1', // From auth provider in production
      healthcareProviderIds: ['doc1', 'pharm1'],
      symptoms: 'Patient symptoms from previous screen', // Should be passed via navigation
      scheduledDate: DateTime.now().add(const Duration(days: 1)),
      fee: 3000,
      currency: 'NGN',
      status: 'scheduled',
    );
    final provider = Provider.of<ConsultationProvider>(context, listen: false);
    await provider.addConsultation(consultation);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Consultation booked successfully!')),
    );
    context.go('/payment');
  }
}
