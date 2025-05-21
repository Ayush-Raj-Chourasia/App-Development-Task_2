import 'dart:math';

class PasswordGenerator {
  static const String _lowercase = 'abcdefghijklmnopqrstuvwxyz';
  static const String _uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const String _numbers = '0123456789';
  static const String _special = '!@#\$%^&*()_+-=[]{}|;:,.<>?';

  static String generatePassword({
    required int length,
    required bool includeUppercase,
    required bool includeLowercase,
    required bool includeNumbers,
    required bool includeSpecial,
  }) {
    if (!includeUppercase && !includeLowercase && !includeNumbers && !includeSpecial) {
      throw Exception('At least one character type must be selected');
    }

    String chars = '';
    if (includeUppercase) chars += _uppercase;
    if (includeLowercase) chars += _lowercase;
    if (includeNumbers) chars += _numbers;
    if (includeSpecial) chars += _special;

    final random = Random.secure();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  static double calculatePasswordStrength(String password) {
    double strength = 0.0;
    
    // Length contribution (up to 40% of total strength)
    strength += (password.length / 32) * 0.4;
    
    // Character type contribution (60% of total strength)
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.15;
    if (password.contains(RegExp(r'[a-z]'))) strength += 0.15;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.15;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.15;
    
    return strength.clamp(0.0, 1.0);
  }
} 