# Clean restart script for Docker

Write-Host "Docker Cleanup and Restart..." -ForegroundColor Cyan
Write-Host ""

# Stop all containers
Write-Host "Stopping containers..." -ForegroundColor Yellow
docker-compose down

# Remove all containers and volumes (fresh start)
Write-Host "Removing old containers and volumes..." -ForegroundColor Yellow
docker system prune -f

# Optional: Remove images too
Write-Host "Removing Docker images..." -ForegroundColor Yellow
docker rmi test-ptimp-laravel test-ptimp-nextjs 2>$null

Write-Host ""
Write-Host "Cleanup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Now run: .\start.ps1" -ForegroundColor Cyan
