import 'package:flutter/material.dart';
import 'dart:ui';
class CenterWidgetClipper extends CustomClipper<Path> {
  final Path path;

  const CenterWidgetClipper({required this.path});

  @override
  Path getClip(Size size) {
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


class CenterWidgetPainter extends CustomPainter {
  final Path path;

  const CenterWidgetPainter({required this.path});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..imageFilter = ImageFilter.blur(sigmaX: 10, sigmaY: 10)
      ..color = Colors.black26;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CenterWidgetPainter oldDelegate) => false;
}


class CenterWidget extends StatelessWidget {
  final Size size;

  const CenterWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = size.width;
    final height = size.height;

    final path = Path();
    path.moveTo(0, 0.17 * height);
    path.cubicTo(
      0.23 * width,
      0.12 * height,
      0.36 * width,
      0.13 * height,
      0.48 * width,
      0.14 * height,
    );
    path.cubicTo(
      0.6 * width,
      0.15 * height,
      0.91 * width,
      0.23 * height,
      0.94 * width,
      0.34 * height,
    );
    path.cubicTo(
      0.97 * width,
      0.46 * height,
      0.74 * width,
      0.46 * height,
      0.66 * width,
      0.56 * height,
    );
    path.cubicTo(
      0.58 * width,
      0.66 * height,
      0.72 * width,
      0.73 * height,
      0.68 * width,
      0.81 * height,
    );
    path.cubicTo(
      0.63 * width,
      0.89 * height,
      0.45 * width,
      0.97 * height,
      0.3 * width,
      height,
    );
    path.lineTo(0, height);
    path.close;

    return Stack(
      children: [
        CustomPaint(
          painter: CenterWidgetPainter(path: path),
        ),
        ClipPath(
          clipper: CenterWidgetClipper(path: path),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(1, -0.6),
                  end: Alignment(-1, 0.8),
                  colors: [
                    Color(0x80ccaeff),
                    Color(0x4Dc8aafd),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}