import 'package:openeval/data/models/move_analysis_model.dart';

class AnalysisResult {
  final List<MoveAnalysisModel> moves;
  final double precision;
  final int totalMoves;
  final String summary;

  AnalysisResult({
    required this.moves,
    required this.precision,
    required this.totalMoves,
    required this.summary,
  });

  factory AnalysisResult.fromAnalyses(List<MoveAnalysisModel> analyses) {
    final precision = analyses.isEmpty
        ? 0.0
        : (analyses.where((a) => a.score.abs() >= 50).length / analyses.length) * 100;
    final goodMoves = analyses.where((a) => a.score.abs() >= 50).length;
    final summary = 'Precision: ${precision.toStringAsFixed(1)}% | $goodMoves/${analyses.length} good moves';
    return AnalysisResult(
      moves: analyses,
      precision: precision,
      totalMoves: analyses.length,
      summary: summary,
    );
  }
}
