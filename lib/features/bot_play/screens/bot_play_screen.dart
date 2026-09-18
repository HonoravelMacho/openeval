import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/bot_controller.dart';
import '../widgets/elo_slider.dart';

class BotPlayScreen extends StatelessWidget {
  const BotPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Play vs Bot')),
      body: Builder(
        builder: (context) {
          final controller = context.watch<BotController>();
          return Column(
            children: [
              const SizedBox(height: 24),
              const EloSlider(elo: 1500, onEloChanged: _noop),
              const SizedBox(height: 24),
              Text(controller.status),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => controller.startGame(),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Match'),
              ),
            ],
          );
        },
      ),
    );
  }

  static void _noop(int value) {}
}
