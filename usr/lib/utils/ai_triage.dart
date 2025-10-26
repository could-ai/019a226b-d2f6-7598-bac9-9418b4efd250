class AITriage {
  static String analyzeSymptoms(String symptoms, String urgency) {
    // Simple rule-based AI triage - in production, use ML model via Supabase Edge Function
    final lowerSymptoms = symptoms.toLowerCase();
    
    if (urgency == 'high' || lowerSymptoms.contains('chest pain') || lowerSymptoms.contains('difficulty breathing')) {
      return 'URGENT: Seek immediate medical attention. This could be a medical emergency.';
    } else if (lowerSymptoms.contains('fever') && lowerSymptoms.contains('cough')) {
      return 'POTENTIAL COVID-19 SYMPTOMS: Isolate and consider testing. Book a consultation for assessment.';
    } else if (lowerSymptoms.contains('headache') || lowerSymptoms.contains('migraine')) {
      return 'NEUROLOGICAL SYMPTOMS: Recommend consultation with a general practitioner or neurologist.';
    } else if (lowerSymptoms.contains('anxiety') || lowerSymptoms.contains('depression')) {
      return 'MENTAL HEALTH CONCERNS: Consider speaking with a mental health professional.';
    } else {
      return 'GENERAL SYMPTOMS: Book a consultation for proper assessment.';
    }
  }
}
