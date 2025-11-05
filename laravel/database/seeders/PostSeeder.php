<?php

namespace Database\Seeders;

use App\Models\Post;
use App\Models\User;
use Illuminate\Database\Seeder;

class PostSeeder extends Seeder
{
    public function run(): void
    {
        $users = User::all();
        
        if ($users->isEmpty()) {
            $users = User::factory()->count(3)->create();
        }

        $samplePosts = [
            [
                'title' => 'Getting Started with Laravel',
                'content' => 'Laravel is a web application framework with expressive, elegant syntax. We believe development must be an enjoyable and creative experience to be truly fulfilling.',
            ],
            [
                'title' => 'Understanding RESTful APIs',
                'content' => 'REST API is an architectural style for an application program interface that uses HTTP requests to access and use data. That data can be used to GET, PUT, POST and DELETE data types.',
            ],
            [
                'title' => 'Laravel Sanctum for API Authentication',
                'content' => 'Laravel Sanctum provides a featherweight authentication system for SPAs and simple APIs. It allows each user of your application to generate multiple API tokens for their account.',
            ],
            [
                'title' => 'Database Migrations in Laravel',
                'content' => 'Migrations are like version control for your database, allowing your team to define and share the application\'s database schema definition.',
            ],
            [
                'title' => 'Eloquent ORM Best Practices',
                'content' => 'Eloquent is an object relational mapper (ORM) that makes it enjoyable to interact with your database. When using Eloquent, each database table has a corresponding Model.',
            ],
        ];

        foreach ($samplePosts as $postData) {
            Post::create([
                'user_id' => $users->random()->id,
                'title' => $postData['title'],
                'content' => $postData['content'],
            ]);
        }
    }
}
