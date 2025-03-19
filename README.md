# Blog Project

## Overview

This is a Ruby on Rails application designed to function as a blog platform. It includes features for creating and managing articles, comments, likes, and user roles with authentication and authorization.

## Table of Contents

1. [Environment Setup](#environment-setup)
2. [Application Features](#application-features)
3. [Models](#models)
4. [Controllers](#controllers)
5. [API Endpoints](#api-endpoints)
6. [Routes](#routes)
7. [Database Schema](#database-schema)
8. [Contribution](#contribution)

---

## Environment Setup

To set up the environment, first you need create .env file (you can use .env.example for this)

After that, you need to build and open dev container with F1 > Rebuild Container

Next, you need to install the required gems specified in the `Gemfile`. Here's a summary of notable gems used:

### Core Gems

- **Rails**: Version 7.2
- **PostgreSQL**: Used as the database.
- **Puma**: Web server.
- **Devise**: For user authentication.
- **Pundit**: For authorization.
- **Rolify**: To manage user roles.

### Development & Testing Gems

- **RSpec**: For testing.
- **FactoryBot**: For creating test data.
- **Faker**: For generating fake data.
- **Rubocop**: Code style checker.

### Additional Gems

- **WillPaginate**: Pagination for articles.
- **RailsAdmin**: Admin panel interface.
- **JSONAPI::Serializer**: Serializer for API responses.

Install all dependencies by running:

```bash
bundle install
```

Set up the database:

```bash
rails db:create
rails db:migrate
```

---

## Application Features

- User authentication using **Devise**.
- Role management via **Rolify**.
- Authorization handled by **Pundit**.
- CRUD operations for Articles and Comments.
- Likes functionality for both Articles and Comments.
- Admin panel accessible via `/admin`.

---

## Models

### Article

- **Associations**:
  - Belongs to a `User`.
  - Has many `Comments` and `Likes`.
- **Validations**:
  - Requires `title` and `body` (minimum length: 10).
  - Status must be one of: `public`, `private`, `archived`.

### Comment

- **Associations**:
  - Belongs to a `User` and an `Article`.
  - Has many `Likes`.
- **Validations**:
  - Requires `body`.

### Like

- **Associations**:
  - Belongs to a `User` and a polymorphic `Likeable` (either an Article or a Comment).
- **Validations**:
  - Ensures uniqueness per `User` and `Likeable`.

### User

- **Associations**:
  - Has many `Articles`, `Comments`, and `Likes`.
- **Validations**:
  - Requires unique `email`.

### Role

- Manages permissions and relationships between `Users` and resources.

---

## Controllers

### ArticlesController

Handles CRUD operations for articles, including search functionality and pagination.

### CommentsController

Manages creation and deletion of comments under articles.

### LikesController

Handles liking/unliking of both articles and comments.

### UsersController

Displays user profiles and public article counts.

### API::V1::ArticlesController

Provides JSON API endpoints for listing and showing articles.

---

## API Endpoints

### Articles

- **GET /api/v1/articles**
  - Returns a list of all articles.
- **GET /api/v1/articles/:id**
  - Returns details of a specific article.

The API uses `JSONAPI::Serializer` to format responses.

Example response:

```json
{
  "data": [
    {
      "id": "1",
      "type": "article",
      "attributes": {
        "title": "Sample Title",
        "body": "Sample body text.",
        "status": "public",
        "likes": 5,
        "author": {
          "id": 1,
          "email": "user@example.com"
        },
        "comments": [
          {
            "id": 1,
            "body": "Great post!",
            "likes": 2,
            "user": {
              "id": 2,
              "email": "commenter@example.com"
            }
          }
        ]
      }
    }
  ]
}
```

---

## Routes

### Web Routes

- **Root**: Displays the list of articles (`/articles`).
- **Admin Panel**: Accessible at `/admin`.
- **User Accounts**: Managed via Devise routes (`/users/sign_up`, `/users/sign_in`, etc.).
- **Articles**: Supports nested routes for comments and likes.

### API Routes

- Namespace: `/api/v1`
- Available endpoints:
  - `GET /api/v1/articles`
  - `GET /api/v1/articles/:id`

---

## Database Schema

### Tables

- **articles**:
  - Columns: `id`, `title`, `body`, `status`, `user_id`, `created_at`, `updated_at`.

- **comments**:
  - Columns: `id`, `body`, `status`, `user_id`, `article_id`, `created_at`, `updated_at`.

- **likes**:
  - Columns: `id`, `user_id`, `likeable_type`, `likeable_id`, `created_at`, `updated_at`.

- **roles**:
  - Columns: `id`, `name`, `resource_type`, `resource_id`, `created_at`, `updated_at`.

- **users**:
  - Columns: `id`, `email`, `encrypted_password`, `created_at`, `updated_at`.

- **users_roles** (join table):
  - Columns: `user_id`, `role_id`.

---

## Contribution

We welcome contributions from the community to improve and expand the functionality of this blog application. Here’s how you can contribute:

1. **Fork the Repository**: Start by forking the project repository to your own GitHub account.

2. **Clone Locally**: Clone the forked repository to your local machine.

   ```bash
   git clone https://github.com/sakyaaa/dimas-blog.git
   cd dimas-blog
   ```

3. **Create a New Branch**: Create a new branch for your feature or bugfix.

   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Make Changes**: Implement your changes. Ensure all tests pass after your modifications:

   ```bash
   rspec
   ```

   Optionally, you can use Rubocop for ensuring that they follow the coding standards enforced.

   ```bash
   rubocop
   ```

5. **Commit and Push**: Commit your changes with clear and concise commit messages, then push them to your fork.

   ```bash
   git add . -A
   git commit -m "Add a brief description of your changes"
   git push origin feature/your-feature-name
   ```

6. **Submit a Pull Request**: Open a pull request against the `main` branch of the original repository. Provide a detailed description of the changes and their purpose.

7. **Code Review**: Participate in the code review process. Address any feedback provided by the maintainers, and make necessary adjustments.

8. **Merge**: Once your changes have been approved, they will be merged into the main branch.

### Guidelines

- **Bug Reports**: If you encounter any bugs, please open an issue detailing the problem, steps to reproduce it, and any relevant error messages.
- **Feature Requests**: For new feature suggestions, open an issue explaining the use case and why the feature would be beneficial.
- **Testing**: All contributions must include appropriate test coverage using RSpec. Ensure that existing tests continue to pass and add new tests as needed.

---

Thank you for your interest in improving this project! Your contributions help make it better for everyone.

Distributed using the MIT license
