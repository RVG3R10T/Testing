# Training Platform

A cross-platform training management system built with Flutter and Node.js that enables companies to create, manage, and assign training courses to employees.

## Features

- **Company & User Management**: Multi-tenant company profiles with role-based access control
- **Course Builder**: Drag-and-drop interface for creating courses with text, video, images, and links
- **Assignments**: Assign courses to specific users or groups with progress tracking
- **Multi-Platform**: Single codebase for Web, iOS, and Android using Flutter
- **Open API**: RESTful API for third-party integrations
- **Firebase Authentication**: Secure user authentication with role-based claims

## Project Structure

```
training-platform/
├── frontend/               # Flutter application
│   ├── lib/
│   │   ├── main.dart
│   │   ├── models/
│   │   ├── screens/
│   │   ├── widgets/
│   │   ├── services/
│   │   └── providers/
│   ├── pubspec.yaml
│   └── README.md
├── backend/               # Node.js Express API
│   ├── src/
│   │   ├── config/
│   │   ├── controllers/
│   │   ├── routes/
│   │   ├── models/
│   │   ├── middleware/
│   │   ├── utils/
│   │   └── server.js
│   ├── package.json
│   └── README.md
├── docs/                  # Documentation
├── .gitignore
└── docker-compose.yml     # Local development setup
```

## Quick Start

### Backend Setup
```bash
cd backend
npm install
npm run dev
```

### Frontend Setup
```bash
cd frontend
flutter pub get
flutter run
```

## Technology Stack

- **Frontend**: Flutter, Riverpod, HTTP
- **Backend**: Node.js, Express.js, PostgreSQL
- **Authentication**: Firebase Authentication
- **Hosting**: Traditional cloud (AWS/GCP/Azure)
- **API**: RESTful with OpenAPI documentation

## Development Roadmap

1. ✅ Project initialization
2. Authentication & User Management
3. Company Profiles & Role-Based Access
4. Course Builder with Drag-and-Drop
5. Course Assignment & Tracking
6. Deployment & API Documentation

