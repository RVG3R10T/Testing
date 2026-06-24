# Training Platform Backend

Node.js/Express backend API for the Training Platform application.

## Setup

### Prerequisites
- Node.js 16+
- PostgreSQL 12+
- Firebase project setup

### Installation

```bash
npm install
```

### Environment Configuration

1. Copy `.env.example` to `.env`
2. Fill in your Firebase credentials and database URL

```bash
cp .env.example .env
```

### Database Setup

```bash
# Connect to PostgreSQL and run the schema
psql -U postgres -d training_platform -f src/models/database.schema.sql
```

### Running the Server

```bash
# Development
npm run dev

# Production
npm start
```

The server will run on `http://localhost:3000`

## API Endpoints

### Authentication
- `POST /api/v1/auth/register` - Register new user
- `POST /api/v1/auth/login` - Login user

### Users
- `GET /api/v1/users/:userId` - Get user profile
- `PUT /api/v1/users/:userId` - Update user profile

### Companies
- `POST /api/v1/companies` - Create company
- `GET /api/v1/companies/:companyId` - Get company profile
- `PUT /api/v1/companies/:companyId` - Update company profile

### Courses
- `POST /api/v1/courses` - Create course
- `GET /api/v1/courses/:courseId` - Get course details
- `POST /api/v1/courses/:courseId/modules` - Add module to course

### Assignments
- `POST /api/v1/assignments` - Assign course to user
- `GET /api/v1/assignments/user/:userId` - Get user assignments
- `PUT /api/v1/assignments/:assignmentId/progress` - Update assignment progress

## Authentication

All endpoints require Firebase ID token in Authorization header:

```
Authorization: Bearer <firebase-id-token>
```

## Role-Based Access Control

Roles in the system:
- `user` - Regular user
- `instructor` - Can create courses
- `admin` - Full company access
- `owner` - Company owner

## Testing

```bash
npm test
```

## Deployment

Deploy to your cloud provider (AWS, Google Cloud, Azure, etc.) using Docker:

```bash
docker build -t training-platform-backend .
docker run -p 3000:3000 training-platform-backend
```
