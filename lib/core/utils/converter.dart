import 'package:intl/intl.dart';

class Converter {
  static String formatCentipawns(int cp) {
    final sign = cp >= 0 ? '+' : '';
    return '$sign${cp.toStringAsFixed(0)}';
  }

  static String formatElo(int elo) {
    return elo.toStringAsFixed(0);
  }

  static String formatDate(String? isoDate) {
    if (isoDate == null) return 'N/A';
    try {
      final date = DateTime.parse(isoDate);
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (_) {
      return isoDate;
    }
  }

  static String formatTime(double ms) {
    if (ms < 1000) return '${ms.toStringAsFixed(0)}ms';
    if (ms < 60000) return '${(ms / 1000).toStringAsFixed(1)}s';
    return '${(ms / 60000).toStringAsFixed(1)}m';
  }

  static String generateGameId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
