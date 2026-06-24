# Training Platform - Setup Guide

This guide will help you set up both the Firebase configuration and environment variables needed to run the application.

## Prerequisites

- Node.js 16+
- Flutter 3.0+
- PostgreSQL 12+
- Firebase Project (create at [https://console.firebase.google.com](https://console.firebase.google.com))
- Docker & Docker Compose (optional, but recommended)

---

## Step 1: Create Firebase Project

### 1.1 Create a new Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Click **"Create a project"**
3. Enter project name (e.g., "training-platform")
4. Accept terms and click **"Create project"**
5. Wait for project to be created

### 1.2 Enable Firebase Authentication

1. In Firebase Console, go to **Authentication** > **Sign-in method**
2. Enable **Email/Password** provider
3. Click **Save**

### 1.3 Get Firebase Web Configuration

1. In Firebase Console, go to **Project Settings** (gear icon)
2. Select **"Your apps"** section
3. Click on the web app icon (or create new if needed)
4. Copy the configuration object
5. You'll see something like:

```javascript
const firebaseConfig = {
  apiKey: "AIza...",
  authDomain: "your-project-id.firebaseapp.com",
  projectId: "your-project-id",
  storageBucket: "your-project-id.appspot.com",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abcd1234"
};
```

---

## Step 2: Configure Frontend

### 2.1 Update firebase_options.dart

1. Open `frontend/lib/firebase_options.dart`
2. Replace the placeholders with your Firebase Web config:

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'AIza...',  // from apiKey
  appId: '1:123456789:web:abcd1234',  // from appId
  messagingSenderId: '123456789',  // from messagingSenderId
  projectId: 'your-project-id',  // from projectId
  authDomain: 'your-project-id.firebaseapp.com',  // from authDomain
  databaseURL: 'https://your-project-id.firebaseio.com',
  storageBucket: 'your-project-id.appspot.com',  // from storageBucket
);
```

### 2.2 Create .env file for Frontend

1. Copy `.env.example` to `.env`:
   ```bash
   cd frontend
   cp .env.example .env
   ```

2. Update the values in `.env`:
   ```
   FIREBASE_API_KEY=AIza...
   FIREBASE_AUTH_DOMAIN=your-project-id.firebaseapp.com
   FIREBASE_PROJECT_ID=your-project-id
   FIREBASE_STORAGE_BUCKET=your-project-id.appspot.com
   FIREBASE_MESSAGING_SENDER_ID=123456789
   FIREBASE_APP_ID=1:123456789:web:abcd1234
   FIREBASE_DATABASE_URL=https://your-project-id.firebaseio.com
   
   API_BASE_URL=http://localhost:3000
   API_VERSION=v1
   ```

---

## Step 3: Configure Backend

### 3.1 Get Firebase Service Account Key

1. In Firebase Console, go to **Project Settings** (gear icon)
2. Click on **Service Accounts** tab
3. Click **"Generate New Private Key"**
4. A JSON file will download - **save this securely**
5. Open the JSON file and copy the entire contents

The JSON will look like:
```json
{
  "type": "service_account",
  "project_id": "your-project-id",
  "private_key_id": "key_id_here",
  "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-xxxx@your-project-id.iam.gserviceaccount.com",
  "client_id": "123456789",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/..."
}
```

### 3.2 Create .env file for Backend

1. Copy `.env.example` to `.env`:
   ```bash
   cd backend
   cp .env.example .env
   ```

2. Update the values in `.env` with your service account JSON:
   ```
   DATABASE_URL=postgresql://training_user:training_password@localhost:5432/training_platform
   
   FIREBASE_PROJECT_ID=your-project-id
   FIREBASE_PRIVATE_KEY_ID=key_id_here
   FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nMII...\n-----END PRIVATE KEY-----\n"
   FIREBASE_CLIENT_EMAIL=firebase-adminsdk-xxxx@your-project-id.iam.gserviceaccount.com
   FIREBASE_CLIENT_ID=123456789
   FIREBASE_AUTH_URI=https://accounts.google.com/o/oauth2/auth
   FIREBASE_TOKEN_URI=https://oauth2.googleapis.com/token
   FIREBASE_AUTH_PROVIDER_X509_CERT_URL=https://www.googleapis.com/oauth2/v1/certs
   FIREBASE_CLIENT_X509_CERT_URL=https://www.googleapis.com/robot/v1/metadata/x509/...
   
   PORT=3000
   NODE_ENV=development
   JWT_SECRET=your-super-secret-key
   API_BASE_URL=http://localhost:3000
   CORS_ORIGIN=http://localhost:*
   ```

**⚠️ IMPORTANT**: When adding the private key, ensure it's properly escaped:
- Replace actual newlines with `\n`
- Wrap the entire value in double quotes
- Or use multiline format (the server will handle it)

### 3.3 Example .env File

Here's a complete example:

```bash
# Database
DATABASE_URL=postgresql://training_user:training_password@postgres:5432/training_platform

# Firebase Admin
FIREBASE_PROJECT_ID=training-platform-prod
FIREBASE_PRIVATE_KEY_ID=abc123def456
FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDU...\n-----END PRIVATE KEY-----\n"
FIREBASE_CLIENT_EMAIL=firebase-adminsdk-ab123@training-platform-prod.iam.gserviceaccount.com
FIREBASE_CLIENT_ID=112233445566
FIREBASE_AUTH_URI=https://accounts.google.com/o/oauth2/auth
FIREBASE_TOKEN_URI=https://oauth2.googleapis.com/token
FIREBASE_AUTH_PROVIDER_X509_CERT_URL=https://www.googleapis.com/oauth2/v1/certs
FIREBASE_CLIENT_X509_CERT_URL=https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-ab123%40training-platform-prod.iam.gserviceaccount.com

# Server
PORT=3000
NODE_ENV=development
JWT_SECRET=super-secret-key-change-in-production
API_BASE_URL=http://localhost:3000
CORS_ORIGIN=http://localhost:*
```

---

## Step 4: Run the Application

### Option A: Using Docker Compose (Recommended)

```bash
# Start all services
docker-compose up -d

# Check logs
docker-compose logs -f

# Stop services
docker-compose down
```

The backend will be available at: `http://localhost:3000`

### Option B: Manual Setup

**Terminal 1 - Database:**
```bash
# Start PostgreSQL (if not already running)
# macOS with Homebrew
brew services start postgresql

# Or use Docker
docker run --name training-db -e POSTGRES_PASSWORD=training_password -p 5432:5432 postgres:15-alpine
```

**Terminal 2 - Backend:**
```bash
cd backend
npm install
npm run dev
```

**Terminal 3 - Frontend:**
```bash
cd frontend
flutter pub get
flutter run -d chrome
```

---

## Step 5: Test the Setup

### Test Backend API

```bash
# Health check
curl http://localhost:3000/health

# Response should be:
# {"status":"OK","timestamp":"2024-01-01T12:00:00.000Z"}
```

### Test Frontend

1. Open `http://localhost:5173` (or the port shown in Flutter)
2. Click **"Sign up"**
3. Create an account with test email
4. You should be redirected to home page
5. Click menu → Profile to view your profile

---

## Troubleshooting

### Firebase Configuration Issues

**Problem**: "Firebase app initialization failed"
- **Solution**: Check that all Firebase config values in `firebase_options.dart` are correct

**Problem**: "CORS error when calling API"
- **Solution**: Ensure `CORS_ORIGIN` in backend `.env` matches your frontend URL

### Database Connection Issues

**Problem**: "Connection refused" error
- **Solution**: Ensure PostgreSQL is running and `DATABASE_URL` is correct
- Test connection: `psql postgresql://training_user:training_password@localhost:5432/training_platform`

**Problem**: "Tables don't exist"
- **Solution**: Run the database schema:
  ```bash
  psql -U training_user -d training_platform -f backend/src/models/database.schema.sql
  ```

### Frontend Issues

**Problem**: "Flutter cannot find dependencies"
- **Solution**: Run `flutter pub get` again

**Problem**: "Hot reload not working"
- **Solution**: Try `flutter clean` and `flutter pub get`

---

## Security Notes

⚠️ **Never commit `.env` files to Git!** They're already in `.gitignore`

1. Keep Firebase service account key secure
2. Use strong JWT_SECRET in production
3. Rotate secrets regularly
4. Use environment-specific configs for prod/staging/dev

---

## Next Steps

1. ✅ Configure Firebase and environment variables
2. ✅ Run backend: `docker-compose up`
3. ✅ Run frontend: `flutter run -d chrome`
4. ✅ Test registration and login
5. 📝 Build drag-and-drop course builder
6. 📝 Add company management and RBAC
7. 📝 Add progress tracking UI

---

For more help, check:
- [Firebase Documentation](https://firebase.google.com/docs)
- [Flutter Documentation](https://flutter.dev/docs)
- [Express.js Documentation](https://expressjs.com/)
