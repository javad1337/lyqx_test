# LYQX Test App

![License](https://img.shields.io/badge/license-MIT-blue.svg) ![Version](https://img.shields.io/badge/version-1.0.0-green.svg) ![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)

A Flutter-based mock store app showcasing modern architecture and state-of-the-art tools for API integration, state management, dependency injection, routing, and local persistence.

## 🚀 Features

- ✨ **Authentication**: Login, logout, and route guarding using BLoC  
- 🔍 **Product Listing**: Server-side pagination with Dio and BLoC  
- 📦 **Product Details**: Detail view with passed-in model data  
- ❤️ **Wishlist**: Favorite toggling and local storage via Cubit & SharedPreferences  
- 🛒 **Cart**: Quantity management, swipe-to-delete, and local persistence  
- 🔄 **Routing**: Guarded routes, shell layout, and bottom navigation using GoRouter  
- 🧩 **DI**: Dependency injection with Injectable & GetIt  
- 🎨 **Theming**: Centralized text styles and custom fonts (Urbanist)  

## 📋 Table of Contents 
- [Usage](#usage)  
- [Project Structure](#project-structure)
- [Architecture Diagram](#architecture-diagram)
- [Tech Stack](#tech-stack)  
- [Installation](#installation)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [Contact & Connect](#contact-connect)


## 🏗️ Architecture Diagram

```
UI (Widgets)
     ↕
BLoC/Cubit (State)
     ↕
Repository Interface (Domain)
     ↕
Dio + SharedPreferences (Data)
```

### Layer Responsibilities

- **UI Layer**: Flutter widgets that display data and handle user interactions
- **State Management**: BLoC/Cubit manages application state and business logic
- **Domain Layer**: Repository interfaces define contracts for data operations
- **Data Layer**: Dio handles API calls while SharedPreferences manages local storage


## 📖 Usage

### Login
Navigate to `/login`, enter your credentials, and authenticate to access the application.

### Browse Products
Scroll through the product catalog to load more items dynamically. The app uses infinite scrolling for a smooth browsing experience.

### View Product Details
Tap on any product to view its detailed information, including specifications, pricing, and customer reviews.

### Wishlist Management
Tap the heart icon on any product to toggle it in your favorites list. Access your complete wishlist from the navigation menu.

### Shopping Cart
- **Add Items**: Tap "Add to Cart" on product pages
- **Adjust Quantities**: Use the quantity controls in your cart
- **Remove Items**: Swipe left on cart items to remove them

### Navigation
Use the bottom navigation bar or swipe gestures to move between:
- **Home**: Browse and discover products
- **Wishlist**: View your saved favorites
- **Cart**: Manage your shopping cart


## 📁 Project Structure

```
lib/
├── main.dart              # App entry point
├── app.dart               # MaterialApp.router setup
├── app_module.dart        # DI & GoRouter config
├── injection.dart         # Generated DI code
├── features/
│   ├── auth/              # AuthBloc, events, states, pages
│   ├── products/          # ProductRepository, Blocs, pages
│   ├── wishlist/          # WishlistCubit, repository, page
│   └── cart/              # CartCubit, repository, page
├── widgets/               # CustomAppBar, BottomNavBar, ProductCard
├── utils/                 # AppTextStyles with Urbanist font
└── core/                  # GoRouterRefreshNotifier
```

## 🧰 Tech Stack

### Core Framework
- **Flutter & Dart** - Cross-platform mobile development framework

### Networking
- **Dio** - Powerful HTTP client for API requests and interceptors

### State Management
- **flutter_bloc** / **bloc** - Predictable state management using the BLoC pattern

### Dependency Injection
- **injectable** + **get_it** - Code generation and service locator for dependency injection

### Navigation
- **go_router** - Declarative routing with navigation guards and deep linking support

### Local Storage
- **shared_preferences** - Simple key-value storage for user preferences and app settings

### Utilities
- **equatable** - Simplifies value equality comparisons for states and events



## 🛠️ Installation

### Prerequisites

- Flutter SDK (>= 3.7.2)  
- Dart SDK  

### Quick Start

```bash
# Clone the repository
git clone https://github.com/javad1337/lyqx_test.git
cd lyqx_test

# Install packages
flutter pub get

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

## 🗺️ Roadmap

### Upcoming Features

#### Phase 1 - User Experience
- **Real User Profiles** - Complete user registration, profile management, and avatar uploads
- **Push Notifications** - Order updates, wishlist alerts, and promotional notifications
- **Search & Filters** - Advanced product search with category, price, and rating filters

#### Phase 2 - Enhanced Functionality  
- **Payment Integration** - Stripe/PayPal integration for secure checkout
- **Order History** - Track past purchases and reorder functionality
- **Product Reviews** - User ratings and review system

#### Phase 3 - Advanced Features
- **Dark Mode** - Complete dark theme implementation
- **Offline Support** - Cache products for offline browsing
- **Social Sharing** - Share products and wishlists with friends
- **Multi-language Support** - Internationalization for global users

### Long-term Vision
- **AI Recommendations** - Personalized product suggestions based on user behavior
- **AR Product Preview** - Augmented reality for trying products virtually
- **Voice Search** - Search products using voice commands


## 🤝 Contributing

I welcome contributions from the community! Whether you're fixing bugs, adding features, or improving documentation, your help is appreciated. Please follow these guidelines:

### How to Contribute

1. **Fork** the repository and create a feature branch
2. **Follow** the existing code style and architecture patterns
3. **Test** your changes thoroughly before submitting
4. **Document** any new features or significant changes
5. **Submit** a pull request with a clear description of your changes

### Development Setup

```bash
# Clone your fork
git clone https://github.com/yourusername/project-name.git

# Install dependencies
flutter pub get

# Run code generation
flutter packages pub run build_runner build

# Run the app
flutter run
```

### Code Style
- Follow Dart/Flutter conventions and use `flutter analyze`
- Use meaningful variable and function names
- Add comments for complex business logic
- Maintain the existing architecture patterns (BLoC, Repository, etc.)

## 📋 Code of Conduct

This project is committed to providing a welcoming and inclusive environment for all contributors. I expect all participants to treat each other with respect, regardless of background, experience level, or identity. Harassment, discrimination, or inappropriate behavior will not be tolerated. By participating in this project, you agree to abide by these standards and help create a positive community where everyone can contribute effectively. If you encounter any issues, please reach out to me directly.


## 📞 Contact & Connect

I'm always open to discussing this project, Flutter development, or potential collaboration opportunities!

### Get in Touch

- **LinkedIn**: [Javad Khalilov](https://www.linkedin.com/in/javadkhalilov/) - Let's connect professionally
- **GitHub**: [@javad1337](https://github.com/javad1337) - Check out my other projects
- **Email**: javadxan@gmail.com - For project inquiries or questions
