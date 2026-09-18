import 'package:flutter/material.dart';
import 'package:openeval/data/models/move_analysis_model.dart';
import 'package:openeval/engine/evaluator/eval_score.dart';

class MoveListWidget extends StatelessWidget {
  final List<MoveAnalysisModel> analyses;

  const MoveListWidget({super.key, this.analyses = const []});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: analyses.length,
        itemBuilder: (context, index) {
          final analysis = analyses[index];
          return ListTile(
            title: Text('${index + 1}. ${analysis.move}'),
            subtitle: Text('Depth: ${analysis.depth} | ${analysis.timeMs.toStringAsFixed(0)}ms'),
            trailing: Text(
              '${analysis.score >= 0 ? '+' : ''}${analysis.score}',
              style: TextStyle(
                color: analysis.score.abs() >= 50
                    ? const Color(0xFF4CAF50)
                    : analysis.score.abs() >= 25
                        ? const Color(0xFFFF9800)
                        : const Color(0xFFD32F2F),
              ),
            ),
          );
        },
      ),
    );
  }
}
