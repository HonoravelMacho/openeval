import 'package:flutter/material.dart';
import 'package:openeval/widgets/board_rotation_widget.dart';

class LocalMultiplayerScreen extends StatelessWidget {
  const LocalMultiplayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Multiplayer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.rotate_right),
            onPressed: () {},
            tooltip: 'Rotate Board',
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(child: Text('2-Player Local Board Coming Soon!')),
    );
  }
}
