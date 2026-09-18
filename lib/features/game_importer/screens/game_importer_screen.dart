import 'package:flutter/material.dart';
import 'package:openeval/features/game_importer/widgets/url_input_widget.dart';

class GameImporterScreen extends StatelessWidget {
  const GameImporterScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            const UrlInputWidget(),
            const SizedBox(height: 16),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Event: Sample Game', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('White: Player A vs Black: Player B'),
                    Text('Result: 1-0'),
                    SizedBox(height: 16),
                    Text('Analysis features coming soon!'),
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
