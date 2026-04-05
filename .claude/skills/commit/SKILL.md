---
name: commit
description: Stage and commit changes with a well-structured Conventional Commits message. Analyzes diff, generates scope/type/body, runs pre-commit checks. Use when user wants to commit staged or unstaged changes.
disable-model-invocation: true
argument-hint: "[optional commit message override]"
---

# Commit Skill

You are performing a git commit for this Flutter/Dart project. Follow these steps precisely.

## Step 1 — Gather context

Run these in parallel:

```!
git status --short
git diff --cached --stat
git diff --stat
git log --oneline -5
```

## Step 2 — Stage files (if nothing is staged)

If `git diff --cached` is empty but `git diff` has changes, ask the user which files to stage — **never blindly run `git add -A`**. Sensitive files (`.env`, `*.key`, `google-services.json`, `GoogleService-Info.plist`, `firebase_options.dart` containing real credentials) must **never** be staged.

If the user passes arguments via `$ARGUMENTS`, treat it as a commit message override and skip message generation (go to Step 4).

## Step 3 — Generate Conventional Commit message

Analyze the staged diff with:

```!
git diff --cached
```

Then compose a commit message following **Conventional Commits 1.0**:

```
<type>(<scope>): <short summary — imperative mood, ≤72 chars>

[optional body — explain WHY not WHAT, wrap at 72 chars]

[optional footers]
Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
```

### Allowed types

| Type | When to use |
|---|---|
| `feat` | New feature or screen |
| `fix` | Bug fix |
| `refactor` | Code restructure without behavior change |
| `style` | Formatting, linting, no logic change |
| `test` | Adding or updating tests |
| `docs` | Documentation only |
| `chore` | Build scripts, deps, config, codegen |
| `perf` | Performance improvement |
| `ci` | CI/CD changes |
| `revert` | Reverting a previous commit |

### Scope examples (Flutter project)

Use the feature area, layer, or filename as scope: `auth`, `cart`, `product`, `home`, `router`, `cubit`, `service`, `model`, `di`, `firebase`, `assets`, `pubspec`.

### Rules

- Summary line: imperative mood ("add", "fix", "remove" — not "added", "fixes")
- No period at the end of the summary
- Body is optional — only include when the *why* is non-obvious
- Breaking changes: append `!` after type/scope and add `BREAKING CHANGE:` footer

## Step 4 — Confirm before committing

Show the user the exact commit command you are about to run (with full message). Wait for implicit or explicit approval by proceeding only if the user seems ready. If `$ARGUMENTS` was provided, use that as the message directly.

## Step 5 — Commit

```bash
git commit -m "$(cat <<'EOF'
<generated message here>
EOF
)"
```

If the pre-commit hook fails:
1. Read the error output carefully
2. Fix the underlying issue (lint, format, etc.) — **never use `--no-verify`**
3. Re-stage fixed files
4. Create a **new** commit (never `--amend` unless the user explicitly asks)

## Step 6 — Confirm success

Run `git status` and `git log --oneline -3` to verify the commit landed. Report the commit hash and summary to the user in one line.
