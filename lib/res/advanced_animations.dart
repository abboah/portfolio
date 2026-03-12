import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:portfolio/res/constants.dart';

/// Parallax scroll effect for background elements
class ParallaxWidget extends StatelessWidget {
  final Widget child;
  final double offset;
  final Alignment alignment;

  const ParallaxWidget({
    Key? key,
    required this.child,
    this.offset = 50.0,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(offset: Offset(0, offset * 0.1), child: child);
  }
}

/// Interactive gradient background that responds to mouse movement
class InteractiveGradientBackground extends StatefulWidget {
  final List<Color> colors;
  final Widget child;
  final Duration animationDuration;

  const InteractiveGradientBackground({
    Key? key,
    required this.colors,
    required this.child,
    this.animationDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  State<InteractiveGradientBackground> createState() =>
      _InteractiveGradientBackgroundState();
}

class _InteractiveGradientBackgroundState
    extends State<InteractiveGradientBackground> {
  Offset _mousePosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final normalizedX = (_mousePosition.dx / size.width).clamp(0.0, 1.0);
    final normalizedY = (_mousePosition.dy / size.height).clamp(0.0, 1.0);

    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePosition = event.position;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(normalizedX * 2 - 1, normalizedY * 2 - 1),
            end: Alignment(-(normalizedX * 2 - 1), -(normalizedY * 2 - 1)),
            colors: widget.colors,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}

/// Floating particles background effect
class FloatingParticles extends StatefulWidget {
  final int particleCount;
  final Color particleColor;
  final double maxSize;

  const FloatingParticles({
    Key? key,
    this.particleCount = 20,
    this.particleColor = accentCyan,
    this.maxSize = 3.0,
  }) : super(key: key);

  @override
  State<FloatingParticles> createState() => _FloatingParticlesState();
}

class _FloatingParticlesState extends State<FloatingParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _initializeParticles();
  }

  void _initializeParticles() {
    for (int i = 0; i < widget.particleCount; i++) {
      _particles.add(
        _Particle(
          x: (i * 100.0) % 100,
          y: (i * 50.0) % 100,
          size: (widget.maxSize * (i % 3 + 1) / 3.0),
          duration: Duration(seconds: 15 + (i % 5)),
          delay: Duration(milliseconds: i * 200),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _particles.map((particle) {
        return Positioned(
          left: particle.x.toDouble(),
          top: particle.y.toDouble(),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final value = (_controller.value * 2) % 1.0;
              return Opacity(
                opacity: (1 - (value - 0.5).abs() * 2).clamp(0.0, 1.0),
                child: Transform.translate(
                  offset: Offset(0, -value * 100),
                  child: Container(
                    width: particle.size,
                    height: particle.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.particleColor.withOpacity(0.3),
                      boxShadow: [
                        BoxShadow(
                          color: widget.particleColor.withOpacity(0.2),
                          blurRadius: particle.size,
                          spreadRadius: particle.size / 2,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}

class _Particle {
  final double x;
  final double y;
  final double size;
  final Duration duration;
  final Duration delay;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.duration,
    required this.delay,
  });
}

/// Glow text effect with animated border
class GlowingText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Color glowColor;
  final Duration animationDuration;

  const GlowingText(
    this.text, {
    Key? key,
    required this.style,
    this.glowColor = accentCyan,
    this.animationDuration = const Duration(milliseconds: 2000),
  }) : super(key: key);

  @override
  State<GlowingText> createState() => _GlowingTextState();
}

class _GlowingTextState extends State<GlowingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
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
      builder: (context, child) {
        final value = _controller.value;
        final shadowBlur = 20 + (value * 10);

        return Text(
          widget.text,
          style: widget.style.copyWith(
            shadows: [
              Shadow(
                color: widget.glowColor.withOpacity(value * 0.5),
                blurRadius: shadowBlur,
                offset: const Offset(0, 0),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Magnetic button that follows mouse movement
class MagneticButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final Color bgColor;
  final double magneticRange;

  const MagneticButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.bgColor = accentPurple,
    this.magneticRange = 50.0,
  }) : super(key: key);

  @override
  State<MagneticButton> createState() => _MagneticButtonState();
}

class _MagneticButtonState extends State<MagneticButton> {
  Offset _offset = Offset.zero;
  Offset _mousePosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final center = box.localToGlobal(box.size.center(Offset.zero));

        setState(() {
          _mousePosition = event.position;

          final distance = (_mousePosition - center).distance;
          if (distance < widget.magneticRange) {
            final angle = (_mousePosition - center).direction;
            _offset = Offset(
              math.cos(angle) * (widget.magneticRange - distance) * 0.3,
              math.sin(angle) * (widget.magneticRange - distance) * 0.3,
            );
          } else {
            _offset = Offset.zero;
          }
        });
      },
      onExit: (_) {
        setState(() {
          _offset = Offset.zero;
        });
      },
      cursor: SystemMouseCursors.click,
      child: Transform.translate(
        offset: _offset,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [glowShadow],
            ),
            child: Text(
              widget.label,
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
