# Flutter Firebase Notes App with Auth and Speech

A full-featured notes application built with Flutter and Firebase, featuring user authentication, cloud storage, image uploads, and speech-to-text capabilities.

## 🚀 Features

- **User Authentication** - Secure sign-up and login using Firebase Auth
- **Cloud Sync** - Real-time note synchronization across devices using Cloud Firestore
- **Image Support** - Attach images to notes with Firebase Storage
- **Speech-to-Text** - Voice input for note creation
- **State Management** - Efficient state management using Provider
- **Cross-Platform** - Runs on Android, iOS, Web, Windows, macOS, and Linux

## 🛠️ Technologies Used

### Framework & Language
- **Flutter** ^3.9.2 - Cross-platform UI framework
- **Dart** ^3.9.2 - Programming language

### Firebase Services
- **Firebase Core** ^3.6.0 - Firebase SDK initialization
- **Firebase Auth** ^5.3.1 - User authentication and authorization
- **Cloud Firestore** ^5.4.4 - NoSQL cloud database for real-time data sync
- **Firebase Storage** ^12.3.3 - Cloud storage for images and files

### State Management
- **Provider** ^6.1.2 - Simple and scalable state management solution

### Features & Functionality
- **Image Picker** ^1.1.2 - Select images from gallery or camera
- **Speech to Text** ^7.0.0 - Convert voice input to text
- **Cupertino Icons** ^1.0.8 - iOS-style icons

## 📋 Prerequisites

Before running this project, ensure you have:

- Flutter SDK (3.9.2 or higher)
- Dart SDK (3.9.2 or higher)
- Firebase project with Auth, Firestore, and Storage enabled
- Android Studio / Xcode (for mobile development)
- A code editor (VS Code, Android Studio, or IntelliJ IDEA)

## 🔧 Installation

1. Clone the repository:
```bash
git clone https://github.com/Muhammad-Talha-Ayub/flutter-firebase-notes-app-with-auth-and-speech.git
cd flutter-firebase-notes-app-with-auth-and-speech
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication, Cloud Firestore, and Storage
   - Download configuration files:
     - `google-services.json` for Android (place in `android/app/`)
     - `GoogleService-Info.plist` for iOS (place in `ios/Runner/`)
   - Run Firebase CLI configuration:
   ```bash
   flutterfire configure
   ```

4. Run the app:
```bash
flutter run
```

## 📱 Platform-Specific Setup

### Android
- Minimum SDK: 21
- Target SDK: 33
- Place `google-services.json` in `android/app/`

### iOS
- iOS Deployment Target: 12.0
- Place `GoogleService-Info.plist` in `ios/Runner/`
- Update permissions in `Info.plist` for camera, microphone, and photo library access

### Web
- Firebase configuration will be auto-generated during `flutterfire configure`

## 🎯 Usage

1. **Sign Up/Login** - Create an account or login with existing credentials
2. **Create Notes** - Tap the add button to create a new note
3. **Voice Input** - Use the microphone button to dictate notes
4. **Add Images** - Attach images from your gallery or camera
5. **Sync** - Notes automatically sync across all your devices

## 📁 Project Structure

```
lib/
├── main.dart           # App entry point
├── models/            # Data models
├── providers/         # State management (Provider)
├── screens/          # UI screens
├── services/         # Firebase services
└── widgets/          # Reusable widgets
```

## 🔒 Security

- User authentication via Firebase Auth
- Firestore security rules protect user data
- Storage rules ensure users can only access their own files

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📦 Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👤 Author

**Your Name**
- GitHub: [@Muhammad-Talha-Ayub](https://github.com/Muhammad-Talha-Ayub)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- All package contributors

## 👥 Team

- **Lead Developer**: Muhammad Talha Ayub
- **Tech Stack**: Flutter, Firebase, Provider

