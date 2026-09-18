import 'package:flutter/material.dart';
import 'package:openeval/widgets/elo_slider.dart';

class BotPlayScreen extends StatelessWidget {
  const BotPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Play vs Bot')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text('Play against Stockfish', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            const EloSlider(elo: 1500, onEloChanged: _noop),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Match'),
            ),
          ],
        ),
      ),
    );
  }

  static void _noop(int value) {}
}
