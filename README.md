# 📱 Blog App - Laravel + Next.js

A full-stack blog application with Laravel backend API and Next.js frontend, running in Docker containers.

## 🏗️ Tech Stack

### Backend
- **Framework:** Laravel 12
- **Language:** PHP 8.2
- **Database:** MySQL 8.0
- **Authentication:** Sanctum
- **API:** RESTful

### Frontend
- **Framework:** Next.js 16
- **Language:** TypeScript/JavaScript
- **Styling:** Tailwind CSS 4 + DaisyUI
- **State Management:** Zustand
- **HTTP Client:** Axios

### DevOps
- **Containerization:** Docker
- **Orchestration:** Docker Compose
- **Build:** Multi-stage builds

---

## 🚀 Quick Start

### Option 1: Automated Setup (Recommended)
```powershell
.\start.ps1
```

### Option 2: Manual Setup
```powershell
docker-compose build
docker-compose up -d
docker-compose exec laravel php artisan key:generate
```

Then access:
- **Frontend:** http://localhost:3000
- **Backend API:** http://localhost:8000/api

---

## 🌐 Services & Ports

| Service | Port | URL |
|---------|------|-----|
| Next.js Frontend | 3000 | http://localhost:3000 |
| Laravel Backend | 8000 | http://localhost:8000 |
| MySQL Database | 3306 | localhost:3306 |

---

## 🔐 Default Credentials

### Database
- **Host:** `db` (Docker) / `localhost` (Local)
- **Port:** 3306
- **Database:** blog_db
- **Username:** blog_user
- **Password:** blog_pass

---

## 📁 Project Structure

```
test-PTIMP/
├── laravel/              # Backend API (PHP 8.2)
├── nextjs/               # Frontend (Next.js 16)
├── docker-compose.yml    # Services orchestration
├── start.ps1             # Auto setup script
└── fix-lightningcss.ps1  # Lightningcss fix script
```

---

## 🔄 Common Commands

```powershell
# Start services
docker-compose up -d

# Stop services
docker-compose down

# Check status
docker-compose ps

# View logs
docker-compose logs -f

# Run Laravel commands
docker-compose exec laravel php artisan [command]

# Database operations
docker-compose exec db mysql -u blog_user -pblog_pass blog_db
```