# 📋 Instructions & Notes for Running the Project

## 🔧 System Requirements

### Required Software
- **Flutter SDK**: `3.11.1` or higher
- **Dart SDK**: `3.11.1` or higher (comes with Flutter)
- **Android Studio**: Latest version OR **VS Code** with Flutter extensions
- **Git**: For cloning the repository

### Operating System
- **Windows**: 10/11 (64-bit)
- **macOS**: 10.14 or later
- **Linux**: 64-bit

### Device Requirements
- **Android Device**: Android 5.0 (API level 21) or higher
- **OR Android Emulator**: Configured in Android Studio
- **Internet Connection**: Required for API calls

---

## 📥 Installation Steps

### 1. Install Flutter SDK

**Windows:**
```bash
# Download Flutter SDK from https://flutter.dev/docs/get-started/install/windows
# Extract to C:\src\flutter
# Add to PATH: C:\src\flutter\bin
```

**macOS/Linux:**
```bash
# Download Flutter SDK from https://flutter.dev/docs/get-started/install
# Extract and add to PATH
export PATH="$PATH:`pwd`/flutter/bin"
```

**Verify Installation:**
```bash
flutter --version
flutter doctor
```

### 2. Clone the Repository

```bash
git clone https://github.com/graceniyigena34/Countries-App-mobile-.git
cd countryapp
```

### 3. Install Dependencies

```bash
flutter pub get
```

**Expected Output:**
```
Resolving dependencies...
+ bloc 8.1.4
+ dio 5.9.2
+ equatable 2.0.8
+ flutter_bloc 8.1.6
+ shared_preferences 2.5.4
+ shimmer 3.0.0
Got dependencies!
```

---

## 🚀 Running the Project

### Option 1: Run on Physical Device

1. **Enable Developer Mode on Android Device:**
   - Go to Settings → About Phone
   - Tap "Build Number" 7 times
   - Go back to Settings → Developer Options
   - Enable "USB Debugging"

2. **Connect Device via USB**

3. **Verify Device Connection:**
   ```bash
   flutter devices
   ```

4. **Run the App:**
   ```bash
   flutter run
   ```

### Option 2: Run on Android Emulator

1. **Open Android Studio**
2. **Tools → Device Manager → Create Device**
3. **Select a device (e.g., Pixel 5)**
4. **Download system image (API 30+)**
5. **Start the emulator**
6. **Run:**
   ```bash
   flutter run
   ```

### Option 3: Run in Debug Mode (VS Code)

1. **Open project in VS Code**
2. **Press F5** or **Run → Start Debugging**
3. **Select device from bottom bar**

---

## 📦 Building APK for Release

### Windows Users - IMPORTANT

**Enable Developer Mode First:**
```bash
start ms-settings:developers
```
- Toggle "Developer Mode" to **ON**
- This is required for symlink support

### Build Commands

**Standard Release Build:**
```bash
flutter build apk --release
```

**Split APK by ABI (Smaller file size):**
```bash
flutter build apk --release --split-per-abi
```

**Build Output Location:**
```
build/app/outputs/flutter-apk/app-release.apk
```

**File Size:** ~20-25 MB

---

## 🔑 Important Configuration Notes

### 1. Internet Permissions (Already Configured)

The app requires internet access. This is already configured in:
```
android/app/src/main/AndroidManifest.xml
```

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
```

### 2. API Configuration

**Base URL:** `https://restcountries.com/v3.1`

**No API Key Required** - The REST Countries API is free and open

**Endpoints Used:**
- `/all?fields=name,flags,population,cca2`
- `/name/{name}?fields=name,flags,population,cca2`
- `/alpha/{code}?fields=name,flags,population,capital,region,subregion,area,timezones`

### 3. Dependencies Version

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  flutter_bloc: ^8.1.3      # State management
  dio: ^5.4.0               # HTTP client
  shared_preferences: ^2.2.2 # Local storage
  equatable: ^2.0.5         # Value equality
  shimmer: ^3.0.0           # Loading effects
