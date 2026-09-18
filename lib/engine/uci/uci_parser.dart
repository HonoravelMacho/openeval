class UciParser {
  static Map<String, dynamic> parseInfoLine(String line) {
    final result = <String, dynamic>{};
    final parts = line.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return result;

    var i = 0;
    while (i < parts.length) {
      final key = parts[i];
      i++;
      switch (key) {
        case 'depth':
          if (i < parts.length) result['depth'] = int.parse(parts[i]);
          i++;
        case 'currmove':
          if (i < parts.length) result['currmove'] = parts[i];
          i++;
        case 'score':
          if (i < parts.length) {
            final scoreType = parts[i];
            i++;
            if (i < parts.length) {
              result['scoreType'] = scoreType;
              result['score'] = int.parse(parts[i]);
              i++;
            }
          }
        case 'time':
          if (i < parts.length) result['time'] = int.parse(parts[i]);
          i++;
        case 'nodes':
          if (i < parts.length) result['nodes'] = int.parse(parts[i]);
          i++;
        case 'pv':
          final pvParts = parts.skip(i).toList();
          result['pv'] = pvParts.join(' ');
          i = parts.length;
        default:
          break;
      }
    }
    return result;
  }

  static String? parseBestMove(String line) {
    if (!line.startsWith('bestmove')) return null;
    final parts = line.trim().split(RegExp(r'\s+'));
    return parts.length >= 2 ? parts[1] : null;
  }

  static String? parsePonderLine(String line) {
    if (!line.startsWith('ponder')) return null;
    final parts = line.trim().split(RegExp(r'\s+'));
    return parts.length >= 2 ? parts[1] : null;
  }
}
