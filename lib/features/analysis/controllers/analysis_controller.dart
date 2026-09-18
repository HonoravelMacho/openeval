import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:openeval/data/services/stockfish_service.dart';
import 'package:openeval/engine/stockfish/stockfish_engine.dart';
import 'package:openeval/data/repositories/analysis_repository.dart';
import 'package:openeval/data/models/move_analysis_model.dart';
import 'package:openeval/engine/evaluator/eval_score.dart' as eval;

class AnalysisController extends ChangeNotifier {
  final StockfishEngine _engine;
  final AnalysisRepository _repository;
  final List<MoveAnalysisModel> _analyses = [];
  double _precision = 0.0;
  int _currentDepth = 25;
  bool _isAnalyzing = false;
  String _status = 'Ready';
  String _currentFen = 'startpos';

  AnalysisController({
    StockfishEngine? engine,
    AnalysisRepository? repository,
  })  : _engine = engine ?? StockfishEngine(StockfishService.instance),
        _repository = repository ?? AnalysisRepository();

  List<MoveAnalysisModel> get analyses => List.unmodifiable(_analyses);
  double get precision => _precision;
  int get currentDepth => _currentDepth;
  bool get isAnalyzing => _isAnalyzing;
  String get status => _status;
  String get currentFen => _currentFen;

  Future<void> startAnalysis(String fen, {int depth = 25, bool infinite = false}) async {
    _currentFen = fen;
    _isAnalyzing = true;
    _status = 'Analyzing...';
    _currentDepth = depth;
    notifyListeners();

    await _engine.initialize();
    await _engine.configure(depth: depth, infinite: infinite);

    _engine.analysisStream.listen((data) {
      _updateAnalysis(data);
    }, onDone: () {
      _isAnalyzing = false;
      _status = 'Analysis complete';
      calculatePrecision();
      notifyListeners();
    }, onError: (e) {
      _isAnalyzing = false;
      _status = 'Error: ${e.toString()}';
      notifyListeners();
    });

    _engine.startAnalysis(fen, depth: depth, infinite: infinite);
  }

  void _updateAnalysis(Map<String, dynamic> data) {
    if (data.containsKey('score')) {
      final score = data['score'] as int;
      final evalScore = eval.EvalScore.classify(score);
      _analyses.add(MoveAnalysisModel(
        move: data['currmove'] ?? '',
        score: score,
        classification: evalScore.classification,
        depth: data['depth'] ?? 0,
        timeMs: (data['time'] ?? 0).toDouble(),
        pv: data['pv'] as String?,
      ));
      notifyListeners();
    }
  }

  void calculatePrecision() {
    _precision = _analyses.isEmpty
        ? 0.0
        : (_analyses.where((a) => a.score.abs() >= 50).length / _analyses.length) * 100;
    _repository.saveAnalysis(_analyses);
    notifyListeners();
  }

  void setDepth(int depth) {
    _currentDepth = depth;
    notifyListeners();
  }

  void stopAnalysis() {
    _engine.stopAnalysis();
    _isAnalyzing = false;
    _status = 'Stopped';
    notifyListeners();
  }

  @override
  void dispose() {
    _engine.dispose();
    super.dispose();
  }
}