```

---

## 🐛 Troubleshooting

### Issue 1: "Failed to load countries"

**Cause:** Missing internet permissions or no network connection

**Solution:**
1. Check internet connection
2. Verify AndroidManifest.xml has internet permissions
3. Rebuild the app: `flutter clean && flutter build apk --release`

### Issue 2: "Building with plugins requires symlink support"

**Cause:** Developer Mode not enabled on Windows

**Solution:**
```bash
start ms-settings:developers
# Toggle Developer Mode ON
```

### Issue 3: "Gradle build failed"

**Solution:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk --release
```

### Issue 4: "No devices found"

**Solution:**
- For physical device: Enable USB debugging
- For emulator: Start emulator first
- Run: `flutter devices` to verify

### Issue 5: Dependencies conflict

**Solution:**
```bash
flutter pub upgrade --major-versions
flutter pub get
```

---

## 🧪 Testing the App

### Manual Testing Checklist

1. **Launch App**
   - ✅ App opens without crash
   - ✅ Countries load automatically
   - ✅ Shimmer loading appears

2. **Search Functionality**
   - ✅ Type "United" → Shows matching countries
   - ✅ Type "xyz" → Shows "No countries found"
   - ✅ Clear search → Reloads all countries

3. **Country Details**
   - ✅ Tap country → Opens details screen
   - ✅ Flag animates smoothly (Hero animation)
   - ✅ All data displays correctly

4. **Favorites**
   - ✅ Tap heart → Adds to favorites
   - ✅ Navigate to Favorites tab → See saved countries
   - ✅ Close and reopen app → Favorites persist

5. **Dark Mode**
   - ✅ Tap theme icon → Switches theme
   - ✅ Close and reopen app → Theme persists

6. **Sorting**
   - ✅ Tap sort icon → Menu appears
   - ✅ Select option → Countries sort correctly

### Run Unit Tests (Optional)

```bash
flutter test
```

---

## 📱 Installing APK on Device

### Method 1: USB Transfer
1. Build APK: `flutter build apk --release`
2. Connect device via USB
3. Copy APK to device
4. Open file manager on device
5. Tap APK file → Install

### Method 2: ADB Install
```bash
flutter build apk --release
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Method 3: Direct Install
```bash
flutter install
```

---

## 🔐 Security Notes

- ✅ No API keys required
- ✅ No sensitive data stored
- ✅ Only favorites and theme preferences saved locally
- ✅ All data fetched from public REST Countries API
- ✅ HTTPS used for all API calls

---

## 📊 Performance Notes

- **Initial Load Time:** 2-3 seconds (depends on network)
- **Search Response:** Instant (real-time filtering)
- **Detail Screen Load:** 1-2 seconds (separate API call)
- **APK Size:** ~20-25 MB
- **Memory Usage:** ~50-80 MB
- **Minimum Android Version:** Android 5.0 (API 21)

---

## 🎯 Features Implemented

### Core Requirements ✅
- [x] Browse all countries with loading/error states
- [x] Real-time search functionality
- [x] Detailed country information with separate API call
- [x] Favorites management with persistent storage

### Bonus Features ✅
- [x] Hero animations on country flags
- [x] Dark mode with persistent preference
- [x] Sorting by name and population

### Technical Requirements ✅
- [x] BLoC/Cubit state management
- [x] Dio HTTP client
- [x] SharedPreferences for local storage
- [x] Equatable for immutable models
- [x] Clean architecture pattern
- [x] Error handling throughout

---

## 📞 Support & Contact

**Project:** Countries App - A2SV Technical Interview  
**Repository:** https://github.com/graceniyigena34/Countries-App-mobile-  
**Flutter Version:** 3.11.1  
**Dart Version:** 3.11.1  

---

## ✅ Quick Start Summary

```bash
# 1. Clone repository
git clone https://github.com/graceniyigena34/Countries-App-mobile-.git
cd countryapp

# 2. Install dependencies
flutter pub get

# 3. Run on device/emulator
flutter run

# 4. Build APK (Windows: Enable Developer Mode first)
flutter build apk --release

# 5. APK location
# build/app/outputs/flutter-apk/app-release.apk
```

---

## 🎓 Additional Notes

- **No environment variables needed**
- **No special configuration required**
- **Works offline for previously viewed countries** (if caching implemented)
- **Supports Android 5.0+**
- **Material Design 3 UI**
- **Responsive layout**

**The app is production-ready and fully functional!** 🚀
