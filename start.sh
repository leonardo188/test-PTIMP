#!/bin/bash

echo "🐳 Starting Docker Setup..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Setup Laravel .env if it doesn't exist
if [ ! -f laravel/.env ]; then
    echo "📝 Creating Laravel .env file..."
    cp laravel/.env.example laravel/.env
fi

# Setup Next.js .env.local if it doesn't exist
if [ ! -f nextjs/.env.local ]; then
    echo "📝 Creating Next.js .env.local file..."
    cp nextjs/.env.local.example nextjs/.env.local
fi

# Build and start containers
echo "🏗️  Building Docker images (this may take a few minutes)..."
docker-compose build

echo "🚀 Starting containers..."
docker-compose up -d

# Wait for services to be healthy
echo "⏳ Waiting for services to be ready..."
sleep 10

# Generate Laravel app key if needed
echo "🔑 Generating Laravel application key..."
docker-compose exec -T laravel php artisan key:generate --force

echo ""
echo "✅ Setup complete!"
echo ""
echo "📊 Service Status:"
docker-compose ps
echo ""
echo "🌐 Access your application:"
echo "   - Frontend: http://localhost:3000"
echo "   - Backend API: http://localhost:8000/api"
echo "   - Database: localhost:3306"
echo ""
echo "📖 View logs: docker-compose logs -f"
echo "🛑 Stop services: docker-compose down"
