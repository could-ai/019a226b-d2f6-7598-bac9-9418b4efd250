import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../providers/consultation_provider.dart';
import '../models/consultation.dart';
import 'package:provider/provider.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double _rating = 5.0;
  final _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consultation Feedback')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Rate your consultation:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Slider(
              value: _rating,
              min: 1,
              max: 5,
              divisions: 4,
              label: _rating.round().toString(),
              onChanged: (value) => setState(() => _rating = value),
            ),
            const SizedBox(height: 16),
            const Text('Additional feedback:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Share your experience...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitFeedback,
              child: const Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitFeedback() {
    final provider = Provider.of<ConsultationProvider>(context, listen: false);
    if (provider.consultations.isNotEmpty) {
      final existingConsultation = provider.consultations.first;
      final updatedConsultation = Consultation(
        id: existingConsultation.id,
        patientId: existingConsultation.patientId,
        healthcareProviderIds: existingConsultation.healthcareProviderIds,
        symptoms: existingConsultation.symptoms,
        diagnosis: existingConsultation.diagnosis,
        medications: existingConsultation.medications,
        scheduledDate: existingConsultation.scheduledDate,
        completedDate: existingConsultation.completedDate,
        status: 'completed',
        fee: existingConsultation.fee,
        currency: existingConsultation.currency,
        paymentStatus: existingConsultation.paymentStatus,
        notes: existingConsultation.notes,
        rating: _rating,
        feedback: _feedbackController.text,
      );
      provider.updateConsultation(updatedConsultation);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Thank you for your feedback!')),
    );
    context.go('/dashboard');
  }
}
