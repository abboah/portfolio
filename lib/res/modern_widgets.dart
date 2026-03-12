import 'package:flutter/material.dart';
import 'package:portfolio/res/constants.dart';

/// Modern glassmorphic card with smooth effects
class ModernCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final VoidCallback? onTap;
  final LinearGradient? gradient;
  final bool enableGlow;

  const ModernCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = 20,
    this.onTap,
    this.gradient,
    this.enableGlow = true,
  }) : super(key: key);

  @override
  State<ModernCard> createState() => _ModernCardState();
}

class _ModernCardState extends State<ModernCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: widget.padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient:
                widget.gradient ??
                LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    secondaryColor.withOpacity(0.8),
                    secondaryColor.withOpacity(0.3),
                  ],
                ),
            border: Border.all(
              color: accentCyan.withOpacity(_isHovering ? 0.3 : 0.1),
              width: 1.5,
            ),
            boxShadow: [
              if (widget.enableGlow)
                BoxShadow(
                  color: accentCyan.withOpacity(_isHovering ? 0.2 : 0.05),
                  blurRadius: _isHovering ? 30 : 15,
                  spreadRadius: _isHovering ? 5 : 2,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          transform: Matrix4.identity()..scale(_isHovering ? 1.02 : 1.0),
          child: widget.child,
        ),
      ),
    );
  }
}

/// Modern gradient button with smooth interactions
class ModernGradientButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final LinearGradient? gradient;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const ModernGradientButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.gradient,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
  }) : super(key: key);

  @override
  State<ModernGradientButton> createState() => _ModernGradientButtonState();
}

class _ModernGradientButtonState extends State<ModernGradientButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: widget.padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: widget.gradient ?? modernGradient,
            boxShadow: [
              BoxShadow(
                color: accentPurple.withOpacity(_isHovering ? 0.4 : 0.2),
                blurRadius: _isHovering ? 25 : 15,
                spreadRadius: _isHovering ? 3 : 0,
              ),
            ],
          ),
          transform: Matrix4.identity()..scale(_isHovering ? 1.05 : 1.0),
          child: Text(
            widget.label,
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

/// Modern section title with accent line
class ModernSectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Alignment accentAlignment;

  const ModernSectionTitle({
    Key? key,
    required this.title,
    this.subtitle,
    this.accentAlignment = Alignment.centerLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Accent line
            Container(
              width: 4,
              height: 32,
              decoration: BoxDecoration(
                gradient: accentGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: primaryColor,
                letterSpacing: -1,
              ),
            ),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: const TextStyle(
              fontSize: 14,
              color: bodyTextColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }
}

/// Animated text with typewriter effect
class AnimatedTypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;

  const AnimatedTypewriterText({
    Key? key,
    required this.text,
    this.style = const TextStyle(fontSize: 16, color: bodyTextColor),
    this.duration = const Duration(milliseconds: 50),
  }) : super(key: key);

  @override
  State<AnimatedTypewriterText> createState() => _AnimatedTypewriterTextState();
}

class _AnimatedTypewriterTextState extends State<AnimatedTypewriterText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _characterCount;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration * widget.text.length,
      vsync: this,
    );

    _characterCount = IntTween(
      begin: 0,
      end: widget.text.length,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _characterCount,
      builder: (context, child) {
        return Text(
          widget.text.substring(0, _characterCount.value),
          style: widget.style,
        );
      },
    );
  }
}

/// Smooth transition container
class SmoothPageTransition extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const SmoothPageTransition({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOutCubic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
