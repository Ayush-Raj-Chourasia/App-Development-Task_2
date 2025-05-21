import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/password_provider.dart';
import '../widgets/password_strength_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PasswordProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Password Generator'),
            actions: [
              IconButton(
                icon: Icon(provider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                onPressed: provider.toggleDarkMode,
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Password Display
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Theme.of(context).dividerColor),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          provider.password.isEmpty ? 'Your password will appear here' : provider.password,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: provider.copyToClipboard,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Password Strength Indicator
                if (provider.password.isNotEmpty)
                  PasswordStrengthIndicator(strength: provider.passwordStrength),
                const SizedBox(height: 24),

                // Length Slider
                Text(
                  'Password Length: ${provider.length}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Slider(
                  value: provider.length.toDouble(),
                  min: 8,
                  max: 32,
                  divisions: 24,
                  label: provider.length.toString(),
                  onChanged: (value) => provider.setLength(value.toInt()),
                ),
                const SizedBox(height: 16),

                // Character Type Options
                _buildOptionSwitch(
                  context,
                  'Include Uppercase Letters',
                  provider.includeUppercase,
                  (value) => provider.toggleUppercase(value),
                ),
                _buildOptionSwitch(
                  context,
                  'Include Lowercase Letters',
                  provider.includeLowercase,
                  (value) => provider.toggleLowercase(value),
                ),
                _buildOptionSwitch(
                  context,
                  'Include Numbers',
                  provider.includeNumbers,
                  (value) => provider.toggleNumbers(value),
                ),
                _buildOptionSwitch(
                  context,
                  'Include Special Characters',
                  provider.includeSpecial,
                  (value) => provider.toggleSpecial(value),
                ),
                const SizedBox(height: 24),

                // Generate Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: provider.generatePassword,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Generate Password'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionSwitch(
    BuildContext context,
    String title,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
} 