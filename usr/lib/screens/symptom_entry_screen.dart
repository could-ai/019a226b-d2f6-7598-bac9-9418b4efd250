import 'package:flutter/material.dart';
import '../utils/notification_service.dart';
import '../providers/consultation_provider.dart';
import 'package:provider/provider.dart';

class SymptomEntryScreen extends StatefulWidget {
  const SymptomEntryScreen({super.key});

  @override
  State<SymptomEntryScreen> createState() => _SymptomEntryScreenState();
}

class _SymptomEntryScreenState extends State<SymptomEntryScreen> {
  final _symptomsController = TextEditingController();
  String _urgency = 'low';
  String _aiSuggestion = '';
  bool _isAnalyzing = false;

  final List<String> _commonSymptoms = [
    'Headache', 'Fever', 'Cough', 'Fatigue', 'Nausea', 'Dizziness',
    'Chest Pain', 'Shortness of Breath', 'Abdominal Pain', 'Joint Pain',
    'Skin Rash', 'Sore Throat', 'Runny Nose', 'Muscle Pain', 'Insomnia',
  ];

  final Set<String> _selectedSymptoms = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Symptom Entry')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Describe your symptoms:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _symptomsController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'E.g., headache, fever, cough...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Or select common symptoms:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _commonSymptoms.map((symptom) {
                final isSelected = _selectedSymptoms.contains(symptom);
                return FilterChip(
                  label: Text(symptom),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedSymptoms.add(symptom);
                      } else {
                        _selectedSymptoms.remove(symptom);
                      }
                      _updateSymptomsText();
                    });
                  },
                  selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
                  checkmarkColor: Theme.of(context).primaryColor,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Urgency Level:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _urgency,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'low', child: Text('Low - Not urgent, can wait')),
                DropdownMenuItem(value: 'medium', child: Text('Medium - Should see doctor soon')),
                DropdownMenuItem(value: 'high', child: Text('High - Need immediate attention')),
              ],
              onChanged: (value) => setState(() => _urgency = value!),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isAnalyzing ? null : _analyzeSymptoms,
                child: _isAnalyzing
                  ? const CircularProgressIndicator()
                  : const Text('Analyze with AI Triage'),
              ),
            ),
            if (_aiSuggestion.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                color: _getSuggestionColor(),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'AI Triage Analysis:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _aiSuggestion,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _proceedToMatching(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Find Care Team', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateSymptomsText() {
    final selectedText = _selectedSymptoms.join(', ');
    if (_symptomsController.text.isEmpty) {
      _symptomsController.text = selectedText;
    } else if (selectedText.isNotEmpty) {
      _symptomsController.text = '$selectedText, ${_symptomsController.text}';
    }
  }

  void _analyzeSymptoms() async {
    if (_symptomsController.text.isEmpty && _selectedSymptoms.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please describe your symptoms first')),
      );
      return;
    }

    setState(() => _isAnalyzing = true);

    // Simulate AI processing delay
    await Future.delayed(const Duration(seconds: 2));

    final symptoms = _symptomsController.text.isEmpty
        ? _selectedSymptoms.join(', ')
        : _symptomsController.text;

    final suggestion = AITriage.analyzeSymptoms(symptoms, _urgency);
    setState(() {
      _aiSuggestion = suggestion;
      _isAnalyzing = false;
    });
  }

  void _proceedToMatching(BuildContext context) {
    if (_symptomsController.text.isEmpty && _selectedSymptoms.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your symptoms')),
      );
      return;
    }

    // Schedule notification reminder
    final scheduledDate = DateTime.now().add(const Duration(days: 1));
    NotificationService.scheduleConsultationReminder(
      title: 'Upcoming Consultation',
      body: 'Your consultation is scheduled for tomorrow.',
      scheduledDate: scheduledDate,
    );

    context.go('/doctor-matching');
  }

  Color _getSuggestionColor() {
    if (_aiSuggestion.contains('URGENT') || _aiSuggestion.contains('EMERGENCY')) {
      return Colors.red;
    } else if (_aiSuggestion.contains('POTENTIAL')) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  void dispose() {
    _symptomsController.dispose();
    super.dispose();
  }
}

// Import AITriage
class AITriage {
  static String analyzeSymptoms(String symptoms, String urgency) {
    final lowerSymptoms = symptoms.toLowerCase();

    if (urgency == 'high' || lowerSymptoms.contains('chest pain') || lowerSymptoms.contains('difficulty breathing')) {
      return 'URGENT: Seek immediate medical attention. This could be a medical emergency. Please call emergency services or proceed to the nearest hospital.';
    } else if (lowerSymptoms.contains('fever') && lowerSymptoms.contains('cough')) {
      return 'POTENTIAL COVID-19 SYMPTOMS: Isolate and consider testing. Book a consultation for proper assessment and guidance.';
    } else if (lowerSymptoms.contains('headache') || lowerSymptoms.contains('migraine')) {
      return 'NEUROLOGICAL SYMPTOMS: May require neurological consultation. Book an appointment for proper evaluation.';
    } else if (lowerSymptoms.contains('anxiety') || lowerSymptoms.contains('depression')) {
      return 'MENTAL HEALTH CONCERNS: Consider speaking with a mental health professional. Support is available.';
    } else if (urgency == 'medium') {
      return 'MODERATE SYMPTOMS: Should see a healthcare provider within a few days. Book a consultation for assessment.';
    } else {
      return 'GENERAL SYMPTOMS: Book a consultation for proper assessment. Stay hydrated and rest well.';
    }
  }
}
