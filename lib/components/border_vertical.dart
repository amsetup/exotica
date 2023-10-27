import 'package:flutter/material.dart';

class BorderVertical extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const BorderVertical({super.key, this.height = 40, this.width = 1, this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color.withOpacity(0.5),
    );
  }
}
