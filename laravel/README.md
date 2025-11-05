# Laravel Blog API

A clean and well-structured RESTful API built with Laravel 12 for managing blog posts with authentication.

## 🚀 Features

- **Authentication** - User registration and login with Laravel Sanctum
- **CRUD Operations** - Complete Create, Read, Update, Delete for blog posts
- **Authorization** - Users can only modify their own posts
- **Flexible Pagination** - Customizable items per page (1-100) with validation
- **Validation** - Comprehensive input validation with custom error messages
- **Specific Error Messages** - Clear, actionable error messages in Indonesian
- **Seeding** - Sample data for testing
- **API Documentation** - Complete documentation with examples

## 📋 Requirements

- PHP >= 8.2
- Composer
- MySQL/PostgreSQL/SQLite
- Laravel 12

## 🛠️ Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd laravel
   ```

2. **Install dependencies**
   ```bash
   composer install
   ```

3. **Setup environment**
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

4. **Configure database**
   
   Edit `.env` file and set your database credentials:
   ```env
   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=your_database_name
   DB_USERNAME=your_username
   DB_PASSWORD=your_password
   ```

5. **Run migrations**
   ```bash
   php artisan migrate
   ```

6. **Seed database (optional)**
   ```bash
   php artisan db:seed
   ```
   This will create 6 users and 5 sample posts.

7. **Start the server**
   ```bash
   php artisan serve
   ```
   API will be available at `http://localhost:8000`

## 📚 API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login and get token
- `POST /api/auth/logout` - Logout (requires auth)

### Posts
- `GET /api/posts` - Get all posts (paginated, customizable)
  - Query params: `?page=1&per_page=25` (per_page: 1-100, default: 10)
- `GET /api/posts/{id}` - Get single post
- `POST /api/posts` - Create post (requires auth)
- `PUT /api/posts/{id}` - Update post (requires auth & ownership)
- `DELETE /api/posts/{id}` - Delete post (requires auth & ownership)

**Documentation:**
- [ERROR_HANDLING.md](./ERROR_HANDLING.md) - Error codes and messages guide

## 🧪 Testing

You can test the API using:
- **Postman** - Import the endpoints
- **cURL** - See examples in API documentation
- **PHPUnit** - Run `php artisan test`

## 📁 Project Structure

```
laravel/
├── app/
│   ├── Http/
│   │   └── Controllers/
│   │       ├── Api/
│   │       │   └── PostController.php    # Post CRUD operations
│   │       └── Auth/                     # Authentication controllers
│   └── Models/
│       ├── Post.php                      # Post model
│       └── User.php                      # User model
├── database/
│   ├── migrations/                       # Database migrations
│   └── seeders/                          # Database seeders
├── routes/
│   ├── api.php                           # API routes
│   └── auth.php                          # Auth routes
├── API_DOCUMENTATION.md                  # Detailed API docs
├── PAGINATION_GUIDE.md                   # Pagination guide
└── postman_collection.json               # Postman collection
```

## 🔑 Key Improvements Made

✅ **Model Post** - Added fillable fields, proper casting, and HasFactory trait  
✅ **Model User** - Added HasApiTokens trait for Sanctum  
✅ **PostController** - Fully implemented all CRUD methods with validation  
✅ **Flexible Pagination** - Customizable per_page (1-100) with validation  
✅ **Specific Error Messages** - Clear error messages for register/login scenarios  
✅ **Authentication** - Returns Sanctum tokens on login/register  
✅ **Routes** - Organized with prefixes and middleware groups  
✅ **Migration** - Added proper columns (title, content, user_id, foreign keys)  
✅ **Seeder** - Added sample data for testing  
✅ **Response Format** - Consistent JSON responses with success/message/data  
✅ **Authorization** - Users can only modify their own posts  

## 📝 Sample Usage

**1. Register a user:**
```bash
curl -X POST http://localhost:8000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"John","email":"john@test.com","password":"password123","password_confirmation":"password123"}'
```

**2. Login:**
```bash
curl -X POST http://localhost:8000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"john@test.com","password":"password123"}'
```

**3. Get posts with pagination:**
```bash
# Default (10 items per page)
curl http://localhost:8000/api/posts

# Custom pagination (25 items per page)
curl "http://localhost:8000/api/posts?per_page=25"

# Specific page
curl "http://localhost:8000/api/posts?page=2&per_page=20"
```

**4. Create a post (use token from login):**
```bash
curl -X POST http://localhost:8000/api/posts \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{"title":"My First Post","content":"This is my first blog post!"}'
```

## 🤝 Contributing

Feel free to submit issues and enhancement requests.

## 📄 License

This project is open-sourced software licensed under the MIT license.
