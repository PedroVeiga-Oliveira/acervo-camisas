import 'package:flutter/material.dart';

class ShirtArt extends StatelessWidget {
  const ShirtArt({super.key, required this.color, this.compact = false});

  final Color color;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final width = compact ? 92.0 : 170.0;
    final height = compact ? 112.0 : 210.0;

    return Semantics(
      label: 'Ilustração de camisa',
      image: true,
      child: Center(
        child: CustomPaint(
          size: Size(width, height),
          painter: _ShirtPainter(
            color: color,
            borderColor: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
    );
  }
}

class _ShirtPainter extends CustomPainter {
  _ShirtPainter({required this.color, required this.borderColor});

  final Color color;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width * .29, size.height * .08)
      ..lineTo(size.width * .45, size.height * .01)
      ..quadraticBezierTo(
        size.width * .50,
        size.height * .16,
        size.width * .55,
        size.height * .01,
      )
      ..lineTo(size.width * .71, size.height * .08)
      ..lineTo(size.width * .96, size.height * .27)
      ..lineTo(size.width * .82, size.height * .48)
      ..lineTo(size.width * .68, size.height * .37)
      ..lineTo(size.width * .68, size.height * .94)
      ..quadraticBezierTo(
        size.width * .50,
        size.height,
        size.width * .32,
        size.height * .94,
      )
      ..lineTo(size.width * .32, size.height * .37)
      ..lineTo(size.width * .18, size.height * .48)
      ..lineTo(size.width * .04, size.height * .27)
      ..close();

    final fill = Paint()..color = color;

    final border = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(path, fill);
    canvas.drawPath(path, border);

    final stripe = Paint()..color = Colors.white.withValues(alpha: .25);

    canvas.drawRect(
      Rect.fromLTWH(
        size.width * .35,
        size.height * .20,
        size.width * .30,
        size.height * .68,
      ),
      stripe,
    );
  }

  @override
  bool shouldRepaint(covariant _ShirtPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.borderColor != borderColor;
  }
}
