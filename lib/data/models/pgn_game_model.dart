import 'package:flutter/material.dart';

class PgnGameModel {
  final String pgn;
  final String? event;
  final String? site;
  final String? date;
  final String? white;
  final String? black;
  final String? result;
  final int? whiteElo;
  final int? blackElo;

  PgnGameModel({
    required this.pgn,
    this.event,
    this.site,
    this.date,
    this.white,
    this.black,
    this.result,
    this.whiteElo,
    this.blackElo,
  });

  factory PgnGameModel.fromJson(Map<String, dynamic> json) {
    return PgnGameModel(
      pgn: json['pgn'] as String,
      event: json['event'] as String?,
      site: json['site'] as String?,
      date: json['date'] as String?,
      white: json['white'] as String?,
      black: json['black'] as String?,
      result: json['result'] as String?,
      whiteElo: json['whiteElo'] as int?,
      blackElo: json['blackElo'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'pgn': pgn,
    'event': event,
    'site': site,
    'date': date,
    'white': white,
    'black': black,
    'result': result,
    'whiteElo': whiteElo,
    'blackElo': blackElo,
  };
}

class ParsedPgn {
  final List<String> headers;
  final List<String> moves;
  final Map<String, String> metadata;
  final String fullPgn;

  ParsedPgn({
    required this.headers,
    required this.moves,
    required this.metadata,
    required this.fullPgn,
  });

  factory ParsedPgn.fromRaw(String pgn) {
    final lines = pgn.trim().split('\n');
    final metadata = <String, String>{};
    final moves = <String>[];

    for (final line in lines) {
      if (line.startsWith('[')) {
        final match = RegExp(r'\[(\w+)\s+"(.*?)"\]').firstMatch(line);
        if (match != null) {
          metadata[match.group(1)!] = match.group(2)!;
        }
      } else if (line.trim().isNotEmpty) {
        moves.addAll(line.trim().split(RegExp(r'\s+')).where((m) => m.isNotEmpty));
      }
    }

    return ParsedPgn(
      headers: metadata.keys.toList(),
      moves: moves,
      metadata: metadata,
      fullPgn: pgn,
    );
  }
}
