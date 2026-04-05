# Cubit Pattern

> Read this file when: creating a new Cubit, reviewing state management code, or debugging state issues.

## File Structure

One folder per feature under `lib/cubit/<feature>/`:

```
lib/cubit/
└── <feature>/
    ├── <feature>_cubit.dart   # business logic
    └── <feature>_state.dart   # state shape (freezed)
```

---

## Examples

Read the existing Cubit in source code for the latest pattern — these are the canonical references:

- **Cubit:** [lib/cubit/counter/counter_cubit.dart](../../lib/cubit/counter/counter_cubit.dart)
- **State:** [lib/cubit/counter/counter_state.dart](../../lib/cubit/counter/counter_state.dart)

Follow the same structure, annotation style, and naming as those files.

---

## Rules

**State (`<feature>_state.dart`):**
- Always `@freezed` — never a plain class or `Equatable`
- Declare defaults with `@Default(...)` so the `const` constructor works
- Standard fields every state should have: `isLoading`, `errorMessage`
- Never add `BuildContext`, widgets, or callbacks as state fields

**Cubit (`<feature>_cubit.dart`):**
- Always annotate with `@injectable` (new instance per injection — not singleton)
- Inject dependencies via constructor — never use `getIt<X>()` inside a Cubit
- Initial state always `const FeatureState()`
- All state changes via `emit(state.copyWith(...))` — never mutate fields directly
- No `BuildContext`, no navigation, no UI logic inside a Cubit
- Never reference another Cubit directly — communicate through a shared Service

**Using in a screen:**
- `BlocBuilder` for reactive UI; `BlocListener` for side-effects (navigation, snackbars)
- `context.read<FeatureCubit>()` only inside callbacks/handlers — never inside `build()`
- `BlocProvider` scoped to the screen, not app root (unless state is truly global)
- Never call `cubit.close()` manually — let `BlocProvider` handle lifecycle

---

## Checklist When Adding a New Cubit

- [ ] Created `lib/cubit/<feature>/<feature>_state.dart` with `@freezed`
- [ ] Created `lib/cubit/<feature>/<feature>_cubit.dart` with `@injectable`
- [ ] Ran `dart run build_runner build --delete-conflicting-outputs`
- [ ] State has `isLoading` + `errorMessage` fields
- [ ] No `BuildContext` or navigation in Cubit methods
