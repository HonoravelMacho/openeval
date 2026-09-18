import 'package:flutter/material.dart';

class GameModel {
  final String id;
  final String pgn;
  final String event;
  final String? site;
  final String? date;
  final String? whitePlayer;
  final String? blackPlayer;
  final String? result;
  final int? whiteElo;
  final int? blackElo;
  final List<MoveData> moves;

  GameModel({
    required this.id,
    required this.pgn,
    required this.event,
    this.site,
    this.date,
    this.whitePlayer,
    this.blackPlayer,
    this.result,
    this.whiteElo,
    this.blackElo,
    required this.moves,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] as String,
      pgn: json['pgn'] as String,
      event: json['event'] as String,
      site: json['site'] as String?,
      date: json['date'] as String?,
      whitePlayer: json['whitePlayer'] as String?,
      blackPlayer: json['blackPlayer'] as String?,
      result: json['result'] as String?,
      whiteElo: json['whiteElo'] as int?,
      blackElo: json['blackElo'] as int?,
      moves: (json['moves'] as List?)
              ?.map((e) => MoveData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'pgn': pgn,
    'event': event,
    'site': site,
    'date': date,
    'whitePlayer': whitePlayer,
    'blackPlayer': blackPlayer,
    'result': result,
    'whiteElo': whiteElo,
    'blackElo': blackElo,
    'moves': moves.map((e) => e.toJson()).toList(),
  };
}

class MoveData {
  final String notation;
  final String? fen;
  final int? moveNumber;
  final String? evaluation;

  MoveData({
    required this.notation,
    this.fen,
    this.moveNumber,
    this.evaluation,
  });

  Map<String, dynamic> toJson() => {
    'notation': notation,
    'fen': fen,
    'moveNumber': moveNumber,
    'evaluation': evaluation,
  };

  factory MoveData.fromJson(Map<String, dynamic> json) {
    return MoveData(
      notation: json['notation'] as String,
      fen: json['fen'] as String?,
      moveNumber: json['moveNumber'] as int?,
      evaluation: json['evaluation'] as String?,
    );
  }
}
