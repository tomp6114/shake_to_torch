# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Method Channels
-keep class com.tompvarghese.shake_to_torch.** { *; }

# Prevent obfuscation of custom classes using GSON etc. though not super strict if we just use method channels
-dontwarn io.flutter.embedding.**

# Keep our native implementation
-keep class com.tompvarghese.shake_to_torch.ShakeDetectionService { *; }
-keep class com.tompvarghese.shake_to_torch.MainActivity { *; }
