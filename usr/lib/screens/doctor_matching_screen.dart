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
  List<String> _matchedProviders = [];

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
                  return Card(
                    child: ListTile(
                      title: Text(_matchedProviders[index]),
                      subtitle: Text('Specialty: $_selectedSpecialty'),
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
    // Mock AI-driven matching
    _matchedProviders = [
      'Dr. Adebayo Johnson - Doctor',
      'Pharm. Chioma Okwu - Pharmacist',
    ];
  }

  void _bookConsultation() async {
    final consultation = Consultation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      patientId: '1', // From auth
      healthcareProviderIds: ['doc1', 'pharm1'],
      symptoms: 'User symptoms', // From previous screen
      scheduledDate: DateTime.now().add(const Duration(days: 1)),
      fee: 3000,
      currency: 'NGN',
    );
    final provider = Provider.of<ConsultationProvider>(context, listen: false);
    await provider.addConsultation(consultation);
    context.go('/payment');
  }
}
