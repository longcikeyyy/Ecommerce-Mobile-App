# Model Pattern

> Read this file when: creating request/response DTOs, adding API models, or working with JSON serialization.

## File Structure

```
lib/models/
├── request/    # Outbound payloads sent to API/Firebase
└── response/   # Inbound payloads received from API/Firebase
```

Naming convention:
- Request: `<feature>_request.dart` → class `FeatureRequestModel`
- Response: `<feature>_response.dart` → class `FeatureResponseModel`

---

## Examples

Read the existing models in source code for the latest pattern — these are the canonical references:

- **Request:** [lib/models/request/mock_request.dart](../../lib/models/request/mock_request.dart)
- **Response:** [lib/models/response/mock_reponse.dart](../../lib/models/response/mock_reponse.dart)

Follow the same structure, annotation style, and naming as those files.

---

## Rules

- DTOs only — no business logic, no Firebase types, no UI types
- Always add `part '<filename>.g.dart';` and `@JsonSerializable()` annotation
- Always implement both `fromJson` and `toJson`
- Use `explicitToJson: true` on `@JsonSerializable` when the model has nested models
- Use `@JsonKey(name: '...')` when API snake_case differs from Dart camelCase field names
- Nullable fields: use `String?` + `@JsonKey(includeIfNull: false)` if the field is optional in the payload
- Never use `Map<String, dynamic>` directly in a Cubit or screen — always parse into a model first
- Generated `*.g.dart` files — never edit manually

---

## After Creating a Model

Run:
```bash
dart run build_runner build --delete-conflicting-outputs
```

This generates `<filename>.g.dart` with the `fromJson`/`toJson` implementations.

---

## Checklist When Adding a New Model

- [ ] File in correct folder (`request/` or `response/`)
- [ ] Class named `<Feature>RequestModel` or `<Feature>ResponseModel`
- [ ] `@JsonSerializable()` annotation present
- [ ] `part '<filename>.g.dart';` declared
- [ ] Both `fromJson` factory and `toJson` method implemented
- [ ] `explicitToJson: true` if model contains nested models
- [ ] Ran `dart run build_runner build --delete-conflicting-outputs`
