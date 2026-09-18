import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/analysis_controller.dart';
import '../widgets/evaluation_bar.dart';
import '../widgets/move_list_widget.dart';
import '../widgets/precision_graph.dart';

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
            onPressed: () => context.read<AnalysisController>().stopAnalysis(),
          ),
        ],
      ),
      body: Consumer<AnalysisController>(
        builder: (context, controller, _) {
          final evalHistory = controller.analyses.map((a) => a.score.toDouble()).toList();
          return Column(
            children: [
              EvaluationBar(evalHistory: evalHistory),
              const SizedBox(height: 4),
              if (controller.isAnalyzing) const LinearProgressIndicator(),
              const SizedBox(height: 4),
              Expanded(child: MoveListWidget(analyses: controller.analyses)),
              const PrecisionGraph(),
            ],
          );
        },
      ),
    );
  }
}
