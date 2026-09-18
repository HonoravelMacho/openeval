import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_importer_controller.dart';
import '../widgets/url_input_widget.dart';

class GameImporterScreen extends StatelessWidget {
  const GameImporterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameImporterController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Import Game')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Import from Chess.com',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Paste a Chess.com live or daily game URL to fetch and analyze it.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            UrlInputWidget(
              url: controller.url,
              onUrlChanged: controller.setUrl,
              onImport: controller.importGame,
              isLoading: controller.isLoading,
              error: controller.error,
            ),
            const SizedBox(height: 16),
            if (controller.game != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Event: ${controller.game!.event}'),
                      Text('White: ${controller.game!.white} vs Black: ${controller.game!.black}'),
                      Text('Result: ${controller.game!.result}'),
                      if (controller.game!.whiteElo != null)
                        Text('White Elo: ${controller.game!.whiteElo}'),
                      if (controller.game!.blackElo != null)
                        Text('Black Elo: ${controller.game!.blackElo}'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/analysis'),
                        child: const Text('Analyze Game'),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
