import 'package:flutter/material.dart';
import '../models/consultation.dart';
import '../utils/local_storage.dart';

class ConsultationProvider with ChangeNotifier {
  List<Consultation> _consultations = [];

  List<Consultation> get consultations => _consultations;

  Future<void> loadConsultations(String patientId) async {
    // Mock loading consultations - in production, fetch from Supabase
    _consultations = [
      Consultation(
        id: '1',
        patientId: patientId,
        healthcareProviderIds: ['doc1', 'pharm1'],
        symptoms: 'Headache and fever',
        scheduledDate: DateTime.now().add(const Duration(days: 1)),
        fee: 3000,
        currency: 'NGN',
        status: 'scheduled',
      ),
    ];
    await LocalStorage.saveConsultations(_consultations);
    notifyListeners();
  }

  Future<void> addConsultation(Consultation consultation) async {
    _consultations.add(consultation);
    await LocalStorage.saveConsultations(_consultations);
    notifyListeners();
  }

  Future<void> updateConsultation(Consultation updatedConsultation) async {
    final index = _consultations.indexWhere((c) => c.id == updatedConsultation.id);
    if (index != -1) {
      _consultations[index] = updatedConsultation;
      await LocalStorage.saveConsultations(_consultations);
      notifyListeners();
    }
  }

  void loadFromStorage() async {
    _consultations = await LocalStorage.getConsultations();
    notifyListeners();
  }
}
