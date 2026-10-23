# Flutter from Zero: course code

This is the code for two courses on [PadiLearn](https://padilearn.com), where you build `budget_tracker`, a Naira budget tracker for Android:

- **Flutter from Zero** (free, 8 lessons): install Flutter, learn Dart, and build the app's home screen with its list of expenses.
- **Flutter from Zero 2: Finish and Ship Your App** (10 lessons): forms, saving data, live exchange rates, themes, and a release APK you can share.

## Get the code for any lesson

Every coding lesson has a tag that holds the code exactly as it is **at the end of that lesson**. The tags count straight through both courses, so course 2 carries on where course 1 stops:

| Course | Lesson | Tag |
|---|---|---|
| Flutter from Zero | 03 · Dart basics: variables, types and null safety | `lesson-03` |
| Flutter from Zero | 04 · Dart basics: functions, lists, maps and classes | `lesson-04` |
| Flutter from Zero | 05 · Your first app: main.dart and hot reload | `lesson-05` |
| Flutter from Zero | 06 · Widgets: stateless vs stateful | `lesson-06` |
| Flutter from Zero | 07 · Layout: Row, Column, Container and Expanded | `lesson-07` |
| Flutter from Zero | 08 · Showing a list of expenses | `lesson-08` |
| Flutter from Zero 2 | 01 · Forms: adding an expense, with validation | `lesson-09` |
| Flutter from Zero 2 | 02 · Moving between screens | `lesson-10` |
| Flutter from Zero 2 | 03 · Managing state across the app with Provider | `lesson-11` |
| Flutter from Zero 2 | 04 · Saving data on the phone | `lesson-12` |
| Flutter from Zero 2 | 05 · Fetching exchange rates from the internet | `lesson-13` |
| Flutter from Zero 2 | 06 · Themes: making it look good | `lesson-14` |
| Flutter from Zero 2 | 07 · Using packages from pub.dev | `lesson-15` |
| Flutter from Zero 2 | 08 · Reading error messages and debugging | `lesson-16` |
| Flutter from Zero 2 | 09 · Build a release APK and share it on WhatsApp | `lesson-17` |

Lessons 01 and 02 of the first course and lesson 10 of the second have no code of their own. **Starting with Flutter from Zero 2?** Download `lesson-08` and begin from there.

**Without git (easiest):**
1. On this repo's GitHub page, click **Tags**.
2. Find the tag for the lesson you're on, for example `lesson-08`.
3. Click **zip** to download it, then unzip it.

**With git:**
```
git clone https://github.com/Usmandankama/flutter-from-zero.git
cd flutter-from-zero
git checkout lesson-08
```

Use the tag to compare against your own code when you're stuck. Type the code yourself as you follow the lesson; that's how you learn it.

## Run the app

```
cd budget_tracker
flutter pub get
flutter run
```

Plug in your Android phone with USB debugging turned on first. Flutter from Zero, lesson 2, shows you how.

## Build an APK to share (Flutter from Zero 2, lesson 9)

```
cd budget_tracker
flutter build apk --split-per-abi
```

This makes one smaller APK per phone type in `build/app/outputs/flutter-apk/`. Send `app-arm64-v8a-release.apk`: it works on almost every Android phone made in the last several years. On a very old phone, use `app-armeabi-v7a-release.apk` instead.

The first build can take 20 minutes or more while it downloads Android build tools. Later builds are much faster.

## Folders

- `dart_basics/`: the Dart examples from Flutter from Zero, lessons 3 and 4. Run one with `dart run dart_basics/03_variables.dart`, or paste it into [DartPad](https://dartpad.dev).
- `budget_tracker/`: the Flutter app, built from Flutter from Zero lesson 5 onwards.
