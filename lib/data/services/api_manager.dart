import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:openeval/data/models/pgn_game_model.dart';

class ApiManager {
  static const String _baseUrl = 'https://api.chess.com/pub';
  final http.Client _client;

  ApiManager({http.Client? client}) : _client = client ?? http.Client();

  Future<PgnGameModel> fetchGameByUrl(String url) async {
    final gameId = _extractGameId(url);
    if (gameId == null) throw Exception('Invalid Chess.com URL');
    return fetchGameById(gameId);
  }

  Future<PgnGameModel> fetchGameById(String gameId) async {
    final response = await _client.get(Uri.parse('$_baseUrl/game/$gameId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load game: ${response.statusCode}');
    }
    final data = json.decode(response.body);
    return PgnGameModel.fromJson(data);
  }

  Future<String> fetchPgn(String gameId) async {
    final response = await _client.get(Uri.parse('$_baseUrl/game/$gameId/pgn'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load PGN: ${response.statusCode}');
    }
    return response.body;
  }

  Future<Map<String, dynamic>> getGameMetadata(String gameId) async {
    final response = await _client.get(Uri.parse('$_baseUrl/game/$gameId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load metadata');
    }
    return json.decode(response.body);
  }

  String? _extractGameId(String url) {
    try {
      final uri = Uri.parse(url);
      final pathParts = uri.path.split('/');
      final gameIndex = pathParts.indexOf('game');
      if (gameIndex >= 0 && gameIndex + 1 < pathParts.length) {
        return pathParts[gameIndex + 1];
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  void dispose() {
    _client.close();
  }
}
