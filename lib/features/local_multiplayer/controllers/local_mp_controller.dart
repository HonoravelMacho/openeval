import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class LocalMpController extends ChangeNotifier {
  final String _gameId;
  int _currentPlayer = 0;
  bool _boardRotated = false;
  final List<String> _moves = [];

  LocalMpController() : _gameId = const Uuid().v4();

  String get gameId => _gameId;
  int get currentPlayer => _currentPlayer;
  bool get boardRotated => _boardRotated;
  List<String> get moves => _moves;

  void makeMove(String move) {
    _moves.add(move);
    _currentPlayer = (_currentPlayer + 1) % 2;
    notifyListeners();
  }

  void rotateBoard() {
    _boardRotated = !_boardRotated;
    notifyListeners();
  }

  void resetGame() {
    _currentPlayer = 0;
    _boardRotated = false;
    _moves.clear();
    notifyListeners();
  }

  String exportPgn() {
    final buffer = StringBuffer();
    buffer.writeln('[Event "Local Multiplayer"]');
    buffer.writeln('[Site "OpenEval"]');
    buffer.writeln('[Date "?"]');
    buffer.writeln('[White "Player 1"]');
    buffer.writeln('[Black "Player 2"]');
    buffer.writeln('[Result "*"]');
    for (var i = 0; i < _moves.length; i += 2) {
      final moveNumber = (i ~/ 2) + 1;
      final move1 = _moves[i];
      final move2 = i + 1 < _moves.length ? _moves[i + 1] : '';
      buffer.writeln('$moveNumber. $move1 $move2');
    }
    return buffer.toString();
  }
}
