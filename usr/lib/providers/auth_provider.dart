import 'package:flutter/material.dart';
import '../models/user.dart';
import '../utils/local_storage.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isAuthenticated = false;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String email, String password) async {
    // Mock authentication - in production, this would connect to Supabase
    if (email.isNotEmpty && password.isNotEmpty) {
      _currentUser = User(
        id: '1',
        name: 'John Doe',
        email: email,
        phone: '+234123456789',
        role: 'patient',
      );
      _isAuthenticated = true;
      await LocalStorage.saveUser(_currentUser!);
      notifyListeners();
    }
  }

  Future<void> register(String name, String email, String password, String phone) async {
    // Mock registration
    _currentUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      phone: phone,
      role: 'patient',
    );
    _isAuthenticated = true;
    await LocalStorage.saveUser(_currentUser!);
      notifyListeners();
  }

  Future<void> logout() async {
    _currentUser = null;
    _isAuthenticated = false;
    await LocalStorage.clearUser();
    notifyListeners();
  }

  Future<void> loadUser() async {
    _currentUser = await LocalStorage.getUser();
    _isAuthenticated = _currentUser != null;
    notifyListeners();
  }
}
