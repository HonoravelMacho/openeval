import 'package:flutter/material.dart';

class EvaluationBar extends StatelessWidget {
  final List<double> evalHistory;

  const EvaluationBar({super.key, this.evalHistory = const []});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (evalHistory.isNotEmpty)
            LinearProgressIndicator(
              value: (evalHistory.last / 100).abs().clamp(0.0, 1.0),
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(
                evalHistory.last >= 0 ? const Color(0xFF4CAF50) : const Color(0xFFD32F2F),
              ),
              minHeight: 24,
            ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Eval', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text(
                evalHistory.isNotEmpty ? '${evalHistory.last >= 0 ? '+' : ''}${evalHistory.last.toStringAsFixed(1)}' : '--',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: evalHistory.isNotEmpty
                      ? (evalHistory.last >= 0 ? const Color(0xFF4CAF50) : const Color(0xFFD32F2F))
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
