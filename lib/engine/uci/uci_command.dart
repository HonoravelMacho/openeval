class UciCommand {
  final String command;
  final Map<String, dynamic> params;

  UciCommand({
    required this.command,
    this.params = const {},
  });

  static const String go = 'go';
  static const String position = 'position';
  static const String uciNewGame = 'ucinewgame';
  static const String setOption = 'setoption';
  static const String isReady = 'isready';
  static const String uci = 'uci';
  static const String quit = 'quit';
  static const String depth = 'depth';
  static const String movetime = 'movetime';
  static const String infinite = 'infinite';
  static const String searchmoves = 'searchmoves';
  static const String ponder = 'ponder';
  static const String nodes = 'nodes';

  static UciCommand uciNewGameCommand() => UciCommand(command: uciNewGame);
  static UciCommand isReadyCommand() => UciCommand(command: isReady);
  static UciCommand uciInitCommand() => UciCommand(command: uci);
  static UciCommand quitCommand() => UciCommand(command: quit);

  static UciCommand positionCommand({
    String? fen,
    List<String>? moves,
  }) {
    final buffer = StringBuffer();
    if (fen != null) {
      buffer.write('position fen $fen');
    } else {
      buffer.write('position startpos');
    }
    if (moves != null && moves.isNotEmpty) {
      buffer.write(' moves ${moves.join(' ')}');
    }
    return UciCommand(command: position, params: {'raw': buffer.toString()});
  }

  static UciCommand depthCommand(int depth) =>
      UciCommand(command: go, params: {'depth': depth});

  static UciCommand infiniteCommand() =>
      UciCommand(command: go, params: {'infinite': true});

  static UciCommand eloCommand(int elo) => UciCommand(
    command: setOption,
    params: {'name': 'UCI_LimitStrength', 'value': 'true'},
  )..params.addAll({'name': 'UCI_Elo', 'value': elo.toString()});

  static UciCommand skillCommand(String skill) => UciCommand(
    command: setOption,
    params: {'name': 'Skill Level', 'value': skill},
  );

  @override
  String toString() {
    if (params.isEmpty) return command;
    if (command == position) return params['raw'] ?? command;
    return '$command ${params.entries.map((e) => '${e.key} ${e.value}').join(' ')}';
  }
}
