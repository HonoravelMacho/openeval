import 'package:openeval/engine/evaluator/eval_score.dart';

class Evaluator {
  static List<EvalScore> evaluateMoveSequence(List<int> scores) {
    return scores.map((s) => EvalScore.classify(s)).toList();
  }

  static double calculatePrecision(List<EvalScore> scores) {
    if (scores.isEmpty) return 0.0;
    var correctCount = 0;
    for (final score in scores) {
      if (score.classification == 'Brilliant' || score.classification == 'Best Move' || score.classification == 'Great') {
        correctCount++;
      }
    }
    return correctCount / scores.length;
  }

  static List<Map<String, dynamic>> generatePrecisionChart(List<EvalScore> scores) {
    return scores.asMap().entries.map((entry) {
      final index = entry.key;
      final score = entry.value;
      return {
        'index': index,
        'score': score.centipawns,
        'classification': score.classification,
        'confidence': score.confidence,
        'precision': calculatePrecision(scores.sublist(0, index + 1)),
      };
    }).toList();
  }
}
