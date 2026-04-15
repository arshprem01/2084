<div align="center">
  <h1>🎮 Flutter 2048</h1>
  <p><strong>A beautifully crafted, feature-rich 2048 puzzle game built with Flutter.</strong></p>

  <p>
    <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter" /></a>
    <a href="https://dart.dev"><img src="https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" /></a>
    <a href="#"><img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-lightgrey.svg?style=for-the-badge" alt="Platforms" /></a>
    <a href="https://github.com/arshprem01/2084/stargazers"><img src="https://img.shields.io/github/stars/arshprem01/2084?style=for-the-badge&color=yellow" alt="Stars" /></a>
    <a href="https://github.com/arshprem01/2084/network/members"><img src="https://img.shields.io/github/forks/arshprem01/2084?style=for-the-badge&color=orange" alt="Forks" /></a>
    <a href="https://github.com/arshprem01/2084/issues"><img src="https://img.shields.io/github/issues/arshprem01/2084?style=for-the-badge&color=red" alt="Issues" /></a>
    <a href="https://github.com/arshprem01/2084/blob/main/LICENSE"><img src="https://img.shields.io/github/license/arshprem01/2084?style=for-the-badge&color=green" alt="License" /></a>
  </p>
</div>

---

## ✨ Overview

Welcome to **Flutter 2048**, an immersive and aesthetically stunning take on the classic sliding tile puzzle game. Designed with modern architecture and breathtaking UI/UX, this open-source project showcases how far you can push Flutter's animation and state management capabilities.

Dive into fluid tile animations, dynamically animated backgrounds, robust settings, and a fully polished user experience right out of the box.

---

## 🚀 Features

- **Fluid Animations:** Smooth tile merging, spawning, and sliding animations.
- **Dynamic Environments:** Mesmerizing, performance-optimized animated backgrounds.
- **Full App Navigation:** Includes a beautiful Splash Screen, Main Menu, Game Screen, Settings, and Credits.
- **State Management:** Clean separation of logic with built-in Game and Settings Managers.
- **Cross-Platform:** Runs flawlessly on Android, iOS, Web, and Desktop environments.
- **Customizable:** Easily extendable architecture for themes, grid sizes, and game modes.

---

## 📸 Screenshots

*(Maintainers: Replace these placeholders with actual screenshots from your app)*

| Splash Screen | Main Menu | Gameplay | Settings |
| :---: | :---: | :---: | :---: |
| <img src="https://via.placeholder.com/250x500.png?text=Splash+Screen" width="200"/> | <img src="https://via.placeholder.com/250x500.png?text=Main+Menu" width="200"/> | <img src="https://via.placeholder.com/250x500.png?text=Gameplay" width="200"/> | <img src="https://via.placeholder.com/250x500.png?text=Settings" width="200"/> |

---

## 🗂️ Project Structure

Clean architecture ensures maintainability and scalability.

```text
lib/
├── models/
│   ├── game_manager.dart       # Core 2048 logic, state, and score management
│   ├── settings_manager.dart   # App preferences and configurations
│   └── tile.dart               # Tile data properties
├── screens/
│   ├── credits_screen.dart     # Developer & acknowledgment screen
│   ├── game_screen.dart        # The main gameplay board UI
│   ├── main_menu_screen.dart   # Play, Settings, and Credits hub
│   ├── settings_screen.dart    # Preferences configuration
│   └── splash_screen.dart      # Init loading UI
├── widgets/
│   ├── animated_background.dart # Dynamic, breathing background effect
│   └── animated_tile.dart       # Tile physics, merging, and movement animations
└── main.dart                   # Application entry point
```

---

## 🛠️ Getting Started

### Prerequisites

- Flutter SDK `^3.11.1` or higher.
- Dart SDK
- An IDE (VS Code, Android Studio, IntelliJ)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/arshprem01/2084.git
   cd 2084
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the application:**
   ```bash
   flutter run
   ```

---

## 🕹️ How to Play

1. Slide across the screen to move the tiles (Up, Down, Left, Right).
2. When two tiles with the same number touch, they **merge into one!**
3. Your goal is to keep merging tiles to reach the infamous **2048 tile**.
4. The game ends when the board fills up and no valid moves are possible.

---

## 🤝 Contributing

Contributions, issues, and feature requests are highly welcome!
Feel free to check out the [issues page](https://github.com/arshprem01/2084/issues).

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📝 License

Distributed under the MIT License. See `LICENSE` for more information.

---

<div align="center">
  <sub>Built with ❤️ by <a href="https://github.com/arshprem01">arshprem01</a></sub>
</div>
