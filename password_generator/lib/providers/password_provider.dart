import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/password_generator.dart';

class PasswordProvider with ChangeNotifier {
  String _password = '';
  int _length = 16;
  bool _includeUppercase = true;
  bool _includeLowercase = true;
  bool _includeNumbers = true;
  bool _includeSpecial = true;
  bool _isDarkMode = false;

  String get password => _password;
  int get length => _length;
  bool get includeUppercase => _includeUppercase;
  bool get includeLowercase => _includeLowercase;
  bool get includeNumbers => _includeNumbers;
  bool get includeSpecial => _includeSpecial;
  bool get isDarkMode => _isDarkMode;
  double get passwordStrength => PasswordGenerator.calculatePasswordStrength(_password);

  void setLength(int value) {
    _length = value;
    notifyListeners();
  }

  void toggleUppercase(bool value) {
    _includeUppercase = value;
    notifyListeners();
  }

  void toggleLowercase(bool value) {
    _includeLowercase = value;
    notifyListeners();
  }

  void toggleNumbers(bool value) {
    _includeNumbers = value;
    notifyListeners();
  }

  void toggleSpecial(bool value) {
    _includeSpecial = value;
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void generatePassword() {
    try {
      _password = PasswordGenerator.generatePassword(
        length: _length,
        includeUppercase: _includeUppercase,
        includeLowercase: _includeLowercase,
        includeNumbers: _includeNumbers,
        includeSpecial: _includeSpecial,
      );
      notifyListeners();
    } catch (e) {
      _password = 'Select at least one option';
      notifyListeners();
    }
  }

  Future<void> copyToClipboard() async {
    if (_password.isNotEmpty && _password != 'Select at least one option') {
      await Clipboard.setData(ClipboardData(text: _password));
    }
  }
} 