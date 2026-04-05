# Ecommerce Mobile App — Claude Code Guide

## Project Overview

Flutter e-commerce mobile app with Firebase backend (Auth, Firestore, Storage, Messaging, Analytics, Crashlytics, Remote Config). Targets Android, iOS, Web, macOS, Windows. Design baseline: iPhone 14 (390×844).

- **Flutter SDK:** ^3.8.1
- **Dart SDK:** ^3.8.1

## Commands

```bash
# Run
flutter run
flutter run --profile
flutter run --release

# Code generation — run after ANY change to @injectable/@freezed/@JsonSerializable/@RestApi classes or assets
dart run build_runner build --delete-conflicting-outputs

# Watch mode during development
dart run build_runner watch --delete-conflicting-outputs

# Analyze & test
flutter analyze
flutter test
```

## Architecture

See full architecture reference: [.claude/agent_docs/architecture.md](.claude/agent_docs/architecture.md)

**Pattern:** Clean Architecture + Cubit (BLoC without events)

Data flow: `Widget → Cubit → Service → Firebase / LocalStorage`

## Pattern References

Load these only when working on the relevant concern:

| Topic | Reference |
|---|---|
| State management (Cubit + freezed) | [.claude/agent_docs/cubit-pattern.md](.claude/agent_docs/cubit-pattern.md) |
| Request/Response DTOs (JSON models) | [.claude/agent_docs/model-pattern.md](.claude/agent_docs/model-pattern.md) |
| Routing (GoRouter, params, guards) | [.claude/agent_docs/navigator-pattern.md](.claude/agent_docs/navigator-pattern.md) |

## Key Conventions

| What | Rule |
|---|---|
| Logging | Use injected `AppLogger` (`i/d/w/e/f/crash`). Never use `print()` or `debugPrint()`. |
| Validation | Use `ValidatorUtils`. Never write inline regex. |
| Sensitive data | Use `LocalStorage` (SecureStorage backend) for tokens/credentials. Never SharedPreferences for sensitive data. |
| String helpers | Use `StringUtils`. |
| Date helpers | Use `AppDateUtils`. |
| Screen dimensions | Use `context.width` / `context.height` (ContextExtension). |
