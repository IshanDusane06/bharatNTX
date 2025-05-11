# Bharat Demo App

A Flutter application that demonstrates clean architecture, state management with Riverpod, and API integration using Dio.

## Features

- Clean Architecture implementation
- State Management with Riverpod
- API Integration with Dio
- Custom Exception Handling
- Responsive UI
- Favorites functionality with persistence storage with Hive
- Article details view

## Tech Stack

- **Flutter**: ^3.0.0
- **Dart**: ^2.18.0
- **Riverpod**: ^2.0.0
- **Dio**: ^5.0.0
- **Hive**: ^2.0.4 (for local storage)
- **Go Router**: ^6.0.0 (for navigation)

## Getting Started

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

## Statemanagment and Data Flow
Riverpod is a used as stat management in this project because of it is robust state management solution for Flutter that improves upon Provider by offering better compile-time safety, testability, and flexibility. It allows you to manage and share state across your app using Providers that are decoupled from the widget tree. Riverpod supports features like auto-disposal, dependency injection, and asynchronous state with FutureProvider and StreamProvider. Its declarative and modular approach makes it ideal for scalable applications.

We have followed MVVM architechture where the service handles all the data fetching logic with help of dio package. View Model serves the middleware between UI and Data. Views basically consist of the UI part of the app.

## Screenshots

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
