import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'board_theme.dart';

class BoardThemeProvider with ChangeNotifier {
  BoardTheme _currentTheme = BoardTheme.getAllThemes()[0];

  BoardTheme get currentTheme => _currentTheme;

  void setTheme(BoardTheme theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}
