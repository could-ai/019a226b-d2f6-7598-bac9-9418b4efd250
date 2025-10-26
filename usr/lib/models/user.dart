class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role; // 'patient', 'doctor', 'pharmacist', 'admin'
  final String? specialty;
  final String? licenseNumber;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? address;
  final String? profileImage;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.specialty,
    this.licenseNumber,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'specialty': specialty,
      'licenseNumber': licenseNumber,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'address': address,
      'profileImage': profileImage,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      specialty: json['specialty'],
      licenseNumber: json['licenseNumber'],
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : null,
      gender: json['gender'],
      address: json['address'],
      profileImage: json['profileImage'],
    );
  }
}
