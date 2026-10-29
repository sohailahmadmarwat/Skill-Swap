# SkillSwap

A semester Flutter project: a student skill-exchange app with a dark neon / glassmorphism UI. Students teach one skill and learn another.

## Screens (13)

**Fully functional (5)**

| Screen | File | What works |
|---|---|---|
| Login / Sign Up | `login_screen.dart` | Tab switch, validation, password show/hide, logs in to `UserSession` |
| Home | `home_screen.dart` | Time-based greeting for the logged-in user, live search, category filter, favourites, notifications sheet, drawer, bottom nav |
| Search | `search_screen.dart` | Live search, category pills, popular skill chips, student list |
| Profile | `student_detail_screen.dart` | Shows the logged-in user, or another student when opened from a card; Send Request; date picker |
| Edit Profile | `edit_profile_screen.dart` | Pre-filled form, live first-letter avatar, add/remove skills, saves to session |

**Navigation-only (8)** - UI matches the design and the screens link together, with no saved data:
Splash, Matching ("It's a Match!"), Chat, Send Swap Request, Schedule, Messages, Rating, and the Navigation Drawer.

## Project structure

```
lib/
  main.dart                 app, theme, named routes, global background
  theme/colors.dart         colours, gradients, glass card decoration
  models/
    student.dart            Student model (Set, Map, Record helpers)
    user_session.dart       the currently logged-in user
    chat_message.dart       message and conversation models
  widgets/
    user_avatar.dart        avatar with first-letter fallback
    student_card.dart       reusable student card
    app_drawer.dart         side drawer
  screens/                  one file per screen
assets/images/              logo, backgrounds, illustrations, student photos
```

## Key behaviour

- **Logged-in user:** `UserSession.currentUser` is set at login and used by the greeting, avatar, drawer, profile, match and rating screens. Nothing is hard-coded to one name.
- **Avatar fallback:** a student without a photo shows the first letter of their name.
- **Greeting:** "Good morning / afternoon / evening, <first name>" from `DateTime.now().hour`.
- **Routes:** `/`, `/login`, `/home`, `/search`, `/student-detail`, `/my-profile`, `/match`, `/chat`, `/request`, `/schedule`, `/messages`, `/rating`, `/edit-profile`.

## Course topics used

MaterialApp, StatelessWidget / StatefulWidget, setState, Row, Column, SizedBox, Container, buttons, icons, GestureDetector, ListView.builder, TextField, Navigator, ListTile, CircleAvatar, Card, Sets, Maps, Records, functions, conditional operators. No state-management or other external packages.

## Run it

```bash
flutter pub get
flutter run -d chrome --web-port=5000   # browser
```

**On an Android phone:** enable USB debugging, connect by cable, tap "Allow", then double-click `run_mobile.bat` (debug mode: `r` hot reload, `R` hot restart, `q` quit).

After adding new files to `assets/`, stop and run the app again; hot restart does not pick up new assets.

## Notes

- Images other than the student photos were AI-generated. Replace the files in `assets/images/` (keeping the names) to use the original Figma artwork.
- The 8 navigation-only screens use sample data and do not save anything.
