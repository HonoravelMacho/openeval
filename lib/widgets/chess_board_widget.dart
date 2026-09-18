import 'package:flutter/material.dart';

class ChessBoardWidget extends StatelessWidget {
  final bool boardRotated;
  final Color lightSquareColor;
  final Color darkSquareColor;

  const ChessBoardWidget({
    super.key,
    this.boardRotated = false,
    this.lightSquareColor = const Color(0xFFECE4D0),
    this.darkSquareColor = const Color(0xFF769656),
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: boardRotated ? 3.14159 : 0,
      child: Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
          ),
          itemCount: 64,
          itemBuilder: (context, index) {
            final row = index ~/ 8;
            final col = index % 8;
            final isLight = (row + col) % 2 == 0;
            return Container(
              color: isLight ? lightSquareColor : darkSquareColor,
            );
          },
        ),
      ),
    );
  }
}
