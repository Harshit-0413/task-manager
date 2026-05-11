# Flutter Task Manager App

A clean and responsive Task Manager mobile application built using Flutter and Firebase.  
This application allows users to securely manage daily tasks with real-time cloud storage and motivational quote integration.

## Features

- Firebase Authentication
  - User Sign Up
  - User Login
  - Logout Functionality

- Task Management (Cloud Firestore)
  - Add Tasks
  - Edit Tasks
  - Delete Tasks
  - Mark Tasks as Completed

- REST API Integration
  - Fetches motivational quotes dynamically
  - Fallback handling for API failures

- Clean UI & UX
  - Responsive interface
  - Form validation
  - Loading indicators
  - Error handling

---

## Tech Stack

- Flutter
- Dart
- Firebase Authentication
- Cloud Firestore
- REST API Integration

---

## Folder Structure

```txt
lib/
 ├── models/
 ├── screens/
 ├── services/
 ├── widgets/
 └── main.dart
```

---

## Firebase Setup

To run this project locally:

1. Create a Firebase project
2. Enable Firebase Authentication
3. Enable Cloud Firestore
4. Add your own `google-services.json` file inside:

```txt
android/app/
```

---

## Getting Started

Clone the repository:

```bash
git clone <repository_link>
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

Build release APK:

```bash
flutter build apk --release
```

---

## APK

Release APK is included separately in the submission.

---

