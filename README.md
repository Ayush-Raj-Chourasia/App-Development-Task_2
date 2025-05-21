# Password Generator

A secure and customizable password generator app built with Flutter that helps users maintain better password hygiene.

## Features

- 🔐 Generate secure passwords with customizable options
- 📏 Adjustable password length (8-32 characters)
- ⚙️ Customizable character types:
  - Uppercase letters (A-Z)
  - Lowercase letters (a-z)
  - Numbers (0-9)
  - Special characters (!@#$%^&*()_+-=[]{}|;:,.<>?)
- 📋 One-tap copy to clipboard
- 📊 Password strength indicator
- 🌓 Dark mode support
- 📱 Responsive design for all screen sizes

## Screenshots

[Add screenshots here]

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Android Studio / VS Code
- Android SDK (API level 21 or higher)

### Installation

1. Clone the repository:
```bash
git clone [repository-url]
cd password_generator
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Building Release APK

To build a release APK:

```bash
flutter build apk --release
```

The APK will be generated at:
```
build/app/outputs/flutter-apk/app-release.apk
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── providers/
│   └── password_provider.dart # State management
├── screens/
│   └── home_screen.dart      # Main UI screen
├── services/
│   └── password_generator.dart # Password generation logic
└── widgets/
    └── password_strength_indicator.dart # Password strength UI
```

## Dependencies

- Flutter SDK
- provider: ^6.0.5 (State management)
- shared_preferences: ^2.2.0 (Local storage)

## Features in Detail

### Password Generation
- Secure random password generation
- Configurable length (8-32 characters)
- Multiple character type options
- Real-time password strength calculation

### User Interface
- Clean Material Design 3 UI
- Responsive layout
- Dark mode support
- Password strength visualization
- Easy copy-to-clipboard functionality

### Security
- Uses secure random number generation
- No data storage or transmission
- Local-only password generation

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Flutter team for the amazing framework
- Material Design team for the design guidelines
