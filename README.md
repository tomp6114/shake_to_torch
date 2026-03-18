<div align="center">
  <h1>🔦 Shake-to-Torch</h1>
  <p><strong>A battery-optimized, robust background flashlight toggle application.</strong></p>

  [![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?style=for-the-badge&logo=flutter)](https://flutter.dev)
  [![Kotlin](https://img.shields.io/badge/Kotlin-Native-purple?style=for-the-badge&logo=kotlin)](https://kotlinlang.org/)
  [![Architecture](https://img.shields.io/badge/Clean-Architecture-brightgreen?style=for-the-badge)](#-architecture)
  [![State](https://img.shields.io/badge/State-BLoC-blue?style=for-the-badge)](https://bloclibrary.dev/)

</div>

---

A highly optimized, production-ready Flutter/Android application that allows users to toggle their device's flashlight merely by shaking the phone. Built from the ground up with **Clean Architecture** and integrated heavily with Native Android execution for unbroken lock-screen continuous operation.

## ✨ Key Features

- **Unbroken Background Execution**: Powered by a custom Android `Foreground Service` built natively in Kotlin, guaranteeing 100% operation even when the phone is locked, asleep, or drastically minimized!
- **Smart Debounce Algorithm**: Features a highly tuned back-and-forth shake detection algorithm that actively filters out false positives (like pacing, or accidentally dropping the device). Automatically validates acceleration vectors within a strict 500ms multi-directional window.
- **Dynamic Haptic Feedback**: Natively bonds the Android `Vibrator` dynamically with the `CameraManager.TorchCallback`, meaning perfectly synchronized haptic bumps occur on every torch toggle regardless of where it happens (UI Button, Native Quick Settings, or Shake Trigger).
- **Domain-Driven Design**: Employs scalable, highly modular **Clean Architecture** mapped elegantly into structured **Flutter BLoC** for uncompromising code decoupling.
- **100% Test-Driven Assurance**: Fully equipped with mocked **Unit tests**, rigorous UI **Widget tests**, and end-to-end device **Integration tests**.

---

## 🏗️ Clean Architecture Breakdown

This repository adopts strict Separation of Concerns:
1. **Domain Layer**: Abstract `Failure`, `UseCase`, `Result`, and Entity classes kept completely pure from Flutter or platform-specific UI frameworks.
2. **Data Layer**: Houses robust Repositories acting on boundaries (Bridging `SharedPreferences` logic and wrapping complex Native MethodChannels).
3. **Presentation Layer**: Clean, Reactive UI bounded intelligently via `flutter_bloc` state management architecture.

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `3.x+`
- Configured Android SDK / Android Studio (Target SDK 34)

### Installation

1. Clone this repository:
   ```bash
   git clone git@github.com:tomp6114/shake_to_torch.git
   cd shake_to_torch
   ```

2. Fetch all required dependencies:
   ```bash
   flutter pub get
   ```

3. Launch into the Native Emulator or Physical Device:
   ```bash
   flutter run
   ```

### 🧪 Running Tests
The project features an exhaustive multi-level testing suite guaranteeing algorithmic perfection and UI soundness:

- **Run Core Business Logic & UI Tests**: 
  ```bash
  flutter test
  ```
- **Execute End-to-End Environment Tests**: 
  ```bash
  flutter test integration_test/app_test.dart
  ```

---

## 📦 Production Deployment (Play Store)

The `build.gradle.kts` configuration logic and `proguard-rules.pro` obfuscation maps are safely configured. An isolated Upload Keystore (`key.properties`) pipeline handles the signing configs actively. 

To compile a highly-optimized release Android App Bundle (`.aab`):

```bash
flutter build aab --release
```

---

<p align="center">Built with 💙 using Flutter & Kotlin</p>
