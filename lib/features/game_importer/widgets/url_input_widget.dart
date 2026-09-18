import 'package:flutter/material.dart';

class UrlInputWidget extends StatelessWidget {
  const UrlInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextField(
          decoration: InputDecoration(
            labelText: 'Chess.com URL',
            hintText: 'https://www.chess.com/live/...',
            prefixIcon: Icon(Icons.link),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.download),
          label: const Text('Import Game'),
        ),
      ],
    );
  }
}
