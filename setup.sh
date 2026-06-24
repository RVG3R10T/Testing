#!/bin/bash

# Training Platform - Quick Setup Script
# This script helps set up the Firebase configuration and environment variables

set -e

echo "===================================="
echo "Training Platform Setup Script"
echo "===================================="
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 16+ first."
    exit 1
fi

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    exit 1
fi

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "⚠️  Docker is not installed. You'll need to set up PostgreSQL manually."
fi

echo "✅ Prerequisites check passed"
echo ""

# Frontend setup
echo "Setting up Frontend..."
if [ ! -f "frontend/.env" ]; then
    echo "Creating frontend/.env file..."
    cp frontend/.env.example frontend/.env
    echo "📝 Please edit frontend/.env with your Firebase configuration"
else
    echo "✅ frontend/.env already exists"
fi

echo ""

# Backend setup
echo "Setting up Backend..."
if [ ! -f "backend/.env" ]; then
    echo "Creating backend/.env file..."
    cp backend/.env.example backend/.env
    echo "📝 Please edit backend/.env with your Firebase service account"
else
    echo "✅ backend/.env already exists"
fi

echo ""

# Install dependencies
echo "Installing dependencies..."
echo "Installing backend dependencies..."
cd backend && npm install && cd ..
echo "✅ Backend dependencies installed"

echo ""
echo "Installing frontend dependencies..."
cd frontend && flutter pub get && cd ..
echo "✅ Frontend dependencies installed"

echo ""
echo "===================================="
echo "✅ Setup Complete!"
echo "===================================="
echo ""
echo "📋 Next steps:"
echo "1. Edit frontend/.env with your Firebase config"
echo "2. Edit backend/.env with your Firebase service account"
echo "3. Run: docker-compose up (or start PostgreSQL manually)"
echo "4. Run: cd frontend && flutter run -d chrome"
echo ""
echo "For detailed setup instructions, see SETUP_GUIDE.md"
