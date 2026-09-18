import 'dart:async';
import 'package:openeval/data/services/stockfish_service.dart';
import 'package:openeval/engine/uci/uci_command.dart';
import 'package:openeval/engine/evaluator/eval_score.dart';

class StockfishEngine {
  final StockfishService _service;
  bool _isAnalyzing = false;
  final StreamController<Map<String, dynamic>> _analysisController = StreamController();

  StockfishEngine(this._service);

  bool get isAnalyzing => _isAnalyzing;
  Stream<Map<String, dynamic>> get analysisStream => _analysisController.stream;

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

  Future<void> analyzePosition(String fen, {int depth = 25, bool infinite = false}) async {
    if (_isAnalyzing) return;
    _isAnalyzing = true;
    await _service.configure(depth: depth);
    await _service.analyzePosition(fen, depth: depth, infinite: infinite);
  }

  Future<String> getBestMove(String fen) async {
    return _service.getBestMove(fen);
  }

  void stopAnalysis() {
    _isAnalyzing = false;
    _analysisController.add({'type': 'stopped'});
  }

  void dispose() {
    _analysisController.close();
    _isAnalyzing = false;
  }
}
