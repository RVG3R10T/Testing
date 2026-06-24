# Training Platform

A comprehensive cross-platform training management system for companies to create, manage, and assign training courses to employees.

## 🚀 Quick Start

### Prerequisites
- Node.js 16+
- Flutter 3.0+
- PostgreSQL 12+
- Docker & Docker Compose (optional)

### Development Setup

#### Using Docker Compose (Recommended)

```bash
# Start all services
docker-compose up -d

# The backend will be available at http://localhost:3000
# PostgreSQL will be available at localhost:5432
```

#### Manual Setup

**Backend:**
```bash
cd backend
npm install
cp .env.example .env
# Update .env with your configuration
npm run dev
```

**Frontend:**
```bash
cd frontend
flutter pub get
cp .env.example .env
# Update .env with your Firebase credentials
flutter run
```

## 📁 Project Structure

```
training-platform/
├── backend/          # Node.js/Express API
├── frontend/         # Flutter application
├── docs/             # Documentation
└── docker-compose.yml
```

## 🎯 Features

### Phase 1: Authentication & User Management ✅
- Firebase Authentication
- User registration and login
- Personal profiles
- Company profile linking

### Phase 2: Company & Role Management 🔄
- Company profiles
- Role-based access control (RBAC)
- Admin layers
- Permission management

### Phase 3: Course Builder
- Drag-and-drop interface
- Support for text, video, images, and links
- Module organization
- Course templates

### Phase 4: Course Assignment & Tracking
- Assign courses to users/groups
- Progress tracking
- Completion status
- Performance analytics

## 🏗️ Architecture

### Backend
- **Framework**: Express.js
- **Database**: PostgreSQL
- **Authentication**: Firebase Admin SDK
- **API**: RESTful with OpenAPI documentation

### Frontend
- **Framework**: Flutter
- **State Management**: Riverpod
- **Navigation**: GoRouter
- **Platforms**: Web, iOS, Android, macOS, Windows

## 📚 API Documentation

API endpoints are documented in the backend README. Authentication is handled via Firebase ID tokens.

**Base URL**: `http://localhost:3000/api/v1`

**Headers**:
```
Authorization: Bearer <firebase-id-token>
```

## 🔐 Security

- Firebase Authentication for secure user authentication
- Role-based access control (RBAC) for fine-grained permissions
- JWT token validation on all protected endpoints
- CORS enabled for cross-origin requests

## 📦 Deployment

### Backend Deployment

Deploy to your cloud provider (AWS, Google Cloud, Azure, etc.):

```bash
# Build Docker image
docker build -t training-platform-backend ./backend

# Push to container registry
docker push your-registry/training-platform-backend
```

### Frontend Deployment

**Web**:
```bash
flutter build web --release
# Deploy the build/web directory to your hosting provider
```

**Mobile**:
```bash
# iOS
flutter build ios --release

# Android
flutter build apk --release
```

## 🤝 Contributing

1. Create a feature branch
2. Make your changes
3. Test thoroughly
4. Submit a pull request

## 📝 License

MIT License

## 📞 Support

For issues and feature requests, please open a GitHub issue.

---

**Happy Training! 🎓**
