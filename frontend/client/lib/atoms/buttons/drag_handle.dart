import 'package:flutter/material.dart';

class DragHandleAtom extends StatelessWidget {
  final VoidCallback? onTap;
  final Function(DragStartDetails)? onPanStart;
  final Function(DragUpdateDetails)? onPanUpdate;
  final Function(DragEndDetails)? onPanEnd;
  final double width;
  final double height;
  final Color color;

  const DragHandleAtom({
    super.key,
    this.onTap,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.width = 60,
    this.height = 4,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        height: 20,
        margin: const EdgeInsets.only(top: 12, bottom: 8),
        child: Column(
          children: [
            Container(
              width: width,
              height: height,
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
