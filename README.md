# Bharat Demo App

A Flutter application that demonstrates clean architecture, state management with Riverpod, and API integration using Dio.

## Features

- Clean Architecture implementation
- State Management with Riverpod
- API Integration with Dio
- Custom Exception Handling
- Responsive UI
- Favorites functionality
- Article details view

## Tech Stack

- **Flutter**: ^3.0.0
- **Dart**: ^2.18.0
- **Riverpod**: ^2.0.0
- **Dio**: ^5.0.0
- **Hive**: ^2.0.4 (for local storage)
- **Go Router**: ^6.0.0 (for navigation)

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (comes with Flutter)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/bharat_demo.git
   cd bharat_demo
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   ├── exceptions/
│   └── utils/
├── models/
├── providers/
├── repositories/
├── services/
└── views/
    ├── article_detail_screen.dart
    ├── favorites_screen.dart
    └── home_screen.dart
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
