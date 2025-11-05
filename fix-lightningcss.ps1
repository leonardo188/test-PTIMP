# PowerShell script to fix lightningcss issues

Write-Host "Fixing lightningcss issue..." -ForegroundColor Cyan
Write-Host ""

# Check if Docker is running
try {
    docker info | Out-Null
} catch {
    Write-Host "ERROR: Docker is not running. Please start Docker Desktop first." -ForegroundColor Red
    exit 1
}

Write-Host "OK: Docker is running" -ForegroundColor Green
Write-Host ""

# Stop containers
Write-Host "Stopping containers..." -ForegroundColor Yellow
docker-compose down

# Remove Next.js image to force rebuild
Write-Host "Removing old Next.js image..." -ForegroundColor Yellow
docker rmi test-ptimp-nextjs -f 2>$null

# Rebuild without cache (important for installing build dependencies)
Write-Host "Rebuilding Next.js with build tools (this may take 5-10 minutes)..." -ForegroundColor Yellow
Write-Host "    Installing: python3, make, g++, libc6-compat" -ForegroundColor Gray
docker-compose build --no-cache nextjs

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: Build failed! Check the errors above." -ForegroundColor Red
    Write-Host "Try running: docker-compose build nextjs" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "OK: Build successful!" -ForegroundColor Green
Write-Host ""

# Start all services
Write-Host "Starting all services..." -ForegroundColor Green
docker-compose up -d

# Wait for services to be ready
Write-Host "Waiting for services to start (30 seconds)..." -ForegroundColor Yellow
Start-Sleep -Seconds 30

# Check status
Write-Host ""
Write-Host "Service Status:" -ForegroundColor Cyan
docker-compose ps

Write-Host ""
Write-Host "Next.js Logs (last 30 lines):" -ForegroundColor Cyan
docker-compose logs --tail=30 nextjs

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Fix applied!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Access your application:" -ForegroundColor White
Write-Host "   Frontend: http://localhost:3000" -ForegroundColor Cyan
Write-Host "   Backend:  http://localhost:8000/api" -ForegroundColor Cyan
Write-Host ""
Write-Host "Commands:" -ForegroundColor White
Write-Host "   View logs:    docker-compose logs -f nextjs" -ForegroundColor Gray
Write-Host "   Stop:         docker-compose down" -ForegroundColor Gray
Write-Host "   Restart:      docker-compose restart nextjs" -ForegroundColor Gray
Write-Host ""

# Check if Next.js is running properly
Write-Host "Checking if Next.js started successfully..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

$logs = docker-compose logs nextjs 2>&1 | Select-String -Pattern "Ready in|Error|Cannot find module"

if ($logs -match "Ready in") {
    Write-Host "OK: Next.js is running successfully!" -ForegroundColor Green
} elseif ($logs -match "Error|Cannot find module") {
    Write-Host "WARNING: There might be errors. Check logs with:" -ForegroundColor Yellow
    Write-Host "   docker-compose logs -f nextjs" -ForegroundColor Gray
} else {
    Write-Host "INFO: Next.js is still starting. Check logs in a moment." -ForegroundColor Yellow
}

Write-Host ""
