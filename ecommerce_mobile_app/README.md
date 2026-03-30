# Ecommerce Mobile App

A Flutter e-commerce mobile application built with Clean Architecture, BLoC/Cubit state management, and a full Firebase backend.

---

## Tech Stack

| Category | Library |
|---|---|
| State Management | flutter_bloc (Cubit) |
| Dependency Injection | get_it + injectable |
| Navigation | go_router |
| Networking | dio + retrofit |
| Database | cloud_firestore |
| Authentication | firebase_auth + google_sign_in |
| Local Storage | shared_preferences + flutter_secure_storage |
| UI Scaling | flutter_screenutil |
| Functional Programming | dartz |
| Serialization | json_serializable + freezed |
| Logging | logger |
| Assets Generation | flutter_gen |

---

## Architecture

The project follows **Clean Architecture** principles with a **Cubit-based BLoC** pattern for state management.

```
lib/
├── core/               # Cross-cutting concerns
│   ├── assets_gen/     # Auto-generated asset & font references
│   ├── constants/      # App-wide constants
│   ├── enums/          # Shared enumerations
│   ├── extensions/     # Dart/Flutter extensions
│   ├── logging/        # Abstract logger + console implementation
│   └── utils/          # String, Date, Validator utilities
├── di/                 # Dependency injection (GetIt + Injectable)
├── models/             # Request/response DTOs (JSON serializable)
├── router/             # GoRouter navigation configuration
├── screens/            # Feature screens (Splash, Sign In, ...)
├── services/           # Data sources
│   ├── local/          # SharedPreferences + SecureStorage
│   └── remote/         # Firebase service wrapper
├── shared/             # Reusable UI components
├── theme/              # Colors and typography
└── main.dart           # App entry point
```

### Data Flow

```
Widget → BlocBuilder/BlocListener → Cubit → Service → Firebase / LocalStorage
```

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.8.1`
- Dart SDK `^3.8.1`
- A Firebase project with Android/iOS apps configured

### Setup

1. **Clone the repository**

```bash
git clone <repository-url>
cd ecommerce_mobile_app
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Configure Firebase**

   - Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
   - Add Android and iOS apps to the project
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) and place them in the respective platform directories
   - Enable **Email/Password** and **Google Sign-In** authentication providers

4. **Run code generation**

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

5. **Run the app**

```bash
flutter run
```

---

## Project Structure Details

### Dependency Injection

DI is handled by `get_it` with `injectable` for annotation-based code generation. All services are registered in `lib/di/`:

- `@LazySingleton()` — for services like `FirebaseService`, `AppLogger`
- `@injectable` — for Cubits (new instance per injection)
- `@preResolve` — for async singletons like `SharedPreferences` and `FirebaseRemoteConfig`

To regenerate the DI config after adding a new injectable class:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Navigation

Routes are defined in `lib/router/app_router.dart` using `GoRouter`. Route name constants live in `lib/router/route_name.dart`.

| Route | Screen |
|---|---|
| `/splash` | SplashScreen |
| `/sign-in` | SignInScreen |

### Services

**`FirebaseService`** — wraps `FirebaseAuth` and `FirebaseFirestore`. Configured as a `@LazySingleton` and injected via DI.

**`LocalStorage`** — dual-storage abstraction:
- Sensitive data (tokens) → `FlutterSecureStorage` (encrypted)
- Preferences (theme, language) → `SharedPreferences`

> Call `LocalStorage.init()` before use. This is handled in `main.dart` via the DI `@preResolve` setup.

### State Management

State is managed with **Cubit** (simplified BLoC without an event layer).

Each feature Cubit:
- Lives in `lib/cubit/<feature>/`
- State is an immutable `@freezed` class
- Registered as `@injectable` in the DI container

### Shared Components

| Widget | Description |
|---|---|
| `AppButton` | Full-width button with loading state and outlined variant |
| `AppTextField` | Styled text input with prefix/suffix icon support |
| `AppText` | Consistent text wrapper using app typography |

### Theme

**Colors** — defined in `AppColors`:

| Token | Hex | Usage |
|---|---|---|
| `primary` | `#8E6CEF` | Primary brand color |
| `white` | `#FFFFFF` | Background |
| `darkGrey` | `#272727` | Primary text |
| `lightGrey` | `#F4F4F4` | Input backgrounds |
| `darkGreyOpacity50` | `#80272727` | Secondary text |

**Typography** — defined in `AppTypography`, using the `CircularStd` and `Gabarito` font families:

| Style | Size | Weight |
|---|---|---|
| `splashTitle` | 72pt | Bold |
| `headline1` | 28pt | Bold |
| `headline2` | 20pt | Bold |
| `headline3` | 18pt | Bold |
| `bodyText1` | 16pt | Regular |
| `bodyText2` | 14pt | Regular |
| `button` | 16pt | SemiBold |

### Core Utilities

**`StringUtils`** — `capitalize`, `capitalizeWords`, `truncate`, `maskEmail`, `formatCurrency`, `toSlug`, `isNullOrEmpty`

**`AppDateUtils`** — `toDateString`, `toTimeString`, `toFullString`, `toIsoDateString`, `tryParse`, `isToday`, `isPast`, `isFuture`, `timeAgo`

**`ValidatorUtils`** — `validateEmail`, `validatePassword`, `validateConfirmPassword`, `validatePhone`, `validateRequired`, `validateUrl`, `validatePositiveNumber` — all return `String?` and are compatible with `TextFormField.validator`

**`ContextExtension`** — `context.width`, `context.height` shortcuts via `MediaQuery`

### Logging

All logging goes through the `AppLogger` abstract interface, implemented by `ConsoleAppLogger` (using the `logger` package with `PrettyPrinter`). Inject `AppLogger` via DI wherever logging is needed.

```dart
appLogger.i('User signed in');
appLogger.e('Auth failed', error: e, stackTrace: s);
```

---

## Code Generation

This project uses `build_runner` for generating boilerplate. Re-run whenever you:

- Add or modify a `@injectable` / `@LazySingleton` class
- Add or modify a `@freezed` state class
- Add or modify a `@JsonSerializable` model
- Add new assets or fonts (triggers `flutter_gen`)

```bash
# One-time build
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode during development
flutter pub run build_runner watch
```

---

## Firebase Services Configured

| Service | Package | Purpose |
|---|---|---|
| Authentication | `firebase_auth` | Email/password & social login |
| Firestore | `cloud_firestore` | NoSQL database |
| Storage | `firebase_storage` | File uploads |
| Messaging | `firebase_messaging` | Push notifications |
| Analytics | `firebase_analytics` | User event tracking |
| Crashlytics | `firebase_crashlytics` | Crash reporting |
| Remote Config | `firebase_remote_config` | Feature flags |

---

## Design Reference

- **Base design size:** 414 × 896 (iPhone reference)
- **Responsive scaling:** `flutter_screenutil` — use `.w`, `.h`, `.r`, `.sp` suffixes
- **SVG icons:** `flutter_svg` — access via generated `Assets.icons.*`
- **Images:** access via generated `Assets.images.*`
