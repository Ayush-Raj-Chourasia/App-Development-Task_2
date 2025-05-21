import 'package:flutter/material.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final double strength;

  const PasswordStrengthIndicator({
    super.key,
    required this.strength,
  });

  Color _getStrengthColor() {
    if (strength < 0.3) return Colors.red;
    if (strength < 0.6) return Colors.orange;
    if (strength < 0.8) return Colors.yellow;
    return Colors.green;
  }

  String _getStrengthText() {
    if (strength < 0.3) return 'Weak';
    if (strength < 0.6) return 'Medium';
    if (strength < 0.8) return 'Strong';
    return 'Very Strong';
  }

  IconData _getStrengthIcon() {
    if (strength < 0.3) return Icons.warning_rounded;
    if (strength < 0.6) return Icons.info_outline_rounded;
    if (strength < 0.8) return Icons.check_circle_outline_rounded;
    return Icons.verified_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final strengthColor = _getStrengthColor();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              _getStrengthIcon(),
              color: strengthColor,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Password Strength',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: strengthColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _getStrengthText(),
                style: TextStyle(
                  color: strengthColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: strength,
            backgroundColor: strengthColor.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(strengthColor),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
} 