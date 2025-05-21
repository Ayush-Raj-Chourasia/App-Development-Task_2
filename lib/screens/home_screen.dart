import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/password_provider.dart';
import '../widgets/password_strength_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Consumer<PasswordProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Password Generator',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(
                  provider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  size: 28,
                ),
                onPressed: provider.toggleDarkMode,
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 16.0 : size.width * 0.1,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Password Display Card
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary.withOpacity(0.1),
                              Theme.of(context).colorScheme.primary.withOpacity(0.05),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Generated Password',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    provider.password.isEmpty 
                                        ? 'Your password will appear here' 
                                        : provider.password,
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      letterSpacing: 1.2,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.copy_rounded),
                                  onPressed: provider.copyToClipboard,
                                  tooltip: 'Copy to clipboard',
                                  style: IconButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                    padding: const EdgeInsets.all(12),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Password Strength Indicator
                    if (provider.password.isNotEmpty) ...[
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: PasswordStrengthIndicator(strength: provider.passwordStrength),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],

                    // Length Slider Card
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Password Length',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${provider.length}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Theme.of(context).colorScheme.primary,
                                inactiveTrackColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                thumbColor: Theme.of(context).colorScheme.primary,
                                overlayColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                valueIndicatorColor: Theme.of(context).colorScheme.primary,
                                valueIndicatorTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: Slider(
                                value: provider.length.toDouble(),
                                min: 8,
                                max: 32,
                                divisions: 24,
                                label: provider.length.toString(),
                                onChanged: (value) => provider.setLength(value.toInt()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Character Options Card
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Character Options',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
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
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Generate Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: provider.generatePassword,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          'Generate Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.primary,
      contentPadding: EdgeInsets.zero,
    );
  }
} 