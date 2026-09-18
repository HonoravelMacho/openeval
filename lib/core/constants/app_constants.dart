class AppConstants {
  static const String appName = 'OpenEval';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Open Source Chess Analysis Engine powered by Stockfish';
  static const String githubRepo = 'https://github.com/HonoravelMacho/openeval';
  static const String chessComApi = 'https://api.chess.com/pub';
  static const int minAnalysisDepth = 15;
  static const int maxAnalysisDepth = 40;
  static const int defaultAnalysisDepth = 25;
  static const int minElo = 200;
  static const int maxElo = 2500;
  static const int defaultElo = 1500;
  static const double sigmoidK = 0.1;
  static const double sigmoidMidpoint = 0.5;
  static const int brilliantThreshold = 100;
  static const int bestMoveThreshold = 75;
  static const int greatThreshold = 50;
  static const int inaccuracyThreshold = 25;
  static const int mistakeThreshold = 0;
}
