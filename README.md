# TIC TAC TOE

A Flutter implementation of Tic Tac Toe, with local game persistence, game history, animations, and a feature-first clean architecture approach.

## Using FVM (Flutter Version Manager)

This project is intended to be used with FVM to ensure consistent Flutter/Dart versions across environments.

- Documentation FVM: https://fvm.app/documentation/getting-started

## Quick start

### 1) Install dependencies

```bash
fvm flutter pub get
```

### 2) Generate code

This project uses code generation (Riverpod annotations, AutoRoute, JSON serialization, etc.).

```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

### 3) Run the application

```bash
fvm flutter run
```

### 4) Check translations (optional)

```bash
dart run easy_localization:audit
```

## Architecture

The project follows a feature-first organization with clear separation of responsibilities (inspired by Clean Architecture).

```text
lib/
├── main.dart                      # Flutter initialization + EasyLocalization + orientation
├── app.dart                       # MaterialApp.router + theme + localization
├── features/
│   ├── game/
│   │   ├── data/                  # datasource, DTO, repository implementation
│   │   ├── domain/                # entities, abstract repository, use cases
│   │   └── presentation/          # pages, providers, widgets
│   ├── game_history/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── home/
│       ├── domain/
│       └── presentation/
└── shared/
    ├── constant.dart
    ├── errors/
    ├── extensions/
    ├── presentation/              # shared widgets + local DB provider
    ├── router/                    # AutoRoute config + generated files
    ├── service/                   # abstraction + SharedPreferences implementation
    └── theme.dart
```

### State management & DI

- `flutter_riverpod` / `hooks_riverpod`
- `riverpod_annotation`

### Navigation

- `auto_route`
- Main routes:
  - `Home`
  - `Game`
  - `GameHistory`

### Local persistence

- `SharedPreferences` via a `LocalDatabaseService`
- Games are serialized and stored locally


## Features

- Start a new game
- Resume an ongoing game
- Play against a local AI (random move)
- Win and draw detection
- Give up a game
- Game history
- Animated UI (Lottie + `flutter_animate`)
- French localization via `easy_localization`

## Design System

- Custom theme (centralized colors)
- Google Fonts typography
- Shared UI widgets (scaffold, buttons, loading, animations)

## Tests

Tests are organized by feature in `test/feature`.

### Run all tests

```bash
fvm flutter test
```

## Tech stack

- Flutter / Dart
- Riverpod (state management)
- AutoRoute (routing)
- Easy Localization (i18n)
- Shared Preferences (storage)
- Freezed / JSON Serializable (modeling + serialization)
- Lottie + Flutter Animate (animations)

## Notes

- Portrait orientation is enforced.
- Locale is currently configured to French (`fr`).
- Main assets: `assets/icons`, `assets/images`, `assets/lottie`, `assets/translations`.
