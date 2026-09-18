import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:openeval/data/repositories/game_repository.dart';
import 'package:openeval/data/models/pgn_game_model.dart';
import 'package:openeval/core/utils/validators.dart';

class GameImporterController extends ChangeNotifier {
  final GameRepository _repository;
  String _url = '';
  PgnGameModel? _game;
  String _status = 'Idle';
  bool _isLoading = false;
  String? _error;

  GameImporterController({GameRepository? repository}) : _repository = repository ?? GameRepository();

  String get url => _url;
  PgnGameModel? get game => _game;
  String get status => _status;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setUrl(String url) {
    _url = url;
    _error = null;
    notifyListeners();
  }

  Future<void> importGame() async {
    if (_url.isEmpty) {
      _error = 'URL cannot be empty';
      notifyListeners();
      return;
    }

    if (!Validators.isValidChessComUrl(_url)) {
      _error = 'Invalid Chess.com URL';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _status = 'Fetching...';
    _error = null;
    notifyListeners();

    try {
      _game = await _repository.fetchGameByUrl(_url);
      await _repository.saveGame(_game!);
      _status = 'Game imported successfully!';
    } catch (e) {
      _error = 'Failed to import game: ${e.toString()}';
      _status = 'Error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _url = '';
    _game = null;
    _status = 'Idle';
    _error = null;
    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }
}
