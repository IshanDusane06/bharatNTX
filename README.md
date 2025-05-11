# Bharat Demo App

A Flutter application that demonstrates clean architecture, state management with Riverpod, and API integration using Dio.

## Features

- Clean Architecture implementation
- State Management with Riverpod
- Search functionality
- API Integration with Dio
- Custom Exception Handling
- Responsive UI
- Pull to refresh
- Favorites screen. 
- Favorites functionality with persistence storage with **Hive**
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

## State managment and Data Flow
Riverpod is a used as stat management in this project because of it is robust state management solution for Flutter that improves upon Provider by offering better compile-time safety, testability, and flexibility. It allows you to manage and share state across your app using Providers that are decoupled from the widget tree. Riverpod supports features like auto-disposal, dependency injection, and asynchronous state with FutureProvider and StreamProvider. Its declarative and modular approach makes it ideal for scalable applications.

We have followed MVVM architechture where the service handles all the data fetching logic with help of dio package. View Model serves the middleware between UI and Data. Views basically consist of the UI part of the app.

## Know issues or Limitation
Can implement pagination for better performance.
Can implement throttling and debouncing as a optimisation

## Screenshots
<img width="150" alt="Screenshot 2025-05-11 at 5 30 47 PM" src="https://github.com/user-attachments/assets/08b4eda9-1adb-4e02-a6b6-59bc322ed4d8" />
<img width="150" alt="Screenshot 2025-05-11 at 5 31 01 PM" src="https://github.com/user-attachments/assets/47624fb7-59cf-47d4-a19b-6e48e095fe10" />
<img width="150" alt="Screenshot 2025-05-11 at 5 31 51 PM" src="https://github.com/user-attachments/assets/b2b111dd-7f04-4f8c-b8e6-e0c4e19e6164" />
<img width="150" alt="Screenshot 2025-05-11 at 5 31 14 PM" src="https://github.com/user-attachments/assets/9501fda2-6875-413f-be02-73748b26e89b" />
<img width="150" alt="Screenshot 2025-05-11 at 5 31 39 PM" src="https://github.com/user-attachments/assets/b48926fe-4208-471e-8d7d-839f2aae4134" />

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
