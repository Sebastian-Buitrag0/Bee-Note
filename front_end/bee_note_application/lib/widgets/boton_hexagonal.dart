import 'package:flutter/material.dart';
import 'dart:math' as math;

class HexagonalButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  final IconData? iconData;
  final double? sizeHeight;
  final double? sizewidth;

  const HexagonalButton({
    super.key, 
    required this.onTap, 
    this.text, 
    this.iconData, 
    this.sizeHeight = 70, 
    this.sizewidth = 200
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: sizewidth,
        height: sizeHeight,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 5),
              blurRadius: 30,
              spreadRadius: 0,
            ),
          ],
        ),
        child: CustomPaint(
          // size: const Size(100, 50), // Tamaño del botón
          painter: HexagonPainter(color: const Color(0xFFF3753D)), // Color del botón
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                if(iconData != null) Icon(
                  iconData,
                  color: Colors.white,
                  size: 50,
                ),

                if(text != null) Text(
                  text!,
                  style: const TextStyle(
                    fontFamily: 'Letters_for_Learners',
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HexagonPainter extends CustomPainter {
  final Color color;

  HexagonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final double radius = size.height / 2;
    final double apothem = radius * math.sqrt(3) / 2;

    Path path = Path();
    path.moveTo(radius, 0);
    path.lineTo(size.width - apothem, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - apothem, size.height);
    path.lineTo(radius, size.height);
    path.lineTo(0, size.height / 2);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
