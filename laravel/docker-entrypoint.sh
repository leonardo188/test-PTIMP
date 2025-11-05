#!/bin/bash
set -e

# Wait for database to be ready
echo "Waiting for database connection..."
until php artisan db:show 2>/dev/null; do
  echo "Database is unavailable - sleeping"
  sleep 2
done

echo "Database is up - executing commands"

# Generate APP_KEY if empty (safety check)
if grep -q "APP_KEY=$" /var/www/.env; then
  echo "APP_KEY is empty, generating..."
  php artisan key:generate --force --no-interaction
fi

# Run migrations
php artisan migrate --force

# Clear and cache configuration
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Execute the main command
exec "$@"
