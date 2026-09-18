import 'package:flutter/material.dart';

class BoardTheme {
  final String name;
  final Color lightSquare;
  final Color darkSquare;
  final String? previewAsset;
  final String description;

  BoardTheme({
    required this.name,
    required this.lightSquare,
    required this.darkSquare,
    this.previewAsset,
    required this.description,
  });

  static List<BoardTheme> getAllThemes() {
    return [
      BoardTheme(
        name: 'Classic',
        lightSquare: Color(0xFFECE4D0),
        darkSquare: Color(0xFF769656),
        description: 'Classic wooden board with traditional colors.',
      ),
      BoardTheme(
        name: 'Dark Forest',
        lightSquare: Color(0xFFA7B38C),
        darkSquare: Color(0xFF3D5A3D),
        description: 'Deep green dark theme for reduced eye strain.',
      ),
      BoardTheme(
        name: 'Marble',
        lightSquare: Color(0xFFF0ECE6),
        darkSquare: Color(0xFF4A4A4A),
        description: 'Elegant marble-inspired color scheme.',
      ),
      BoardTheme(
        name: 'Neon',
        lightSquare: Color(0xFF1A1A2E),
        darkSquare: Color(0xFFE94560),
        description: 'High-contrast neon theme for modern look.',
      ),
      BoardTheme(
        name: 'Ocean',
        lightSquare: Color(0xFF89CFF0),
        darkSquare: Color(0xFF1B4965),
        description: 'Calming ocean-inspired colors.',
      ),
    ];
  }
}
