# OpenEval 🎯♟️

**Open Source Chess Analysis Engine powered by Stockfish**

[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Flutter](https://img.shields.io/badge/Flutter-3.44.9-blue)](https://flutter.dev)
[![Stockfish](https://img.shields.io/badge/Stockfish-Local-informational)](https://stockfishchess.org)
[![CI/CD](https://github.com/HonoravelMacho/openeval/actions/workflows/build-apk.svg)](https://github.com/HonoravelMacho/openeval/actions)

OpenEval is a powerful, fully local chess analysis engine for Android. Import games from Chess.com, analyze them with the legendary Stockfish engine, play against bots with adjustable ratings, or enjoy local multiplayer pass-and-play mode. **100% offline, 100% private.**

---

## ✨ Features

### 📥 Importador & Analisador de Partidas
- **Chess.com PubAPI Integration**: Paste any Chess.com live or daily game URL
- **Automatic PGN Fetch & Parse**: Download games and parse locally
- **Full Game Metadata**: Event, players, Elo ratings, results

### 🧠 Engine de Análise Local (Stockfish)
- **100% Offline & Local**: All analysis happens on your device via native Kotlin plugin
- **MethodChannel Integration**: Real-time UCI protocol communication with Flutter
- **Adjustable Depth**: Set analysis depth from 15 to 40+ ply
- **Infinite Mode**: No limits on analysis time or depth
- **Isolate-Based Processing**: Runs in separate Dart isolates for smooth UI
- **Chess.com-Style Classification**:
  | Classification | Centipawns | Color |
  |---|---|---|
  | 🌟 **Brilhante** | ≥ 100 | Green |
  | ⭐ **Melhor Lance** | ≥ 75 | Light Green |
  | 📈 **Ótimo** | ≥ 50 | Yellow |
  | ⚠️ **Imprecisão** | ≥ 25 | Orange |
  | ❌ **Erro** | ≥ 1 | Deep Orange |
  | 💥 **Erro Grave** | 0 | Red |
- **Sigmoid Evaluation Bar**: Visual representation of position evaluation
- **Precision Graph**: Track accuracy percentage throughout the game

### 🤖 Partida vs. Bots (Rating Regulável)
- **UCI Engine Integration**: Full UCI protocol support (`UCI_LimitStrength`, `UCI_Elo`)
- **Elo Range**: 200 to 2500 Elo slider
- **Configurable Parameters**: Skill level, depth, and play style

### 👥 Multiplayer Local (Pass & Play)
- **2 Players, Same Device**: Classic pass-and-play mode
- **180° Board Rotation**: Automatic board rotation after each move
- **Auto PGN Export**: One-tap PGN generation
- **Deep Analysis Button**: Instant deep analysis of any position

---

## 🏗️ Architecture

OpenEval follows a **strictly modular architecture** with clear separation of concerns:

```
lib/
├── core/                          # Core infrastructure
│   ├── constants/                 # App constants, colors, sizes
│   ├── theme/                     # Visual theming system
│   │   ├── board_themes/          # 🎨 Add new board themes here
│   │   └── piece_sets/            # ♟️ Add new piece sets here
│   └── utils/                     # Converters, validators
├── data/                          # Data layer
│   ├── models/                    # Data models
│   ├── services/                  # API & engine services
│   │   ├── stockfish_service.dart # MethodChannel integration
│   │   └── api_manager.dart       # Chess.com API
│   └── repositories/              # Data repositories
├── engine/                        # Chess engine layer
│   ├── stockfish/                 # Stockfish UCI integration
│   ├── evaluator/                 # Position evaluation & scoring
│   └── uci/                       # UCI command & parser
├── features/                      # Feature modules
│   ├── game_importer/             # Chess.com game import
│   ├── analysis/                  # Game analysis engine
│   ├── bot_play/                  # Bot vs player mode
│   ├── local_multiplayer/         # Local pass-and-play
│   └── settings/                  # App settings
└── widgets/                       # Shared UI components
```

---

## 🎨 Adding New Board Themes

Contributors can add new board themes by following these steps:

1. Open `lib/core/theme/board_themes/board_theme.dart`
2. Add your new theme to the `getAllThemes()` list:

```dart
BoardTheme(
  name: 'Your Theme Name',
  lightSquare: Color(0xFFXXXXXX),
  darkSquare: Color(0xFFXXXXXX),
  description: 'Description of your theme.',
)
```

3. Save and your theme is automatically available in **Settings > Board Theme**!

---

## ♟️ Adding New Piece Sets

Contributors can add new piece sets by following these steps:

1. Open `lib/core/theme/piece_sets/piece_set.dart`
2. Add your piece symbols to the `getAllSets()` list:

```dart
PieceSet(
  name: 'Your Piece Set',
  assetPrefix: 'assets/pieces/your_set/',
  pieceSymbols: {
    'wK': '\u2654', // White King
    'wQ': '\u2655', // White Queen
    // ... all pieces
  },
  description: 'Description of your piece set.',
)
```

3. Optionally add piece SVG/PNG assets to `assets/pieces/your_set/`
4. Save and your piece set is automatically available in **Settings > Piece Set**!

---

## 🛠️ Development Setup

### Prerequisites
- Flutter 3.44.9
- Dart 3.12.2
- Java 17.0.19
- Android SDK (API 33-37)

### Installation
```bash
git clone https://github.com/HonoravelMacho/openeval.git
cd openeval
flutter pub get
flutter run
```

### Build Release APK
```bash
flutter build apk --release
```

---

## 📜 License

This project is licensed under the **GNU General Public License v3.0 (GPLv3)**.

See the [LICENSE](LICENSE) file for details.

By contributing to OpenEval, you agree that your contributions will be licensed under GPLv3.

---

## 🤝 Contributing

Contributions are welcome! Please see the [Contributing Guide](CONTRIBUTING.md) for details.

### Quick Start for Contributors
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to your branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📱 Supported Platforms
- [x] Android (API 21+)

---

## 🔗 Links
- [GitHub Repository](https://github.com/HonoravelMacho/openeval)
- [Stockfish Chess Engine](https://stockfishchess.org)
- [Chess.com PubAPI](https://api.chess.com/pub)
- [Flutter Documentation](https://flutter.dev)

---

<div align="center">

Made with ❤️ by the OpenEval community | **GPLv3**

</div>
