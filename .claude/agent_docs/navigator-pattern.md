# Navigation Pattern

> Read this file when: adding a new route, passing params between screens, or handling deep links.

## Overview

Navigation uses **GoRouter**. All routes are defined in one place — never scattered across the app.

---

## Examples

Read the existing router files in source code for the latest pattern — these are the canonical references:

- **Route definitions:** [lib/router/app_router.dart](../../lib/router/app_router.dart)
- **Route constants:** [lib/router/route_name.dart](../../lib/router/route_name.dart)

Follow the same structure and naming as those files when adding new routes.

---

## Adding a New Route

**Step 1** — Add path + name constants to `route_name.dart` (follow existing entries as reference).

**Step 2** — Add a `GoRoute` entry to `app_router.dart` (follow existing entries as reference).

---

## Navigation Methods

```dart
// Replace current stack entry
context.goNamed(RouteName.someRoute);

// Push on top of stack
context.pushNamed(RouteName.someRoute);

// Go back
context.pop();

// Go back with result
context.pop(result);
```

---

## Passing Parameters

| Type | When to use | How to read |
|---|---|---|
| `pathParameters` | Required, deep-linkable (e.g. `/product/:id`) | `state.pathParameters['id']` |
| `queryParameters` | Optional filters (e.g. `?category=shoes`) | `state.uri.queryParameters['category']` |
| `extra` | Complex objects, not URL-serializable | `state.extra as MyModel` |

---

## Rules

- All route paths and names in `route_name.dart` — never inline strings
- Always use `goNamed`/`pushNamed` — never `go('/path')` or `Navigator.push()`
- Route `builder` must be pure — no business logic, just pass params to screen constructor
- Never navigate from a Cubit — emit a state flag, react in `BlocListener`
- For bottom nav / tabs: use `ShellRoute` wrapping the tab screens

---

## Checklist When Adding a New Route

- [ ] Path constant added to `route_name.dart`
- [ ] Route name constant added to `route_name.dart`
- [ ] `GoRoute` added to `app_router.dart`
- [ ] Navigation uses `goNamed`/`pushNamed` with the constant
- [ ] Auth guard updated in `redirect` if the route requires authentication
