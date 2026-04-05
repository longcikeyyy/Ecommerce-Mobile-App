# Architecture

> Read this file when: designing a new feature, reviewing layer placement, or deciding where code belongs.

## Pattern

**Clean Architecture + Cubit (BLoC without events)**

Data flows in one direction:

```
Widget → BlocBuilder/BlocListener → Cubit → Service → Firebase / LocalStorage
```

Cubits never directly reference other Cubits. Shared state goes through a Service.

---

## Folder Structure

```
lib/
├── core/
│   ├── assets_gen/   # GENERATED — never edit manually
│   ├── constants/    # App-wide constants (LocalKey)
│   ├── enums/
│   ├── extensions/   # ContextExtension (context.width/height)
│   ├── logging/      # AppLogger interface + ConsoleAppLogger
│   └── utils/        # StringUtils, AppDateUtils, ValidatorUtils
├── cubit/            # One subfolder per feature: <feature>_cubit.dart + <feature>_state.dart
├── di/
│   ├── injector.dart             # Entry: configureDependencies()
│   ├── injector.config.dart      # GENERATED — never edit manually
│   └── third_party_module.dart   # External service registrations (@module)
├── models/
│   ├── request/
│   └── response/
├── router/
│   ├── app_router.dart   # GoRoute definitions
│   └── route_name.dart   # Route name constants
├── screens/          # One subfolder per screen/feature
├── services/
│   ├── local/        # LocalStorage (SharedPreferences + SecureStorage)
│   └── remote/       # FirebaseService
├── shared/           # Reusable widgets: AppButton, AppTextField, AppText, SocialButton
└── theme/            # AppColors, AppTypography — source of truth for design tokens
```

---

## Rules

### Presentation

- Screens only render state and forward user actions — no business logic in widgets
- `BlocBuilder` for reactive UI; `BlocListener` for side-effects (navigation, snackbars, dialogs)
- Never call `context.read<XCubit>()` inside `build()` — only inside callbacks/handlers
- Widget used in 2+ screens → `lib/shared/`; used in 1 screen → co-locate in `lib/screens/<feature>/`

### Cubit

- Never hold `BuildContext`; never call navigation directly from a Cubit
- Never reference another Cubit directly — communicate through a shared Service
- State must be `@freezed`; all transitions via `emit(state.copyWith(...))`
- Model loading/error/data as state fields — not as separate variables outside the state

### Service

- Only layer allowed to touch Firebase SDK or LocalStorage directly
- Expose typed async methods — return `Either<Failure, T>` (dartz) or throw typed exceptions; never return raw Firebase types
- `local/LocalStorage`: SharedPreferences for non-sensitive; SecureStorage for tokens/credentials
- `remote/FirebaseService`: split into focused services as it grows (e.g. `AuthService`, `FirestoreService`)

### Dependency Injection

- Never instantiate a service or cubit with `MyClass()` — always inject via constructor
- `@LazySingleton()` for services; `@injectable` for cubits; `@preResolve` for async-init singletons; `@module` for third-party
- `injector.config.dart` is generated — never edit manually
- After any annotation change: `dart run build_runner build --delete-conflicting-outputs`

### Models

- DTOs only — no business logic, no Firebase types, no UI types
- Always annotate with `@JsonSerializable`; run build_runner after changes
- `request/` for outbound payloads; `response/` for inbound payloads

### Router

- All route name strings as constants in `route_name.dart`
- All `GoRoute` definitions in `app_router.dart`
- Never use `Navigator.push()` — GoRouter exclusively
- Navigate by name (`context.goNamed(...)`) not by path string

### Core & Theme

- Never hardcode asset paths — use generated `Assets` class from `lib/core/assets_gen/`
- Never hardcode hex colors — use `AppColors`
- Never create inline `TextStyle(...)` — use `AppTypography`
- Never use `MediaQuery.of(context).size` — use `context.width` / `context.height`
- Never use raw pixel values — use `flutter_screenutil` (`.w`, `.h`, `.sp`, `.r`)

---

## What Belongs Where

| Scenario | Location |
|---|---|
| UI rendering | `lib/screens/<feature>/` or `lib/shared/` |
| User action / business logic | Cubit method |
| App state shape | `<feature>_state.dart` (freezed) |
| Firebase / API call | `lib/services/remote/` |
| Sensitive storage (tokens) | `lib/services/local/` via SecureStorage |
| Non-sensitive prefs | `lib/services/local/` via SharedPreferences |
| Route constants | `lib/router/route_name.dart` |
| Route definitions | `lib/router/app_router.dart` |
| Third-party DI registration | `lib/di/third_party_module.dart` |
| Reusable widget (2+ screens) | `lib/shared/` |
| Screen-specific sub-widget | `lib/screens/<feature>/` |
