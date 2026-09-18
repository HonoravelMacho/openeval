import 'dart:async';
import 'package:openeval/data/services/stockfish_service.dart';
import 'package:openeval/engine/evaluator/eval_score.dart';

class StockfishEngine {
  final StockfishService _service;
  bool _isAnalyzing = false;

  StockfishEngine(this._service);

  bool get isAnalyzing => _isAnalyzing;

  Future<void> initialize() async {
    await _service.initialize();
  }

  Future<void> configure({
    int? elo,
    int depth = 25,
    bool infinite = false,
  }) async {
    await _service.configure(elo: elo, depth: depth, infinite: infinite);
  }

  void startAnalysis(String fen, {int depth = 25, bool infinite = false}) {
    _isAnalyzing = true;
    _service.startAnalysis(fen, depth: depth, infinite: infinite);
  }

  Stream<Map<String, dynamic>> get analysisStream => _service.analysisResults;

  Future<String> getBestMove(String fen) async {
    return _service.getBestMove(fen);
  }

  void stopAnalysis() {
    _isAnalyzing = false;
    _service.stop();
  }

  void dispose() {
    _service.dispose();
  }
}
