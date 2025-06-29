# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

JunkFoodApp is a Flutter application for displaying daily dishes from Junkfood, a non-profit organization in Copenhagen that provides free, nutritious evening meals to homeless and vulnerable people. Founded during COVID-19 by Michelin-star chef Rasmus Munk, Junkfood serves meals using donated surplus food to "gadens folk" (people on the street), having served over 313,500 meals targeting Copenhagen's 1,387 people living on the streets.

The app shows the dish of the day with nutritional information, allows users to rate dishes and leave comments, and supports multiple languages (Danish and English).

## Architecture

### Clean Architecture Pattern
The project follows clean architecture with clear separation of concerns:

- **Domain Layer** (`lib/domain/`): Contains business models and core entities
  - `model/dish_model.dart`: Core dish entity with JSON serialization
  - `model/rating_model.dart`: Rating system model
  - `model/language_model.dart`: Localization model

- **Data Layer** (`lib/data/`): Repository pattern with interface abstraction
  - Interfaces define contracts (`interface_*_repository.dart`)
  - Implementations handle Supabase API calls and local storage
  - Generated Riverpod providers (`.g.dart` files)

- **UI Layer** (`lib/ui/`): Presentation logic with Riverpod state management
  - `controllers/`: Riverpod-based state controllers with async data handling
  - `pages/`: Screen-level components (dish display, comments, ratings)
  - `widgets/`: Reusable UI components

### State Management
Uses **Riverpod** with code generation:
- Controllers use `@riverpod` annotations
- Async providers handle data fetching and caching
- Consumer widgets react to state changes

### Backend Integration
- **Supabase** for backend services (database, authentication)
- Environment variables for configuration (`Constants.dart`)
- Repository pattern abstracts data sources

## Development Commands

### Code Generation
```bash
# Watch mode for continuous generation (essential for development)
dart run build_runner watch -d

# One-time generation
dart run build_runner build --delete-conflicting-outputs
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/rating_widget_test.dart

# Run tests with coverage
flutter test --coverage
```

### Code Quality
```bash
# Static analysis
flutter analyze

# Format code
dart format .

# Check for potential issues
flutter pub deps
```

### Building
```bash
# Build for Android
flutter build apk

# Build for iOS
flutter build ios

# Build for web
flutter build web
```

### Running
```bash
# Run on connected device
flutter run

# Run with environment variables
flutter run --dart-define=SUPABASE_URL=your_url --dart-define=SUPABASE_ANON_KEY=your_key
```

## Configuration

### Environment Variables
Set via `--dart-define` flags or environment:
- `SUPABASE_URL`: Supabase project URL
- `SUPABASE_ANON_KEY`: Supabase anonymous key

### Localization
- Supports Danish (`da`) and English (`en`)
- ARB files in `lib/l10n/`
- Generated localization classes

## Key Dependencies

- **flutter_riverpod**: State management and dependency injection
- **supabase_flutter**: Backend integration
- **flutter_hooks**: Reactive programming utilities
- **build_runner**: Code generation tooling

## Development Workflow

1. Always run `dart run build_runner watch -d` when developing
2. Use Riverpod providers for dependency injection
3. Follow repository pattern for data access
4. Implement proper error handling in async operations
5. Run tests and analysis before committing

## Database Schema

The app connects to a Supabase database with tables for:
- Dishes (title, description, calories, images)
- DishTypes (main, alternative, dessert)
- Allergens and dish associations
- Ratings and comments
- Serving schedules and locations

## Testing

Test files use mockito for mocking dependencies. Key test patterns:
- Widget testing with `flutter_test`
- Mocked repositories and controllers
- Golden file testing for UI consistency