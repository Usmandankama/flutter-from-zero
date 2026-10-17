# Flutter from Zero: course code

This is the code for **Flutter from Zero: Build and Ship Your First App** on [PadiLearn](https://padilearn.com). Across the course you build `budget_tracker`, a Naira budget tracker for Android.

## Get the code for any lesson

Every coding lesson has a tag (`lesson-03`, `lesson-04` … `lesson-18`) that holds the code exactly as it is **at the end of that lesson**.

**Without git (easiest):**
1. On this repo's GitHub page, click **Tags**.
2. Find the lesson you're on, for example `lesson-08`.
3. Click **zip** to download it, then unzip it.

**With git:**
```
git clone <repo-url>
cd <repo-folder>
git checkout lesson-08
```

Use the tag to compare against your own code when you're stuck. Type the code yourself as you follow the lesson; that's how you learn it.

## Run the app

```
cd budget_tracker
flutter pub get
flutter run
```

Plug in your Android phone with USB debugging turned on first. Lesson 2 shows you how.

## Build an APK to share (lesson 17)

```
cd budget_tracker
flutter build apk --split-per-abi
```

This makes one smaller APK per phone type in `build/app/outputs/flutter-apk/`. Send `app-arm64-v8a-release.apk`: it works on almost every Android phone made in the last several years. On a very old phone, use `app-armeabi-v7a-release.apk` instead.

The first build can take 20 minutes or more while it downloads Android build tools. Later builds are much faster.

## Folders

- `dart_basics/`: the Dart examples from lessons 3 and 4. Run one with `dart run dart_basics/03_variables.dart`, or paste it into [DartPad](https://dartpad.dev).
- `budget_tracker/`: the Flutter app we build from lesson 5 onwards.
