import 'package:flutter/material.dart';
import 'package:openeval/core/constants/app_constants.dart';
import 'dart:math' as math;

class EvalScore {
  final int centipawns;
  final String classification;
  final double confidence;

  EvalScore({
    required this.centipawns,
    required this.classification,
    required this.confidence,
  });

  static EvalScore classify(int centipawns) {
    final absCentipawns = centipawns.abs();
    String classification;
    if (absCentipawns >= AppConstants.brilliantThreshold) {
      classification = 'Brilliant';
    } else if (absCentipawns >= AppConstants.bestMoveThreshold) {
      classification = 'Best Move';
    } else if (absCentipawns >= AppConstants.greatThreshold) {
      classification = 'Great';
    } else if (absCentipawns >= AppConstants.inaccuracyThreshold) {
      classification = 'Inaccuracy';
    } else if (absCentipawns > AppConstants.mistakeThreshold) {
      classification = 'Mistake';
    } else {
      classification = 'Blunder';
    }
    final confidence = _sigmoidConfidence(absCentipawns);
    return EvalScore(
      centipawns: centipawns,
      classification: classification,
      confidence: confidence,
    );
  }

  static double _sigmoidConfidence(int centipawns) {
    final k = AppConstants.sigmoidK;
    final midpoint = AppConstants.sigmoidMidpoint;
    final x = (centipawns.abs() / 100.0);
    final e = math.exp(k * (midpoint - x));
    return 1.0 / (1.0 + e);
  }

  static String toLabel(String classification) {
    switch (classification) {
      case 'Brilliant': return 'Brilhante';
      case 'Best Move': return 'Melhor Lance';
      case 'Great': return 'Ótimo';
      case 'Inaccuracy': return 'Imprecisão';
      case 'Mistake': return 'Erro';
      case 'Blunder': return 'Erro Grave';
      default: return classification;
    }
  }

  static Color toColor(String classification) {
    switch (classification) {
      case 'Brilliant': return const Color(0xFF4CAF50);
      case 'Best Move': return const Color(0xFF8BC34A);
      case 'Great': return const Color(0xFFFFEB3B);
      case 'Inaccuracy': return const Color(0xFFFF9800);
      case 'Mistake': return const Color(0xFFFF5722);
      case 'Blunder': return const Color(0xFFD32F2F);
      default: return const Color(0xFF757575);
    }
  }
}
