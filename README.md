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

## Folders

- `budget_tracker/`: the Flutter app we build from lesson 5 onwards.
