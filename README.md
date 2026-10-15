# 🔄 Skill-Swap
### A Peer-to-Peer Skill Exchange Platform for Students

Skill-Swap is a Flutter-based mobile application designed to connect students who want to exchange knowledge and learn new skills from one another. The platform allows students to share the skills they can teach, discover skills they want to learn, and connect with peers for mutual learning — without monetary exchange.

Developed as a project for the **Mobile Application Development** course.

## 🎯 Project Objectives

- Enable students to create profiles and list skills they can teach and want to learn.
- Provide searchable skill listings with category-based filtering.
- Identify mutual skill matches between students.
- Allow students to send, accept, and decline skill-exchange requests.
- Support basic scheduling of skill-swap sessions.
- Build trust through post-session ratings and reviews.

## ✨ Core Features

| Feature | Description |
|---|---|
| 🔐 Authentication | Student registration and login using Firebase Authentication. |
| 👤 Student Profiles | Manage student information, department/year, and skill preferences. |
| 🧑‍🏫 Skill Management | List skills to teach and skills to learn. |
| 🔎 Browse & Search | Discover skills using search and category filters. |
| 🤝 Matching Engine | Find students with complementary skill-exchange interests. |
| 📩 Swap Requests | Send, accept, or decline exchange requests. |
| 📅 Scheduling | Arrange dates and times for skill-swap sessions. |
| ⭐ Ratings & Reviews | Rate completed exchanges and optionally provide feedback. |

*Note: These features describe the proposed functionality. Update this section as features are implemented.*

## 🛠️ Technology Stack

- **Frontend:** Flutter
- **Programming Language:** Dart
- **Authentication:** Firebase Authentication
- **Database:** Cloud Firestore
- **State Management:** Provider or Riverpod
- **Development Environment:** Visual Studio Code
- **Version Control:** Git and GitHub

### Future Technologies

- Firebase Cloud Messaging for push notifications.
- Firestore streams for real-time messaging.
- `fl_chart` for optional activity statistics.

## ⚙️ Getting Started

### Prerequisites

Make sure you have installed:

- Flutter SDK
- Dart SDK (included with Flutter)
- Visual Studio Code or Android Studio
- An Android emulator or a compatible physical device
- A Firebase project configured for the application

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/YOUR-USERNAME/Skill-Swap.git
```

**2. Navigate to the project directory**

```bash
cd Skill-Swap
```

**3. Install dependencies**

```bash
flutter pub get
```

**4. Configure Firebase**

Configure your Firebase project for the Flutter application. Follow the [official FlutterFire documentation](https://firebase.google.com/docs/flutter/setup) to connect Firebase Authentication and Cloud Firestore.

**5. Run the application**

```bash
flutter run
```

## 🧠 Matching Logic

Skill-Swap aims to identify mutually beneficial learning opportunities between students.

For example:

- Student A can teach **Flutter** and wants to learn **UI/UX Design**.
- Student B can teach **UI/UX Design** and wants to learn **Flutter**.

The application can identify these complementary interests as a mutual skill match, allowing both students to exchange knowledge.

## 👥 Project Team

This project is developed collaboratively by the following students:

| Team Member | Student ID |
|---|---|
| Muhammad Yahya Khokhar | SP24-BCS-201 |
| Sohail Ahmad | SP24-BCS-191 |
| Tauseeq Khan | FA23-BCS-075 |
| Syed Daud Shah | SP24-BCS-208 |

## 🗺️ Development Roadmap

- [ ] **Weeks 1–2:** Requirements, wireframes, Firebase setup, and authentication.
- [ ] **Weeks 3–4:** Student profiles and skill management.
- [ ] **Weeks 5–6:** Skill browsing, search, and matching engine.
- [ ] **Weeks 7–8:** Swap requests and scheduling.
- [ ] **Week 9:** Ratings, reviews, and UI improvements.
- [ ] **Week 10:** Testing, bug fixes, and documentation.

## 🚀 Future Enhancements

- Real-time in-app messaging between matched students.
- Push notifications for new matches and requests.
- Skill verification badges and peer endorsements.
- Group skill-exchange sessions and workshops.

## 🎓 Course Information

**Course:** Mobile Application Development  
**Project:** Skill-Swap — A Peer-to-Peer Skill Exchange Platform for Students  
**Platform:** Flutter (Dart)  
**Backend:** Firebase Authentication and Cloud Firestore

## 🤝 Contributions

Contributions from the project team are welcome.

1. Discuss the proposed change with the team.
2. Create a branch for your work.
3. Implement and test your changes.
4. Commit and push your changes.
5. Open a pull request if working through a fork or a branch-based review process.

Please coordinate changes to shared files to avoid merge conflicts.

## 📄 Project Status

**Status:** Under Development

This project is being developed as part of the Mobile Application Development course. Features and implementation details may evolve throughout development.

---

⭐ **Skill-Swap — Share Your Skills. Learn Together. Grow Together.**
