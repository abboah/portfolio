import 'package:flutter/material.dart';
import 'package:portfolio/res/animated_patterns.dart';

/// Animated decorative background with moving patterns
class AnimatedDecorativeBackground extends StatelessWidget {
  final Widget child;

  const AnimatedDecorativeBackground({Key? key, required this.child})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background with animated patterns - multiple visible elements
        // Top left section
        Positioned(
          top: -80,
          left: -120,
          child: Opacity(
            opacity: 0.4,
            child: FloatingGeometricShapes(
              color: Colors.blue,
              size: 180,
              duration: const Duration(seconds: 6),
            ),
          ),
        ),
        Positioned(
          top: 100,
          left: 30,
          child: Opacity(
            opacity: 0.35,
            child: OrbitingSymbols(
              color: Colors.cyan,
              radius: 100,
              duration: const Duration(seconds: 8),
              symbolCount: 8,
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 200,
          child: Opacity(
            opacity: 0.38,
            child: PulsingCircles(
              color: Colors.blue.withOpacity(0.5),
              radius: 50,
              circleCount: 5,
            ),
          ),
        ),

        // Top right section
        Positioned(
          top: -60,
          right: -100,
          child: Opacity(
            opacity: 0.4,
            child: RotatingSpokes(
              color: Colors.purple,
              radius: 80,
              spokeCount: 12,
              duration: const Duration(seconds: 5),
            ),
          ),
        ),
        Positioned(
          top: 250,
          right: 80,
          child: Opacity(
            opacity: 0.35,
            child: FloatingGeometricShapes(
              color: Colors.indigo,
              size: 120,
              duration: const Duration(seconds: 7),
            ),
          ),
        ),
        Positioned(
          top: 400,
          right: -50,
          child: Opacity(
            opacity: 0.32,
            child: OrbitingSymbols(
              color: Colors.purple,
              radius: 90,
              duration: const Duration(seconds: 9),
              symbolCount: 7,
            ),
          ),
        ),

        // Middle left section
        Positioned(
          top: 300,
          left: -100,
          child: Opacity(
            opacity: 0.36,
            child: PulsingCircles(
              color: Colors.cyan,
              radius: 60,
              circleCount: 4,
              duration: const Duration(seconds: 2),
            ),
          ),
        ),
        Positioned(
          top: 500,
          left: 150,
          child: Opacity(
            opacity: 0.38,
            child: RotatingSpokes(
              color: Colors.blue,
              radius: 70,
              spokeCount: 10,
              duration: const Duration(seconds: 4),
            ),
          ),
        ),

        // Middle right section
        Positioned(
          top: 450,
          right: 120,
          child: Opacity(
            opacity: 0.34,
            child: FloatingGeometricShapes(
              color: Colors.cyan,
              size: 140,
              duration: const Duration(seconds: 5),
            ),
          ),
        ),
        Positioned(
          top: 650,
          right: -80,
          child: Opacity(
            opacity: 0.37,
            child: PulsingCircles(
              color: Colors.indigo.withOpacity(0.6),
              radius: 55,
              circleCount: 5,
            ),
          ),
        ),

        // Bottom left section
        Positioned(
          bottom: 200,
          left: -150,
          child: Opacity(
            opacity: 0.39,
            child: OrbitingSymbols(
              color: Colors.blue,
              radius: 110,
              duration: const Duration(seconds: 10),
              symbolCount: 6,
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 100,
          child: Opacity(
            opacity: 0.35,
            child: RotatingSpokes(
              color: Colors.cyan,
              radius: 85,
              spokeCount: 14,
              duration: const Duration(seconds: 3),
            ),
          ),
        ),

        // Bottom right section
        Positioned(
          bottom: 150,
          right: -120,
          child: Opacity(
            opacity: 0.4,
            child: FloatingGeometricShapes(
              color: Colors.purple,
              size: 160,
              duration: const Duration(seconds: 6),
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          right: 80,
          child: Opacity(
            opacity: 0.36,
            child: PulsingCircles(
              color: Colors.cyan,
              radius: 65,
              circleCount: 6,
              duration: const Duration(seconds: 2),
            ),
          ),
        ),
        Positioned(
          bottom: 300,
          right: 50,
          child: Opacity(
            opacity: 0.33,
            child: OrbitingSymbols(
              color: Colors.indigo,
              radius: 85,
              duration: const Duration(seconds: 11),
              symbolCount: 5,
            ),
          ),
        ),

        // Center decorative elements
        Positioned(
          top: 600,
          left: 200,
          child: Opacity(
            opacity: 0.32,
            child: PulsingCircles(
              color: Colors.purple,
              radius: 45,
              circleCount: 3,
            ),
          ),
        ),
        Positioned(
          top: 350,
          right: 300,
          child: Opacity(
            opacity: 0.34,
            child: FloatingGeometricShapes(
              color: Colors.purple.withOpacity(0.7),
              size: 100,
              duration: const Duration(seconds: 8),
            ),
          ),
        ),

        // Main content - positioned last so it's on top
        Positioned.fill(child: child),
      ],
    );
  }
}

/// Small accent animated patterns for inline decoration
class InlineAnimatedAccents extends StatelessWidget {
  final bool isLeft;

  const InlineAnimatedAccents({Key? key, this.isLeft = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.2,
      child: SizedBox(
        width: 100,
        height: 100,
        child: isLeft
            ? FloatingGeometricShapes(
                color: Colors.blue,
                size: 60,
                duration: const Duration(seconds: 5),
              )
            : RotatingSpokes(color: Colors.cyan, radius: 40, spokeCount: 8),
      ),
    );
  }
}

/// Animated divider with moving design
class AnimatedDividerWithPattern extends StatefulWidget {
  final Color color;
  final double height;
  final Duration duration;

  const AnimatedDividerWithPattern({
    Key? key,
    this.color = Colors.blue,
    this.height = 40.0,
    this.duration = const Duration(seconds: 4),
  }) : super(key: key);

  @override
  State<AnimatedDividerWithPattern> createState() =>
      _AnimatedDividerWithPatternState();
}

class _AnimatedDividerWithPatternState extends State<AnimatedDividerWithPattern>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          painter: DividerPatternPainter(
            color: widget.color,
            progress: _controller.value,
          ),
          size: Size(double.infinity, widget.height),
        );
      },
    );
  }
}

class DividerPatternPainter extends CustomPainter {
  final Color color;
  final double progress;

  DividerPatternPainter({required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.6)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final centerY = size.height / 2;
    const dashLength = 20.0;
    const gapLength = 10.0;

    // Draw moving dashed line
    double x = -dashLength + (progress * (dashLength + gapLength) * 2);
    while (x < size.width + dashLength) {
      canvas.drawLine(
        Offset(x, centerY),
        Offset(x + dashLength, centerY),
        paint,
      );
      x += dashLength + gapLength;
    }

    // Draw moving dots above and below
    final dotRadius = 4.0;
    x = -dotRadius + (progress * (dashLength + gapLength) * 2);
    while (x < size.width + dotRadius) {
      canvas.drawCircle(Offset(x, centerY - 15), dotRadius, paint);
      canvas.drawCircle(Offset(x, centerY + 15), dotRadius, paint);
      x += dashLength + gapLength;
    }
  }

  @override
  bool shouldRepaint(DividerPatternPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
