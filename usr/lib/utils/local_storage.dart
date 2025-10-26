import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/consultation.dart';

class LocalStorage {
  static const String _userKey = 'user';
  static const String _consultationsKey = 'consultations';

  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  static Future<void> saveConsultations(List<Consultation> consultations) async {
    final prefs = await SharedPreferences.getInstance();
    final consultationsJson = jsonEncode(consultations.map((c) => c.toJson()).toList());
    await prefs.setString(_consultationsKey, consultationsJson);
  }

  static Future<List<Consultation>> getConsultations() async {
    final prefs = await SharedPreferences.getInstance();
    final consultationsJson = prefs.getString(_consultationsKey);
    if (consultationsJson != null) {
      final List<dynamic> decoded = jsonDecode(consultationsJson);
      return decoded.map((c) => Consultation.fromJson(c)).toList();
    }
    return [];
  }
}
