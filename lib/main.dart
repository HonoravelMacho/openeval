import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openeval/app.dart';
import 'package:openeval/data/services/stockfish_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StockfishService.instance.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const App());
}
