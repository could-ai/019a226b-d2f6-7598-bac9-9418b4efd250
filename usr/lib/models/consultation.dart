class Consultation {
  final String id;
  final String patientId;
  final List<String> healthcareProviderIds; // Team of professionals
  final String symptoms;
  final String? diagnosis;
  final List<String> medications;
  final DateTime scheduledDate;
  final DateTime? completedDate;
  final String status; // 'scheduled', 'in-progress', 'completed', 'cancelled'
  final double fee;
  final String currency;
  final String? paymentStatus;
  final List<String> notes; // Shared notes among team
  final double? rating;
  final String? feedback;

  Consultation({
    required this.id,
    required this.patientId,
    required this.healthcareProviderIds,
    required this.symptoms,
    required this.scheduledDate,
    required this.fee,
    required this.currency,
    this.diagnosis,
    this.medications = const [],
    this.completedDate,
    this.status = 'scheduled',
    this.paymentStatus,
    this.notes = const [],
    this.rating,
    this.feedback,
  });

  Consultation copyWith({
    String? id,
    String? patientId,
    List<String>? healthcareProviderIds,
    String? symptoms,
    String? diagnosis,
    List<String>? medications,
    DateTime? scheduledDate,
    DateTime? completedDate,
    String? status,
    double? fee,
    String? currency,
    String? paymentStatus,
    List<String>? notes,
    double? rating,
    String? feedback,
  }) {
    return Consultation(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      healthcareProviderIds: healthcareProviderIds ?? this.healthcareProviderIds,
      symptoms: symptoms ?? this.symptoms,
      diagnosis: diagnosis ?? this.diagnosis,
      medications: medications ?? this.medications,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      completedDate: completedDate ?? this.completedDate,
      status: status ?? this.status,
      fee: fee ?? this.fee,
      currency: currency ?? this.currency,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      notes: notes ?? this.notes,
      rating: rating ?? this.rating,
      feedback: feedback ?? this.feedback,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'healthcareProviderIds': healthcareProviderIds,
      'symptoms': symptoms,
      'diagnosis': diagnosis,
      'medications': medications,
      'scheduledDate': scheduledDate.toIso8601String(),
      'completedDate': completedDate?.toIso8601String(),
      'status': status,
      'fee': fee,
      'currency': currency,
      'paymentStatus': paymentStatus,
      'notes': notes,
      'rating': rating,
      'feedback': feedback,
    };
  }

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      id: json['id'],
      patientId: json['patientId'],
      healthcareProviderIds: List<String>.from(json['healthcareProviderIds']),
      symptoms: json['symptoms'],
      diagnosis: json['diagnosis'],
      medications: List<String>.from(json['medications'] ?? []),
      scheduledDate: DateTime.parse(json['scheduledDate']),
      completedDate: json['completedDate'] != null ? DateTime.parse(json['completedDate']) : null,
      status: json['status'],
      fee: json['fee'],
      currency: json['currency'],
      paymentStatus: json['paymentStatus'],
      notes: List<String>.from(json['notes'] ?? []),
      rating: json['rating'],
      feedback: json['feedback'],
    );
  }
}