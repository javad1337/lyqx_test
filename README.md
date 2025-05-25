LYQX Test App

A Flutter mock store application demonstrating:
	•	Dio for network calls
	•	BLoC/Cubit for state management
	•	Injectable & GetIt for dependency injection
	•	GoRouter for navigation/routing
	•	SharedPreferences for local persistence

⸻

Table of Contents
	1.	Project Structure
	2.	Getting Started
	3.	Tech Stack
	4.	Dependencies
	5.	Scripts
	6.	Folder Layout
	7.	Features
	8.	Contributing
	9.	License

⸻

Project Structure

lib/
├── main.dart             # App entry point
├── app.dart              # MaterialApp.router setup
├── app_module.dart       # Dependency Injection & GoRouter
├── injection.dart        # Generated Injectable config
├── core/
├── features/
│   ├── auth/             # Authentication feature
│   ├── products/         # Products listing & detail
│   ├── wishlist/         # Favorites functionality
│   └── cart/             # Shopping cart
├── widgets/              # Global shared widgets
└── utils/                # Shared tyles


⸻

Getting Started

	1.	Clone the repository

git clone [<repo-url>](https://github.com/javad1337/lyqx_test.git)
cd lyqx_test

	2.	Install dependencies

flutter pub get

	3.	Generate DI code

flutter pub run build_runner build --delete-conflicting-outputs

	4.	Run the app

flutter run



⸻

Tech Stack
	•	Flutter & Dart
	•	Dio – HTTP client
	•	flutter_bloc / bloc – BLoC state management
	•	injectable + get_it – Dependency Injection
	•	go_router – Declarative routing
	•	shared_preferences – Local key-value storage
	•	equatable – Value equality for BLoC states/events

⸻

 
 
⸻

Folder Layout
	•	features/ – Feature-first modules (auth, products, wishlist, cart)
	•	utils/, widgets/ – Shared widgets, styles, and utilities
	•	app_module.dart – DI & routing config
	•	injection.dart – Generated GetIt init function

⸻

Features
	•	Authentication (login/logout)
	•	Product listing with pagination
	•	Product details view
	•	Wishlist (favorites) with local persistence
	•	Shopping cart with quantity management and local persistence
	•	Routing guards based on auth state

⸻

License

This project is licensed under the MIT License.
