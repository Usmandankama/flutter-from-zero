# Release builds shrink the app's Android code: they remove anything that looks
# unused and give what's left shorter names. shared_preferences_android 2.5.0
# is called from Dart by name, so it breaks when its methods, or the Kotlin
# types they use, get renamed. The app then stops on the loading spinner.
# These lines keep those names as they are.
-keep class io.flutter.plugins.sharedpreferences.** { *; }
-keep class kotlin.coroutines.** { *; }
-keep class kotlin.Result** { *; }
-keep class kotlin.Unit { *; }
