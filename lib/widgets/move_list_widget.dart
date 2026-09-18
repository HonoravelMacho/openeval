import 'package:flutter/material.dart';

class MoveListWidget extends StatelessWidget {
  const MoveListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Move ${index + 1}'),
            subtitle: const Text('e2e4'),
            trailing: const Text('+1.2'),
          );
        },
      ),
    );
  }
}
