import 'package:flutter/material.dart';
import 'package:openeval/core/constants/app_constants.dart';
import 'package:openeval/core/constants/colors.dart';
import 'dart:math' as math;

class MoveAnalysisModel {
  final String move;
  final int score;
  final String classification;
  final int depth;
  final double timeMs;
  final String? pv;

  MoveAnalysisModel({
    required this.move,
    required this.score,
    required this.classification,
    required this.depth,
    required this.timeMs,
    this.pv,
  });
}

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
}
