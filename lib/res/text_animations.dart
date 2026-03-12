import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:portfolio/res/constants.dart';

/// Animated gradient text that shifts colors
class AnimatedGradientText extends StatefulWidget {
  final String text;
  final List<Color> gradientColors;
  final TextStyle baseStyle;
  final Duration animationDuration;

  const AnimatedGradientText(
    this.text, {
    Key? key,
    this.gradientColors = const [accentPurple, accentCyan, accentGreen],
    required this.baseStyle,
    this.animationDuration = const Duration(seconds: 3),
  }) : super(key: key);

  @override
  State<AnimatedGradientText> createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<AnimatedGradientText>
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
        return ShaderMask(
          shaderCallback: (bounds) {
            final colors = widget.gradientColors;
            final stops = List.generate(colors.length, (index) {
              final basePos = index / (colors.length - 1);
              return (basePos + _controller.value).remainder(1.0);
            })..sort();

            return LinearGradient(
              colors: colors,
              stops: stops,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            style: widget.baseStyle.copyWith(color: primaryColor),
          ),
        );
      },
    );
  }
}

/// Split text animation that reveals text from center
class SplitTextAnimation extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration totalDuration;
  final Curve curve;

  const SplitTextAnimation(
    this.text, {
    Key? key,
    required this.style,
    this.totalDuration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOutCubic,
  }) : super(key: key);

  @override
  State<SplitTextAnimation> createState() => _SplitTextAnimationState();
}

class _SplitTextAnimationState extends State<SplitTextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.totalDuration,
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final midpoint = widget.text.length ~/ 2;

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          // Left side (moves from left)
          SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: _controller, curve: widget.curve),
                ),
            child: Text(
              widget.text.substring(0, midpoint),
              style: widget.style,
            ),
          ),
          // Right side (moves from right)
          SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                .animate(
                  CurvedAnimation(parent: _controller, curve: widget.curve),
                ),
            child: Text(widget.text.substring(midpoint), style: widget.style),
          ),
        ],
      ),
    );
  }
}

/// Staggered letter animation
class StaggeredLetterAnimation extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration letterDelay;
  final Duration duration;
  final Curve curve;

  const StaggeredLetterAnimation(
    this.text, {
    Key? key,
    required this.style,
    this.letterDelay = const Duration(milliseconds: 50),
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOut,
  }) : super(key: key);

  @override
  State<StaggeredLetterAnimation> createState() =>
      _StaggeredLetterAnimationState();
}

class _StaggeredLetterAnimationState extends State<StaggeredLetterAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration + (widget.letterDelay * widget.text.length),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(widget.text.length, (index) {
        final charDelay = widget.letterDelay * index;
        final delayRatio =
            charDelay.inMilliseconds /
            (widget.duration.inMilliseconds +
                (widget.letterDelay * widget.text.length).inMilliseconds);

        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
              .animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Interval(
                    delayRatio,
                    (delayRatio + 0.1).clamp(0.0, 1.0),
                    curve: widget.curve,
                  ),
                ),
              ),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Interval(
                  delayRatio,
                  (delayRatio + 0.1).clamp(0.0, 1.0),
                  curve: widget.curve,
                ),
              ),
            ),
            child: Text(widget.text[index], style: widget.style),
          ),
        );
      }),
    );
  }
}

/// Shimmer loading effect
class ShimmerEffect extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Color baseColor;
  final Color highlightColor;

  const ShimmerEffect({
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.baseColor = const Color(0xFF1A1A2E),
    this.highlightColor = const Color(0xFF2D2D4F),
  }) : super(key: key);

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: [
                _shimmerController.value - 0.3,
                _shimmerController.value,
                _shimmerController.value + 0.3,
              ].map((e) => e.clamp(0.0, 1.0)).toList(),
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}

/// Bounce animation widget
class BounceAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double bounceHeight;

  const BounceAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.bounceHeight = 20.0,
  }) : super(key: key);

  @override
  State<BounceAnimation> createState() => _BounceAnimationState();
}

class _BounceAnimationState extends State<BounceAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat();

    _animation = Tween<double>(
      begin: 0,
      end: 1,
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
        final bounce =
            (math.sin(_animation.value * math.pi * 2) *
            widget.bounceHeight *
            (1 - _animation.value));

        return Transform.translate(
          offset: Offset(0, bounce),
          child: widget.child,
        );
      },
    );
  }
}
