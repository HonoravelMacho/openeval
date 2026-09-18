import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:openeval/core/theme/board_themes/board_theme.dart';
import 'package:openeval/core/theme/piece_sets/piece_set.dart';

class SettingsController extends ChangeNotifier {
  BoardTheme _boardTheme = BoardTheme.getAllThemes()[0];
  PieceSet _pieceSet = PieceSet.getAllSets()[0];
  bool _soundEnabled = true;
  bool _animationsEnabled = true;

  BoardTheme get boardTheme => _boardTheme;
  PieceSet get pieceSet => _pieceSet;
  bool get soundEnabled => _soundEnabled;
  bool get animationsEnabled => _animationsEnabled;

  void setBoardTheme(BoardTheme theme) {
    _boardTheme = theme;
    notifyListeners();
  }

  void setPieceSet(PieceSet set) {
    _pieceSet = set;
    notifyListeners();
  }

  void toggleSound() {
    _soundEnabled = !_soundEnabled;
    notifyListeners();
  }

  void toggleAnimations() {
    _animationsEnabled = !_animationsEnabled;
    notifyListeners();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sound_enabled', _soundEnabled);
    await prefs.setBool('animations_enabled', _animationsEnabled);
  }
}
