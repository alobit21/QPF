# Space Finder (Frontend)

Space Finder is a modern application designed to help users find a quiet place for meetings, chilling, vacations, and more. 

This repository contains the well-structured Flutter frontend that connects to our NestJS backend.

## 🏗 Architecture

The application follows a **Feature-First (Domain-Driven Design)** architecture to ensure scalability, maintainability, and clear separation of concerns.

### 📦 Technology Stack
- **State Management:** [Riverpod](https://pub.dev/packages/flutter_riverpod) (with `riverpod_generator`) for safe, reactive caching and dependency injection.
- **Routing:** [GoRouter](https://pub.dev/packages/go_router) for declarative, URL-based navigation and deep linking.
- **Networking:** [Dio](https://pub.dev/packages/dio) for robust HTTP requests and interceptors.
- **Data Modeling:** [Freezed](https://pub.dev/packages/freezed) & [JSON Serializable](https://pub.dev/packages/json_serializable) for immutable data classes and robust JSON parsing.
- **Local Storage:** [Shared Preferences](https://pub.dev/packages/shared_preferences) for caching tokens and simple key-value pairs.

### 📂 Folder Structure
The codebase is structured by feature rather than layers. This keeps everything related to a specific domain in one place.

```text
lib/
 ┣ core/              # Shared elements across the entire app
 ┃ ┣ constants/       # Colors, Typography, API endpoints
 ┃ ┣ network/         # Dio HTTP client setup, Interceptors for JWT tokens
 ┃ ┣ routing/         # GoRouter configuration
 ┃ ┣ utils/           # Helper functions, formatters
 ┃ ┗ widgets/         # Reusable UI (Custom Buttons, TextFields)
 ┣ features/          # The actual app domains
 ┃ ┣ auth/            # Login, Registration, Roles Management
 ┃ ┃ ┣ data/          # API calls, Data models mapping
 ┃ ┃ ┣ domain/        # Business logic, Entities
 ┃ ┃ ┗ presentation/  # UI Screens, Widgets, Riverpod State Controllers
 ┃ ┣ spaces/          # Viewing, filtering, and discovering spaces
 ┃ ┣ bookings/        # Managing reservations for meetings, vacations, etc.
 ┃ ┗ profile/         # User settings, Admin dashboard access
 ┣ main.dart          # Entry point
 ┗ app.dart           # MaterialApp configuration
```

## 🚀 Getting Started

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Run `dart run build_runner build -d` to generate the Riverpod and Freezed files.
4. Run `flutter run` to launch the app.
