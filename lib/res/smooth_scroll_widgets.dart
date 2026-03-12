import 'package:flutter/material.dart';
import 'package:portfolio/res/constants.dart';

/// Smooth page indicator for current page position
class SmoothPageIndicator extends StatelessWidget {
  final PageController pageController;
  final int pageCount;
  final Color activeColor;
  final Color inactiveColor;
  final double indicatorSize;
  final double spacing;

  const SmoothPageIndicator({
    Key? key,
    required this.pageController,
    required this.pageCount,
    this.activeColor = accentCyan,
    this.inactiveColor = mutedTextColor,
    this.indicatorSize = 8.0,
    this.spacing = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: spacing / 2),
          child: AnimatedBuilder(
            animation: pageController,
            builder: (context, child) {
              final page = pageController.page ?? 0.0;
              final isActive = (page - index).abs() < 1;
              final scale = isActive ? 1.2 : 0.8;
              final opacity = isActive ? 1.0 : 0.4;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: indicatorSize * scale,
                height: indicatorSize * scale,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.lerp(inactiveColor, activeColor, opacity),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: activeColor.withOpacity(0.3),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

/// Horizontal smooth progress bar showing scroll progress
class SmoothProgressBar extends StatelessWidget {
  final PageController pageController;
  final int pageCount;
  final Color? progressColor;
  final double height;

  const SmoothProgressBar({
    Key? key,
    required this.pageController,
    required this.pageCount,
    this.progressColor,
    this.height = 3.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          final page = pageController.page ?? 0.0;
          final progress = page / (pageCount - 1);

          return Container(
            height: height,
            decoration: BoxDecoration(
              color: bodyTextColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(height / 2),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: MediaQuery.of(context).size.width * progress,
                height: height,
                decoration: BoxDecoration(
                  gradient: progressColor != null
                      ? LinearGradient(colors: [progressColor!, progressColor!])
                      : accentGradient,
                  borderRadius: BorderRadius.circular(height / 2),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Scroll down indicator with animation
class ScrollDownIndicator extends StatefulWidget {
  final VoidCallback? onTap;
  final Color color;

  const ScrollDownIndicator({Key? key, this.onTap, this.color = accentCyan})
    : super(key: key);

  @override
  State<ScrollDownIndicator> createState() => _ScrollDownIndicatorState();
}

class _ScrollDownIndicatorState extends State<ScrollDownIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.1).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_downward_rounded, color: widget.color, size: 24),
              const SizedBox(height: 4),
              Text(
                'Scroll',
                style: TextStyle(
                  color: widget.color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Floating scroll top button with smooth animation
class ScrollToTopButton extends StatefulWidget {
  final PageController pageController;
  final bool visible;

  const ScrollToTopButton({
    Key? key,
    required this.pageController,
    required this.visible,
  }) : super(key: key);

  @override
  State<ScrollToTopButton> createState() => _ScrollToTopButtonState();
}

class _ScrollToTopButtonState extends State<ScrollToTopButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 300),
      offset: widget.visible ? Offset.zero : const Offset(0, 2),
      child: AnimatedOpacity(
        opacity: widget.visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovering = true),
          onExit: (_) => setState(() => _isHovering = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.visible
                ? () {
                    widget.pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOutCubic,
                    );
                  }
                : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: _isHovering ? accentGradient : modernGradient,
                boxShadow: [
                  BoxShadow(
                    color: accentCyan.withOpacity(_isHovering ? 0.4 : 0.2),
                    blurRadius: _isHovering ? 25 : 15,
                    spreadRadius: _isHovering ? 3 : 0,
                  ),
                ],
              ),
              transform: Matrix4.identity()..scale(_isHovering ? 1.1 : 1.0),
              child: const Icon(
                Icons.arrow_upward_rounded,
                color: primaryColor,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
