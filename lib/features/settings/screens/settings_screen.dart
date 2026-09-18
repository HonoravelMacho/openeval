import 'package:flutter/material.dart';
import 'package:openeval/features/settings/controllers/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Board Theme', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Wrap(
            spacing: 8,
            children: [
              ChoiceChip(label: Text('Classic'), selected: true, onSelected: null),
              ChoiceChip(label: Text('Dark Forest'), selected: false, onSelected: null),
              ChoiceChip(label: Text('Marble'), selected: false, onSelected: null),
              ChoiceChip(label: Text('Neon'), selected: false, onSelected: null),
              ChoiceChip(label: Text('Ocean'), selected: false, onSelected: null),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Piece Set', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Wrap(
            spacing: 8,
            children: [
              ChoiceChip(label: Text('Standard'), selected: true, onSelected: null),
              ChoiceChip(label: Text('Crystal'), selected: false, onSelected: null),
            ],
          ),
          const SizedBox(height: 24),
          const SwitchListTile(
            title: Text('Sound'),
            value: true,
            onChanged: null,
          ),
        ],
      ),
    );
  }
}
