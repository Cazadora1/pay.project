import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userEmail;

  bool get isAuthenticated => _isAuthenticated;
  String? get userEmail => _userEmail;

  // Simulate authentication for demo purposes
  Future<bool> signIn(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Simple validation
    if (email.isEmpty || password.isEmpty) {
      return false;
    }
    
    if (password.length < 6) {
      return false;
    }

    _isAuthenticated = true;
    _userEmail = email;
    notifyListeners();
    return true;
  }

  Future<bool> register(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Simple validation
    if (email.isEmpty || password.isEmpty) {
      return false;
    }
    
    if (password.length < 6) {
      return false;
    }

    _isAuthenticated = true;
    _userEmail = email;
    notifyListeners();
    return true;
  }

  void signOut() {
    _isAuthenticated = false;
    _userEmail = null;
    notifyListeners();
  }
}