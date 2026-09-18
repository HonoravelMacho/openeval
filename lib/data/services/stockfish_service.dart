import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class StockfishService {
  static StockfishService? _instance;
  static StockfishService get instance => _instance ??= StockfishService._();

  StockfishService._();

  static const MethodChannel _channel = MethodChannel('stockfish_engine');

  bool _isInitialized = false;
  final StreamController<Map<String, dynamic>> _analysisStream =
      StreamController.broadcast();

  Stream<Map<String, dynamic>> get analysisStream => _analysisStream.stream;

  Future<void> initialize() async {
    if (_isInitialized) return;
    try {
      final dir = await getApplicationDocumentsDirectory();
      final result = await _channel.invokeMethod<String>('initialize', {
        'appDir': dir.path,
      });
      if (result != null && result.startsWith('error')) {
        debugPrint('Stockfish init returned error: $result');
        return;
      }
      _isInitialized = true;
    } catch (e) {
      debugPrint('Stockfish init failed: $e');
    }
  }

  Future<void> configure({
    int? elo,
    int? depth,
    bool infinite = false,
    String? skill,
  }) async {
    if (!_isInitialized) await initialize();
    await _channel.invokeMethod('configure', {
      'elo': elo,
      'depth': depth,
      'infinite': infinite,
      'skill': skill,
    });
  }

  Future<void> setPosition(String fen, {List<String>? moves}) async {
    if (!_isInitialized) await initialize();
    await _channel.invokeMethod('position', {
      'fen': fen,
      'moves': moves ?? [],
    });
  }

  void startAnalysis(String fen, {int depth = 25, bool infinite = false}) {
    if (!_isInitialized) initialize();
    setPosition(fen);
    _channel.invokeMethod('go', {
      'depth': depth,
      'infinite': infinite,
    });
  }

  Stream<Map<String, dynamic>> get analysisResults => _analysisStream.stream;

  Future<String> getBestMove(String fen, {int depth = 25}) async {
    if (!_isInitialized) await initialize();
    await setPosition(fen);
    final result = await _channel.invokeMethod<String>('getBestMove', {
      'depth': depth,
    });
    return result ?? 'e2e4';
  }

  Future<void> stop() async {
    await _channel.invokeMethod('stop');
  }

  Future<void> dispose() async {
    await _channel.invokeMethod('stop');
    _isInitialized = false;
  }
}
