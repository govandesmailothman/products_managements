# Product Management System (Laravel + Flutter)

A professional, full-stack Product Management application built as a technical coding assessment. The system consists of a robust Laravel REST API backend with MySQL support and a clean, responsive Flutter mobile client following Clean Architecture and Provider state management.

---

## Table of Contents

- [1. Project Overview](#1-project-overview)
- [2. Technologies Used](#2-technologies-used)
- [3. Project Folder Structure](#3-project-folder-structure)
- [4. Requirements & Prerequisites](#4-requirements--prerequisites)
- [5. Laravel Backend Setup](#5-laravel-backend-setup)
- [6. MySQL Database Setup](#6-mysql-database-setup)
- [7. Migrations & Seeding](#7-migrations--seeding)
- [8. Starting the Laravel Server](#8-starting-the-laravel-server)
- [9. Flutter Mobile App Setup](#9-flutter-mobile-app-setup)
- [10. Configuring the API Base URL](#10-configuring-the-api-base-url)
- [11. Running the Flutter App](#11-running-the-flutter-app)
- [12. API Endpoint Documentation](#12-api-endpoint-documentation)
- [13. Example JSON Requests and Responses](#13-example-json-requests-and-responses)
- [14. Architecture & Technical Decisions](#14-architecture--technical-decisions)
- [15. Testing & Code Quality](#15-testing--code-quality)
- [16. Security Best Practices](#16-security-best-practices)
- [17. Screenshots & UI Mockups](#17-screenshots--ui-mockups)

---

## 1. Project Overview

The **Product Management Application** provides a streamlined catalog management experience:
- **Backend**: Built with Laravel 11/12, adopting Single Responsibility Principle (SRP) by decoupling HTTP routing, validation (Form Requests), business logic (Service Layer), database persistence (Eloquent Models), and serialization (API Resources).
- **Mobile**: Built with Flutter & Dart using Material 3 design, ChangeNotifier/Provider for reactive state management, repository pattern for data abstraction, and complete UI state handling (Loading, Success, Empty, and Error with Retry).

---

## 2. Technologies Used

### Backend
- **PHP 8.2+** (tested on PHP 8.3)
- **Laravel Framework 11+**
- **MySQL 8.0+** (with seamless SQLite fallback for isolated unit/feature testing)
- **Composer 2.x**
- **Laravel Pint** (PSR-12 code style enforcement)
- **PHPUnit 11+** (automated API feature tests)

### Mobile
- **Flutter 3.x** (Dart 3.x with sound null safety)
- **Provider** (`provider: ^6.1.5+1`) for state management
- **HTTP Client** (`http: ^1.6.0`) for network communication
- **Material 3 Design** components and adaptive widgets

---

## 3. Project Folder Structure

```text
products_management/
├── .gitignore                     # Root Git ignore rules
├── README.md                      # Complete project documentation
├── backend/                       # Laravel REST API application
│   ├── app/
│   │   ├── Http/
│   │   │   ├── Controllers/
│   │   │   │   └── Api/
│   │   │   │       └── ProductController.php  # Handles HTTP requests/responses
│   │   │   ├── Requests/
│   │   │   │   └── StoreProductRequest.php    # Validation rules & error messages
│   │   │   └── Resources/
│   │   │       └── ProductResource.php        # JSON response formatting
│   │   ├── Models/
│   │   │   └── Product.php                    # Eloquent Model with mass assignment
│   │   └── Services/
│   │       └── ProductService.php             # Encapsulated business logic
│   ├── bootstrap/
│   │   └── app.php                            # Laravel 11 app & route bootstrap
│   ├── config/
│   │   └── database.php                       # Database connection definitions
│   ├── database/
│   │   ├── factories/
│   │   │   └── ProductFactory.php             # Test model factory
│   │   ├── migrations/
│   │   │   └── 2026_11_16_060503_create_products_table.php
│   │   └── seeders/
│   │       ├── DatabaseSeeder.php
│   │       └── ProductSeeder.php              # Realistic seed data
│   ├── routes/
│   │   └── api.php                            # API endpoint routes
│   ├── tests/
│   │   └── Feature/
│   │       └── ProductApiTest.php             # Comprehensive API test suite
│   ├── .env.example                           # Example environment template
│   └── phpunit.xml                            # Automated test configuration
└── mobile/                        # Flutter mobile application
    ├── lib/
    │   ├── core/
    │   │   ├── constants/
    │   │   │   └── api_constants.dart         # Dynamic base URL resolution
    │   │   └── network/
    │   │       └── api_client.dart            # Reusable HTTP client & exceptions
    │   ├── features/
    │   │   └── products/
    │   │       ├── models/
    │   │       │   └── product_model.dart     # Product entity & JSON parsing
    │   │       ├── providers/
    │   │       │   └── product_provider.dart  # ChangeNotifier state container
    │   │       ├── repositories/
    │   │       │   └── product_repository.dart# Network communication abstraction
    │   │       ├── screens/
    │   │       │   └── products_screen.dart   # Main reactive UI with 4 states
    │   │       └── widgets/
    │   │           ├── product_card.dart      # Material 3 product card
    │   │           └── product_image.dart     # Safe network image with fallback
    │   └── main.dart                          # App entry point & provider tree
    ├── test/
    │   ├── unit/
    │   │   ├── product_model_test.dart        # JSON serialization unit tests
    │   │   └── product_provider_test.dart     # State transition & repository tests
    │   └── widget/
    │       └── products_screen_test.dart      # Screen state UI widget tests
    └── pubspec.yaml                           # Flutter dependencies
```

---

## 4. Requirements & Prerequisites

Ensure the following tools are installed on your machine:
- **PHP** >= 8.2 (extensions: `pdo`, `pdo_mysql`, `curl`, `mbstring`, `openssl`)
- **Composer** >= 2.0
- **MySQL** >= 8.0 or MariaDB >= 10.4
- **Flutter SDK** >= 3.22.0 & **Dart SDK** >= 3.4.0
- (Optional) Android Studio / Xcode / Chrome for running the Flutter app

---

## 5. Laravel Backend Setup

1. Navigate to the `backend/` directory:
   ```bash
   cd backend
   ```

2. Install PHP dependencies:
   ```bash
   composer install
   ```

3. Configure your environment file:
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

---

## 6. MySQL Database Setup

1. Open your MySQL client (CLI, phpMyAdmin, MySQL Workbench, or TablePlus) and create a database:
   ```sql
   CREATE DATABASE products_management CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```

2. Update your `backend/.env` file with your MySQL credentials:
   ```env
   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=products_management
   DB_USERNAME=root
   DB_PASSWORD=your_password_here
   ```

---

## 7. Migrations & Seeding

Run the migrations and populate the database with realistic sample products:

```bash
php artisan migrate --seed
```

If you ever wish to reset the database and re-seed from scratch:
```bash
php artisan migrate:fresh --seed
```

---

## 8. Starting the Laravel Server

Start the local development server:

```bash
php artisan serve --host=127.0.0.1 --port=8000
```

The API will now be accessible at `http://127.0.0.1:8000/api`.

---

## 9. Flutter Mobile App Setup

1. Navigate to the `mobile/` directory:
   ```bash
   cd mobile
   ```

2. Download and verify dependencies:
   ```bash
   flutter pub get
   ```

---

## 10. Configuring the API Base URL

The application includes an intelligent URL resolver in `lib/core/constants/api_constants.dart` that dynamically defaults to:
- **Android Emulator**: `http://10.0.2.2:8000/api` (standard Android loopback to host)
- **iOS Simulator / Web / Desktop**: `http://127.0.0.1:8000/api`

### Running on a Physical Device:
When running on a physical phone over Wi-Fi, pass your host computer's local IP using `--dart-define`:
```bash
flutter run --dart-define=API_BASE_URL=http://192.168.1.50:8000/api
```

---

## 11. Running the Flutter Application

Launch the application on your desired device or emulator:

```bash
# Run on default connected device (e.g. Chrome, Android emulator, iOS simulator)
flutter run

# Run specifically on Chrome
flutter run -d chrome

# Run specifically on Windows Desktop
flutter run -d windows
```

---

## 12. API Endpoint Documentation

| Method | Endpoint | Description | Status Code |
| :--- | :--- | :--- | :--- |
| **GET** | `/api/products` | Retrieve list of all products (ordered latest first) | `200 OK` |
| **POST** | `/api/products` | Create a new product with validation | `201 Created` / `422 Unprocessable Content` |

### Validation Rules for `POST /api/products`:
- `title`: **Required**, string, maximum 255 characters.
- `price`: **Required**, numeric, minimum 0.
- `description`: **Nullable**, string.
- `image_url`: **Nullable**, valid URL format.

---

## 13. Example JSON Requests and Responses

### 1. `GET /api/products`

**Request:**
```http
GET /api/products HTTP/1.1
Host: 127.0.0.1:8000
Accept: application/json
```

**Response (`200 OK`):**
```json
{
  "data": [
    {
      "id": 1,
      "title": "Wireless Noise-Canceling Headphones",
      "description": "Premium over-ear wireless headphones with active noise cancellation, 30-hour battery life, and crystal-clear sound quality.",
      "price": 199.99,
      "image_url": "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&auto=format&fit=crop&q=80",
      "created_at": "2026-11-16T06:30:42.000000Z",
      "updated_at": "2026-11-16T06:30:42.000000Z"
    }
  ]
}
```

*When no products exist, returns:*
```json
{
  "data": []
}
```

---

### 2. `POST /api/products` (Success)

**Request:**
```http
POST /api/products HTTP/1.1
Host: 127.0.0.1:8000
Content-Type: application/json
Accept: application/json

{
  "title": "Mechanical Keyboard Pro",
  "price": 149.99,
  "description": "Custom hot-swappable tactile switch keyboard with RGB backlighting.",
  "image_url": "https://images.unsplash.com/photo-1587829741301-dc798b83add3"
}
```

**Response (`201 Created`):**
```json
{
  "data": {
    "id": 9,
    "title": "Mechanical Keyboard Pro",
    "description": "Custom hot-swappable tactile switch keyboard with RGB backlighting.",
    "price": 149.99,
    "image_url": "https://images.unsplash.com/photo-1587829741301-dc798b83add3",
    "created_at": "2026-11-16T06:32:12.000000Z",
    "updated_at": "2026-11-16T06:32:12.000000Z"
  },
  "message": "Product created successfully"
}
```

---

### 3. `POST /api/products` (Validation Error)

**Request:**
```http
POST /api/products HTTP/1.1
Host: 127.0.0.1:8000
Content-Type: application/json
Accept: application/json

{
  "price": -10.00
}
```

**Response (`422 Unprocessable Content`):**
```json
{
  "message": "Product title is required. (and 1 more error)",
  "errors": {
    "title": [
      "Product title is required."
    ],
    "price": [
      "Product price must be at least 0."
    ]
  }
}
```

---

## 14. Architecture & Technical Decisions

### Backend (Laravel)
- **Controller (`ProductController`)**: Strictly handles receiving HTTP requests and returning standard HTTP responses. Contains 0 direct SQL queries or business logic.
- **Form Request (`StoreProductRequest`)**: Isolates input validation rules, authorization logic, and custom error messaging. Keeps the controller clean.
- **Service Layer (`ProductService`)**: Encapsulates data fetching and entity creation. Makes logic reusable across CLI commands, queues, and controllers.
- **Eloquent Model (`Product`)**: Manages database relationships, `$fillable` mass-assignment whitelist, and type casting (`price => decimal:2`).
- **API Resource (`ProductResource`)**: Guarantees consistent JSON envelope structure (`{"data": ...}`), prevents unintentional exposure of internal database fields, and standardizes ISO date formatting.

### Mobile (Flutter)
- **Repository Pattern (`ProductRepository`)**: Decouples API client details (endpoints, headers, HTTP serialization) from business state.
- **State Management (`ProductProvider`)**: Extends `ChangeNotifier`. Exposes distinct states: `loading`, `loaded`, `error`, `empty`, and operations `fetchProducts()` and `addProduct()`.
- **Reusable Network Layer (`ApiClient`)**: Centralizes timeouts, headers, JSON serialization, and structured exception handling (`ApiException`, `NetworkException`).
- **Safe Network Image (`ProductImage`)**: Implements `loadingBuilder` with progress indicators and `errorBuilder` with fallback placeholders for broken URLs.
- **Clean UI & Responsive Layout**: Built with Material 3, clean card hierarchy, pull-to-refresh (`RefreshIndicator`), and an interactive "Add Product" dialog.

---

## 15. Testing & Code Quality

### Backend Tests (PHPUnit)
All feature tests run isolated against an in-memory test database:
```bash
cd backend
php artisan test
```
**Test Coverage:**
- `test_can_get_empty_products_list`: Confirms `{"data": []}` with HTTP 200.
- `test_can_get_all_products`: Confirms retrieval of all seeded products and Resource schema.
- `test_can_create_product_with_valid_data`: Confirms 201 response and database persistence.
- `test_can_create_product_with_nullable_fields`: Confirms creation with null image and description.
- `test_validation_fails_when_title_or_price_missing`: Confirms 422 with validation errors.
- `test_validation_fails_when_price_is_negative`: Confirms numeric boundary validation.
- `test_validation_fails_when_image_url_is_invalid`: Confirms URL format validation.

Code formatting with Laravel Pint:
```bash
php ./vendor/bin/pint --test
```

### Mobile Tests (Flutter & Dart)
Run unit and widget tests:
```bash
cd mobile
flutter test
```
**Test Coverage:**
- `test/unit/product_model_test.dart`: Serialization, deserialization, null handling, string/number price casting.
- `test/unit/product_provider_test.dart`: Loading, loaded, error state transitions, repository error recovery, list prepending.
- `test/widget/products_screen_test.dart`: Verifies ListView display, empty state view, and error retry interaction.

Code analysis and formatting:
```bash
flutter analyze
dart format --set-exit-if-changed .
```

---

## 16. Security Best Practices

1. **Environment Variables**: `.env` is ignored by `.gitignore`. Only `.env.example` is committed without real credentials.
2. **Mass Assignment Protection**: Only safe columns (`title`, `description`, `price`, `image_url`) are defined in `$fillable`.
3. **Strict Validation**: All incoming requests are validated against strict type, string length, and numeric rules before hitting the database.
4. **Production Recommendation**: Enforce HTTPS in production via reverse proxies (Nginx/Cloudflare) and set `SESSION_SECURE_COOKIE=true`.

---

## 17. Screenshots & UI Mockups

### Mobile UI States:

```text
┌───────────────────────────────┐   ┌───────────────────────────────┐
│ Products Management        🔄 │   │ Products Management        🔄 │
├───────────────────────────────┤   ├───────────────────────────────┤
│                               │   │ ┌───────────────────────────┐ │
│                               │   │ │ [ Image: Headphones ]     │ │
│           ( ⭕ )              │   │ │ Wireless Headphones       │ │
│     Loading products...       │   │ │ $199.99                   │ │
│                               │   │ └───────────────────────────┘ │
│                               │   │ ┌───────────────────────────┐ │
│                               │   │ │ [ Image: Keyboard ]       │ │
│                               │   │ │ Mechanical Keyboard       │ │
│                               │   │ │ $129.50                   │ │
│                               │   │ └───────────────────────────┘ │
│                               │   │             [ + Add Product ] │
└───────────────────────────────┘   └───────────────────────────────┘
          Loading State                       Success State

┌───────────────────────────────┐   ┌───────────────────────────────┐
│ Products Management        🔄 │   │ Products Management        🔄 │
├───────────────────────────────┤   ├───────────────────────────────┤
│                               │   │                               │
│            📦                 │   │            ☁️                 │
│     No Products Found         │   │   Failed to load products     │
│   Catalog is currently empty  │   │   Server connection refused   │
│                               │   │                               │
│     [ + Add Product ]         │   │         [ 🔄 Retry ]          │
│                               │   │                               │
└───────────────────────────────┘   └───────────────────────────────┘
           Empty State                         Error State
```

---

## Technical Assessment Checklist

- [x] Root repository containing `backend/`, `mobile/`, `README.md`, `.gitignore`.
- [x] Laravel 11 backend with MySQL configuration.
- [x] Product migration, Model with `$fillable`, and realistic seeder.
- [x] Service layer (`ProductService`), Form Request (`StoreProductRequest`), API Resource (`ProductResource`).
- [x] `GET /api/products` (200, handles empty and populated lists).
- [x] `POST /api/products` (201 on success, 422 on validation failure).
- [x] Flutter app with clean architecture (`core/`, `features/products/`).
- [x] Provider state management (`ChangeNotifier`) with 4 UI states.
- [x] Reusable `ApiClient` with configurable base URL (Android emulator, iOS simulator, web, custom IP).
- [x] Material 3 UI with pull-to-refresh and safe network image preview.
- [x] 100% passing backend tests (`php artisan test`).
- [x] 100% passing frontend tests (`flutter test`).
- [x] Code style compliance (`Laravel Pint` + `dart format` + `flutter analyze`).
