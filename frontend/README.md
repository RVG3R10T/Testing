# Training Platform Frontend

Flutter-based cross-platform frontend for the Training Platform application.

## Setup

### Prerequisites
- Flutter 3.0+
- Firebase project setup
- Dart 3.0+

### Installation

```bash
flutter pub get
```

### Environment Configuration

1. Copy `.env.example` to `.env`
2. Fill in your Firebase credentials

```bash
cp .env.example .env
```

### Firebase Setup

1. Create a Firebase project
2. Generate configuration files:
   - `google-services.json` for Android
   - `GoogleService-Info.plist` for iOS
3. Place them in the respective platform directories

### Running the App

```bash
# Web
flutter run -d chrome

# Android
flutter run -d android

# iOS
flutter run -d ios

# macOS
flutter run -d macos
```

## Project Structure

```
lib/
├── main.dart
├── config/
│   ├── constants.dart
│   ├── router/
│   │   └── app_router.dart
│   └── theme/
│       └── app_theme.dart
├── models/
│   ├── user.dart
│   ├── company.dart
│   ├── course.dart
│   └── assignment.dart
├── services/
│   ├── auth_service.dart
│   └── api_client.dart
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   ├── home/
│   │   └── home_screen.dart
│   ├── company/
│   │   └── company_profile_screen.dart
│   ├── courses/
│   │   ├── course_list_screen.dart
│   │   └── course_builder_screen.dart
│   └── assignments/
│       └── assignments_screen.dart
└── providers/
    └── (Riverpod providers)
```

## Key Features

- **Cross-platform**: Web, iOS, Android, macOS, Windows (single codebase)
- **State Management**: Riverpod for efficient state management
- **Navigation**: GoRouter for declarative routing
- **Authentication**: Firebase Authentication integration
- **API Integration**: Dio HTTP client with interceptors
- **Drag-and-Drop**: Course module reordering
- **Responsive UI**: Material Design 3

## Development

### Generate code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Run tests

```bash
flutter test
```

## Build

### Web

```bash
flutter build web --release
```

### Android

```bash
flutter build apk --release
```

### iOS

```bash
flutter build ios --release
```
