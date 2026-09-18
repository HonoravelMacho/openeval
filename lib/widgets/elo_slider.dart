import 'package:flutter/material.dart';
import 'package:openeval/core/constants/app_constants.dart';

class EloSlider extends StatelessWidget {
  final int elo;
  final ValueChanged<int> onEloChanged;

  const EloSlider({super.key, required this.elo, required this.onEloChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Bot Elo Rating', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('$elo Elo', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Slider(
              value: elo.toDouble(),
              min: AppConstants.minElo.toDouble(),
              max: AppConstants.maxElo.toDouble(),
              divisions: 23,
              label: '$elo',
              onChanged: (v) => onEloChanged(v.round()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${AppConstants.minElo} Elo'),
                Text('${AppConstants.maxElo} Elo'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
