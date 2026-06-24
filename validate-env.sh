#!/bin/bash

# Training Platform - Environment Setup Validation
# This script validates that all environment variables are properly configured

set -e

echo "===================================="
echo "Environment Validation Script"
echo "===================================="
echo ""

# Check frontend .env
echo "Checking frontend configuration..."
if [ ! -f "frontend/.env" ]; then
    echo "❌ frontend/.env not found"
    exit 1
fi

echo "✅ frontend/.env exists"

# Check required frontend vars
FRONTEND_REQUIRED=("FIREBASE_PROJECT_ID" "FIREBASE_API_KEY" "FIREBASE_APP_ID" "API_BASE_URL")
for var in "${FRONTEND_REQUIRED[@]}"; do
    if ! grep -q "$var" frontend/.env; then
        echo "❌ Missing $var in frontend/.env"
    else
        echo "✅ $var configured"
    fi
done

echo ""

# Check backend .env
echo "Checking backend configuration..."
if [ ! -f "backend/.env" ]; then
    echo "❌ backend/.env not found"
    exit 1
fi

echo "✅ backend/.env exists"

# Check required backend vars
BACKEND_REQUIRED=("DATABASE_URL" "FIREBASE_PROJECT_ID" "FIREBASE_PRIVATE_KEY" "PORT")
for var in "${BACKEND_REQUIRED[@]}"; do
    if ! grep -q "$var" backend/.env; then
        echo "❌ Missing $var in backend/.env"
    else
        echo "✅ $var configured"
    fi
done

echo ""
echo "===================================="
echo "✅ Validation Complete!"
echo "===================================="
