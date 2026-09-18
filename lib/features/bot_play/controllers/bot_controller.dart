import 'package:flutter/foundation.dart';
import 'package:openeval/data/services/stockfish_service.dart';
import 'package:openeval/engine/stockfish/stockfish_engine.dart';
import 'package:openeval/engine/stockfish/stockfish_config.dart';

class BotController extends ChangeNotifier {
  final StockfishEngine _engine;
  late int _elo;
  bool _isPlaying = false;
  String _status = 'Ready';

  BotController({StockfishEngine? engine})
      : _elo = StockfishConfig.defaultElo,
        _engine = engine ?? StockfishEngine(StockfishService.instance);

  int get elo => _elo;
  bool get isPlaying => _isPlaying;
  String get status => _status;

  void setElo(int elo) {
    _elo = elo;
    notifyListeners();
  }

  Future<void> startGame() async {
    _isPlaying = true;
    _status = 'Playing against Stockfish';
    await _engine.initialize();
    await _engine.configure(elo: _elo);
    notifyListeners();
  }

  Future<String> getMove(String fen) async {
    return _engine.getBestMove(fen);
  }

  void stopGame() {
    _isPlaying = false;
    _status = 'Stopped';
    notifyListeners();
  }

  @override
  void dispose() {
    _engine.dispose();
    super.dispose();
  }
}
