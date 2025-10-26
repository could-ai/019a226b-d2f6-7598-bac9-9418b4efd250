import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/ai_triage.dart';

class SymptomEntryScreen extends StatefulWidget {
  const SymptomEntryScreen({super.key});

  @override
  State<SymptomEntryScreen> createState() => _SymptomEntryScreenState();
}

class _SymptomEntryScreenState extends State<SymptomEntryScreen> {
  final _symptomsController = TextEditingController();
  String _urgency = 'low';
  String _aiSuggestion = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Symptom Entry')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Describe your symptoms:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _symptomsController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'E.g., headache, fever, cough...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Urgency Level:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _urgency,
              items: const [
                DropdownMenuItem(value: 'low', child: Text('Low')),
                DropdownMenuItem(value: 'medium', child: Text('Medium')),
                DropdownMenuItem(value: 'high', child: Text('High')),
              ],
              onChanged: (value) => setState(() => _urgency = value!),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _analyzeSymptoms,
              child: const Text('Analyze with AI Triage'),
            ),
            if (_aiSuggestion.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('AI Suggestion: $_aiSuggestion', style: const TextStyle(fontSize: 16, color: Colors.blue)),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/doctor-matching'),
              child: const Text('Find Care Team'),
            ),
          ],
        ),
      ),
    );
  }

  void _analyzeSymptoms() {
    final suggestion = AITriage.analyzeSymptoms(_symptomsController.text, _urgency);
    setState(() => _aiSuggestion = suggestion);
  }
}
