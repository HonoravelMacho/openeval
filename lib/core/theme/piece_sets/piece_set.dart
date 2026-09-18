import 'package:flutter/material.dart';

class PieceSet {
  final String name;
  final String? assetPrefix;
  final Map<String, String> pieceSymbols;
  final String description;

  PieceSet({
    required this.name,
    this.assetPrefix,
    required this.pieceSymbols,
    required this.description,
  });

  static Map<String, String> defaultSymbols() {
    return {
      'wK': '\u2654', 'wQ': '\u2655', 'wR': '\u2656',
      'wB': '\u2657', 'wN': '\u2658', 'wP': '\u2659',
      'bK': '\u265A', 'bQ': '\u265B', 'bR': '\u265C',
      'bB': '\u265D', 'bN': '\u265E', 'bP': '\u265F',
    };
  }

  static Map<String, String> crystalSymbols() {
    return {
      'wK': '\u2B1B', 'wQ': '\u2B1B', 'wR': '\u2B1B',
      'wB': '\u2B1B', 'wN': '\u2B1B', 'wP': '\u2B1B',
      'bK': '\u2B1C', 'bQ': '\u2B1C', 'bR': '\u2B1C',
      'bB': '\u2B1C', 'bN': '\u2B1C', 'bP': '\u2B1C',
    };
  }

  static List<PieceSet> getAllSets() {
    return [
      PieceSet(
        name: 'Standard',
        assetPrefix: 'assets/pieces/standard/',
        pieceSymbols: defaultSymbols(),
        description: 'Standard Unicode chess symbols.',
      ),
      PieceSet(
        name: 'Crystal',
        assetPrefix: 'assets/pieces/crystal/',
        pieceSymbols: crystalSymbols(),
        description: 'Crystal-inspired geometric pieces.',
      ),
    ];
  }
}
