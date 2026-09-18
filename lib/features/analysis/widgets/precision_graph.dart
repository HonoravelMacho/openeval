import 'package:flutter/material.dart';

class PrecisionGraph extends StatelessWidget {
  const PrecisionGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        children: [
          Container(
            height: 150,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(child: Text('Precision Graph (50.0%)')),
          ),
        ],
      ),
    );
  }
}
