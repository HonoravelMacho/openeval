import 'dart:core';

class Validators {
  static bool isValidChessComUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.host.contains('chess.com') &&
          (uri.path.contains('/live') || uri.path.contains('/daily') || uri.path.contains('/game'));
    } catch (_) {
      return false;
    }
  }

  static bool isValidPgn(String pgn) {
    if (pgn.trim().isEmpty) return false;
    return pgn.contains('[') && pgn.contains('1.');
  }

  static bool isValidElo(int elo) {
    return elo >= 200 && elo <= 2500;
  }

  static bool isValidDepth(int depth) {
    return depth >= 15 && depth <= 40;
  }

  static String? validateUrl(String? url) {
    if (url == null || url.trim().isEmpty) return 'URL cannot be empty';
    if (!isValidChessComUrl(url)) return 'Please enter a valid Chess.com URL';
    return null;
  }
  static String? validateElo(int? elo) {
    if (elo == null) return 'Elo cannot be null';
    if (!isValidElo(elo)) return 'Elo must be between 200 and 2500';
    return null;
  }
  static String? validateDepth(int? depth) {
    if (depth == null) return 'Depth cannot be null';
    if (!isValidDepth(depth)) return 'Depth must be between 15 and 40';
    return null;
  }
}
