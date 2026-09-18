import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:openeval/data/models/game_model.dart';
import 'package:openeval/data/models/pgn_game_model.dart';
import 'package:openeval/data/services/api_manager.dart';

class GameRepository {
  final ApiManager _apiManager;
  static const String _gamesKey = 'saved_games';

  GameRepository({ApiManager? apiManager}) : _apiManager = apiManager ?? ApiManager();

  Future<PgnGameModel> fetchGameByUrl(String url) async {
    return _apiManager.fetchGameByUrl(url);
  }

  Future<List<PgnGameModel>> getSavedGames() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_gamesKey);
    if (jsonStr == null) return [];
    final list = json.decode(jsonStr) as List;
    return list.map((j) => PgnGameModel.fromJson(j as Map<String, dynamic>)).toList();
  }

  Future<void> saveGame(PgnGameModel game) async {
    final prefs = await SharedPreferences.getInstance();
    final games = await getSavedGames();
    games.add(game);
    await prefs.setString(_gamesKey, json.encode(games.map((g) => g.toJson()).toList()));
  }

  Future<void> deleteGame(String gameId) async {
    final prefs = await SharedPreferences.getInstance();
    final games = await getSavedGames();
    games.removeWhere((g) => g.pgn == gameId);
    await prefs.setString(_gamesKey, json.encode(games.map((g) => g.toJson()).toList()));
  }

  void dispose() {
    _apiManager.dispose();
  }
}
