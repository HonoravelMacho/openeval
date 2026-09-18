import 'package:flutter/material.dart';
import 'package:openeval/widgets/evaluation_bar.dart';
import 'package:openeval/widgets/move_list_widget.dart';
import 'package:openeval/widgets/precision_graph.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Analysis'),
        actions: [
          IconButton(
            icon: const Icon(Icons.stop),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const EvaluationBar(),
          Expanded(child: MoveListWidget()),
          const PrecisionGraph(),
        ],
      ),
    );
  }
}
