# Skill-Swap

> *Teach what you know. Learn what you want.*

Skill-Swap is a Flutter mobile app that helps students trade skills with each other. A student lists what they can teach and what they want to learn, and the app shows other students who are a good match. No money, just knowledge for knowledge.

**Course:** CSC303 Mobile Application Development
**Current stage:** Assignment 2, static UI (tag `A2`)

---

## Team

| Name | Roll No. |
|---|---|
| Muhammad Yahya Khokhar | SP24-BCS-201 |
| Sohail Ahmad | SP24-BCS-191 |
| Tauseeq Khan | SP23-BCS-075 |
| Syed Daud Shah | SP24-BCS-208 |

---

## Problem

Students have skills their classmates want to learn (coding, design, languages, music, tutoring), but there is no simple way to find who has what. WhatsApp groups get buried, word of mouth only reaches your own circle, and paid tutoring is not built for free, mutual exchange. Skill-Swap gives students one place to list, search and match skills.

---

## What is in Assignment 2

This stage is the **look of the app only**. All data is dummy data and there is no navigation, database or API yet.

### Screens

| Screen | Purpose |
|---|---|
| Splash | Logo, app name and tagline |
| Login | Email and password fields with a Login button (look only) |
| Home | Banner and a list of suggested student matches |
| Student Detail | One student's profile: skills they teach and want, rating, action buttons |
| Add Skill (Profile Setup) | Form to enter name, department, skill to teach, skill to learn |

### Main entity: `Student`

| Field | Example |
|---|---|
| name | Ayesha Khan |
| department | BS Computer Science, Year 2 |
| teaches | Flutter |
| wants | Graphic Design |
| rating | 4.8 |
| image | assets/images/student1.png |

### Reusable widget

`StudentCard` takes a `Student` and shows an avatar, name, department, skills and rating. It is used 4 times on the Home screen with different dummy data.

---

## Project structure

```
lib/
├── main.dart                      # starts the app, sets the theme
├── models/
│   └── student.dart               # Student class (the main entity)
├── widgets/
│   └── student_card.dart          # reusable card for one student
└── screens/
    ├── splash_screen.dart
    ├── login_screen.dart
    ├── home_screen.dart
    ├── student_detail_screen.dart
    └── add_skill_screen.dart
assets/
└── images/                        # logo, banner, 4 student avatars
```

Every screen is its own `StatelessWidget`. To see a different screen, change the `home:` line in `lib/main.dart`.

---

## How to run

You need [Flutter](https://docs.flutter.dev/get-started/install) installed.

```bash
git clone <repo-url>
cd Skill-Swap
flutter pub get
flutter run -d chrome
```

You can also run it on an Android emulator or a connected phone: use `flutter devices` to see the options, then `flutter run -d <device-id>`.

To change the screen shown, open `lib/main.dart` and edit:

```dart
home: const HomeScreen(),   // try SplashScreen(), LoginScreen(), etc.
```

---

## Screenshots

| Splash | Login | Home |
|---|---|---|
| ![Splash](screenshots/splash.png) | ![Login](screenshots/login.png) | ![Home](screenshots/home.png) |

| Student Detail | Add Skill |
|---|---|
| ![Detail](screenshots/detail.png) | ![Add Skill](screenshots/add_skill.png) |

---

## Roadmap

| Assignment | What gets added |
|---|---|
| **A2 (this stage)** | Static UI for all main screens |
| **A3** | Navigation between screens and interactive widgets |
| **A4** | Saved data (Firebase Authentication and Cloud Firestore) and a device or API feature |

Planned features from the proposal: sign up and login, profile with teach and want lists, search and category filters, mutual matching, swap requests (send, accept, decline), session scheduling, and post-swap ratings.

---

## Built with

- Flutter and Dart
- Material widgets only at this stage (`Scaffold`, `AppBar`, `Row`, `Column`, `Expanded`, `Card`, `ListTile`, `Image.asset`, `TextField`, `ElevatedButton`)
- Planned for later: Firebase Authentication, Cloud Firestore, Provider or Riverpod