# PowerShell startup script for Windows

Write-Host "🐳 Starting Docker Setup..." -ForegroundColor Cyan

# Check if Docker is running
try {
    docker info | Out-Null
} catch {
    Write-Host "❌ Docker is not running. Please start Docker first." -ForegroundColor Red
    exit 1
}

# Setup Laravel .env if it doesn't exist
if (-not (Test-Path "laravel\.env")) {
    Write-Host "📝 Creating Laravel .env file..." -ForegroundColor Yellow
    Copy-Item "laravel\.env.example" "laravel\.env"
}

# Setup Next.js .env.local if it doesn't exist
if (-not (Test-Path "nextjs\.env.local")) {
    Write-Host "📝 Creating Next.js .env.local file..." -ForegroundColor Yellow
    Copy-Item "nextjs\.env.local.example" "nextjs\.env.local"
}

# Build and start containers
Write-Host "🏗️  Building Docker images (this may take a few minutes)..." -ForegroundColor Yellow
docker-compose build

Write-Host "🚀 Starting containers..." -ForegroundColor Green
docker-compose up -d

# Wait for services to be healthy
Write-Host "⏳ Waiting for services to be ready..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# Generate Laravel app key if needed
Write-Host "🔑 Generating Laravel application key..." -ForegroundColor Yellow
docker-compose exec -T laravel php artisan key:generate --force

Write-Host ""
Write-Host "✅ Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📊 Service Status:" -ForegroundColor Cyan
docker-compose ps
Write-Host ""
Write-Host "🌐 Access your application:" -ForegroundColor Cyan
Write-Host "   - Frontend: http://localhost:3000"
Write-Host "   - Backend API: http://localhost:8000/api"
Write-Host "   - Database: localhost:3306"
Write-Host ""
Write-Host "📖 View logs: docker-compose logs -f" -ForegroundColor Yellow
Write-Host "🛑 Stop services: docker-compose down" -ForegroundColor Yellow
