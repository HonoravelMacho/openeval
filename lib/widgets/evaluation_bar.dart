import 'package:flutter/material.dart';

class EvaluationBar extends StatelessWidget {
  const EvaluationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: 0.5,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1A73E8)),
              minHeight: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Text('Eval', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          const Text('+1.5', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4CAF50))),
        ],
      ),
    );
  }
}
