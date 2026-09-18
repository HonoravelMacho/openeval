import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BoardRotationWidget extends StatefulWidget {
  final bool rotated;
  final Widget child;

  const BoardRotationWidget({super.key, required this.rotated, required this.child});

  @override
  State<BoardRotationWidget> createState() => _BoardRotationWidgetState();
}

class _BoardRotationWidgetState extends State<BoardRotationWidget> {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: widget.rotated ? 3.14159 : 0,
      child: widget.child,
    );
  }
}
