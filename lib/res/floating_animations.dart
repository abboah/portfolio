import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'constants.dart';

/// Floating animation that creates a smooth bobbing motion
class FloatingWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double offset;
  final Curve curve;

  const FloatingWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 3000),
    this.offset = 20,
    this.curve = Curves.easeInOut,
  });

  @override
  State<FloatingWidget> createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<FloatingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -widget.offset,
      end: widget.offset,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Staggered floating animation for multiple items
class StaggeredFloatingWidget extends StatefulWidget {
  final Widget child;
  final int staggerIndex;
  final Duration duration;
  final double offset;
  final Duration staggerDelay;

  const StaggeredFloatingWidget({
    super.key,
    required this.child,
    this.staggerIndex = 0,
    this.duration = const Duration(milliseconds: 3000),
    this.offset = 20,
    this.staggerDelay = const Duration(milliseconds: 150),
  });

  @override
  State<StaggeredFloatingWidget> createState() =>
      _StaggeredFloatingWidgetState();
}

class _StaggeredFloatingWidgetState extends State<StaggeredFloatingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    // Stagger the start time
    Future.delayed(widget.staggerDelay * widget.staggerIndex, () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });

    _animation = Tween<double>(
      begin: -widget.offset,
      end: widget.offset,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Rotating floating widget with glow effect (tech aesthetic)
class RotatingFloatingOrb extends StatefulWidget {
  final double size;
  final List<Color> colors;
  final Duration duration;
  final double floatOffset;

  const RotatingFloatingOrb({
    super.key,
    this.size = 200,
    this.colors = const [accentCyan, accentPurple, accentPink],
    this.duration = const Duration(milliseconds: 8000),
    this.floatOffset = 25,
  });

  @override
  State<RotatingFloatingOrb> createState() => _RotatingFloatingOrbState();
}

class _RotatingFloatingOrbState extends State<RotatingFloatingOrb>
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
        return Transform.translate(
          offset: Offset(
            0,
            math.sin(_controller.value * 2 * math.pi) * widget.floatOffset,
          ),
          child: Transform.rotate(
            angle: _controller.value * 2 * math.pi,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: widget.colors,
                  stops: const [0, 0.5, 1],
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.colors.first.withOpacity(0.5),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Glowing animated text background
class GlowingBackgroundOrb extends StatefulWidget {
  final double size;
  final Color color;
  final Duration duration;
  final Offset offset;
  final double blur;

  const GlowingBackgroundOrb({
    super.key,
    this.size = 400,
    this.color = accentCyan,
    this.duration = const Duration(milliseconds: 6000),
    this.offset = const Offset(0, -100),
    this.blur = 80,
  });

  @override
  State<GlowingBackgroundOrb> createState() => _GlowingBackgroundOrbState();
}

class _GlowingBackgroundOrbState extends State<GlowingBackgroundOrb>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat(reverse: true);
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
        return Positioned(
          left: widget.offset.dx,
          top: widget.offset.dy + (_controller.value - 0.5) * 100,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(
                    0.3 + _controller.value * 0.2,
                  ),
                  blurRadius: widget.blur,
                  spreadRadius: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Interactive floating card with hover effects
class FloatingCard extends StatefulWidget {
  final Widget child;
  final Duration floatDuration;
  final double floatOffset;
  final VoidCallback? onHover;
  final VoidCallback? onHoverEnd;

  const FloatingCard({
    super.key,
    required this.child,
    this.floatDuration = const Duration(milliseconds: 3000),
    this.floatOffset = 15,
    this.onHover,
    this.onHoverEnd,
  });

  @override
  State<FloatingCard> createState() => _FloatingCardState();
}

class _FloatingCardState extends State<FloatingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.floatDuration,
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -widget.floatOffset,
      end: widget.floatOffset,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovering = true);
        widget.onHover?.call();
      },
      onExit: (_) {
        setState(() => _isHovering = false);
        widget.onHoverEnd?.call();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _isHovering ? 0 : _animation.value),
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}

/// Pulse glow effect
class PulseGlow extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final Duration duration;

  const PulseGlow({
    super.key,
    required this.child,
    this.glowColor = accentCyan,
    this.duration = const Duration(milliseconds: 2000),
  });

  @override
  State<PulseGlow> createState() => _PulseGlowState();
}

class _PulseGlowState extends State<PulseGlow>
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
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withOpacity(
                  0.5 + _controller.value * 0.3,
                ),
                blurRadius: 20 + _controller.value * 20,
                spreadRadius: _controller.value * 5,
              ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
