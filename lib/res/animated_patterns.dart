import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Floating animated geometric shapes
class FloatingGeometricShapes extends StatefulWidget {
  final Color color;
  final Duration duration;
  final double size;

  const FloatingGeometricShapes({
    Key? key,
    this.color = Colors.blue,
    this.duration = const Duration(seconds: 4),
    this.size = 80.0,
  }) : super(key: key);

  @override
  State<FloatingGeometricShapes> createState() =>
      _FloatingGeometricShapesState();
}

class _FloatingGeometricShapesState extends State<FloatingGeometricShapes>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _rotateController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _rotateController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _floatController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_floatController, _rotateController]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            math.sin(_floatController.value * 2 * math.pi) * 30,
          ),
          child: Transform.rotate(
            angle: _rotateController.value * 2 * math.pi,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.color.withOpacity(0.6),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(widget.size * 0.2),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Animated orbiting symbols/dots
class OrbitingSymbols extends StatefulWidget {
  final Color color;
  final Duration duration;
  final double radius;
  final int symbolCount;

  const OrbitingSymbols({
    Key? key,
    this.color = Colors.cyan,
    this.duration = const Duration(seconds: 8),
    this.radius = 100.0,
    this.symbolCount = 5,
  }) : super(key: key);

  @override
  State<OrbitingSymbols> createState() => _OrbitingSymbolsState();
}

class _OrbitingSymbolsState extends State<OrbitingSymbols>
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
      builder: (context, child) {
        return SizedBox(
          width: widget.radius * 2,
          height: widget.radius * 2,
          child: Stack(
            alignment: Alignment.center,
            children: List.generate(widget.symbolCount, (index) {
              final angle =
                  (2 * math.pi / widget.symbolCount) * index +
                  (_controller.value * 2 * math.pi);
              final x = math.cos(angle) * widget.radius;
              final y = math.sin(angle) * widget.radius;

              return Positioned(
                left: widget.radius + x - 6,
                top: widget.radius + y - 6,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(
                      0.5 +
                          0.5 *
                              math.sin(_controller.value * 2 * math.pi + index),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

/// Animated wave pattern
class AnimatedWavePattern extends StatefulWidget {
  final Color color;
  final double height;

  const AnimatedWavePattern({
    Key? key,
    this.color = Colors.purple,
    this.height = 100.0,
  }) : super(key: key);

  @override
  State<AnimatedWavePattern> createState() => _AnimatedWavePatternState();
}

class _AnimatedWavePatternState extends State<AnimatedWavePattern>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
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
          painter: WavePainter(
            color: widget.color,
            progress: _controller.value,
          ),
          size: Size(double.infinity, widget.height),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final Color color;
  final double progress;

  WavePainter({required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    const waveCount = 2;
    final waveLength = size.width / waveCount;

    path.moveTo(0, size.height / 2);
    for (double x = 0; x <= size.width; x += 5) {
      final y =
          size.height / 2 +
          20 *
              math.sin((x / waveLength + progress * 2 * math.pi) * 2 * math.pi);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// Animated floating particles
class FloatingParticles extends StatefulWidget {
  final Color color;
  final int particleCount;
  final Duration duration;

  const FloatingParticles({
    Key? key,
    this.color = Colors.blue,
    this.particleCount = 10,
    this.duration = const Duration(seconds: 10),
  }) : super(key: key);

  @override
  State<FloatingParticles> createState() => _FloatingParticlesState();
}

class _FloatingParticlesState extends State<FloatingParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Particle> particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat();

    particles = List.generate(
      widget.particleCount,
      (index) => _Particle(
        delay: (index / widget.particleCount) * 2 * math.pi,
        size: 2 + (index % 3) * 2,
      ),
    );
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
        return Stack(
          children: particles.map((particle) {
            final progress =
                (_controller.value + particle.delay / (2 * math.pi)) % 1.0;
            final x =
                (math.sin(particle.delay + progress * 2 * math.pi) * 100) + 100;
            final y = progress * 400;

            return Positioned(
              left: x,
              top: y,
              child: Container(
                width: particle.size,
                height: particle.size,
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _Particle {
  final double delay;
  final double size;

  _Particle({required this.delay, required this.size});
}

/// Animated pulsing circles
class PulsingCircles extends StatefulWidget {
  final Color color;
  final double radius;
  final Duration duration;
  final int circleCount;

  const PulsingCircles({
    Key? key,
    this.color = Colors.green,
    this.radius = 50.0,
    this.duration = const Duration(seconds: 2),
    this.circleCount = 3,
  }) : super(key: key);

  @override
  State<PulsingCircles> createState() => _PulsingCirclesState();
}

class _PulsingCirclesState extends State<PulsingCircles>
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
        return Stack(
          alignment: Alignment.center,
          children: List.generate(widget.circleCount, (index) {
            final delay = index / widget.circleCount;
            final progress = (_controller.value + delay) % 1.0;
            final size = widget.radius * 2 * progress;
            final opacity = (1 - progress) * 0.8;

            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.color.withOpacity(opacity),
                  width: 2,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

/// Animated rotating lines/spokes
class RotatingSpokes extends StatefulWidget {
  final Color color;
  final double radius;
  final Duration duration;
  final int spokeCount;

  const RotatingSpokes({
    Key? key,
    this.color = Colors.orange,
    this.radius = 60.0,
    this.duration = const Duration(seconds: 4),
    this.spokeCount = 8,
  }) : super(key: key);

  @override
  State<RotatingSpokes> createState() => _RotatingSpokesState();
}

class _RotatingSpokesState extends State<RotatingSpokes>
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
          painter: SpokesPainter(
            color: widget.color,
            angle: _controller.value * 2 * math.pi,
            spokeCount: widget.spokeCount,
            radius: widget.radius,
          ),
          size: Size(widget.radius * 2, widget.radius * 2),
        );
      },
    );
  }
}

class SpokesPainter extends CustomPainter {
  final Color color;
  final double angle;
  final int spokeCount;
  final double radius;

  SpokesPainter({
    required this.color,
    required this.angle,
    required this.spokeCount,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.6)
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < spokeCount; i++) {
      final spokeAngle = angle + (2 * math.pi / spokeCount) * i;
      final endX = center.dx + radius * math.cos(spokeAngle);
      final endY = center.dy + radius * math.sin(spokeAngle);

      canvas.drawLine(center, Offset(endX, endY), paint);
    }
  }

  @override
  bool shouldRepaint(SpokesPainter oldDelegate) {
    return oldDelegate.angle != angle;
  }
}
