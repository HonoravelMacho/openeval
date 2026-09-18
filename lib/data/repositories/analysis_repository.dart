import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:openeval/data/models/move_analysis_model.dart';

class AnalysisRepository {
  static const String _analysesKey = 'saved_analyses';

  Future<List<MoveAnalysisModel>> getSavedAnalyses() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_analysesKey);
    if (jsonStr == null) return [];
    final list = json.decode(jsonStr) as List;
    return list.map((j) => MoveAnalysisModel(
      move: j['move'] as String,
      score: j['score'] as int,
      classification: j['classification'] as String,
      depth: j['depth'] as int,
      timeMs: (j['timeMs'] as num).toDouble(),
      pv: j['pv'] as String?,
    )).toList();
  }

  Future<void> saveAnalysis(List<MoveAnalysisModel> analyses) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _analysesKey,
      json.encode(analyses.map((a) => {
        'move': a.move,
        'score': a.score,
        'classification': a.classification,
        'depth': a.depth,
        'timeMs': a.timeMs,
        'pv': a.pv,
      }).toList()),
    );
  }

  Future<void> clearAnalyses() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_analysesKey);
  }
}
