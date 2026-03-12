import 'package:flutter/material.dart';
import 'package:portfolio/res/constants.dart';

class NavigationTextButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final bool isActive;

  const NavigationTextButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isActive = false,
  });

  @override
  State<NavigationTextButton> createState() => _NavigationTextButtonState();
}

class _NavigationTextButtonState extends State<NavigationTextButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 14,
                fontWeight: _isHovering || widget.isActive
                    ? FontWeight.w700
                    : FontWeight.w600,
                color: _isHovering || widget.isActive
                    ? accentCyan
                    : primaryColor,
                letterSpacing: 0.5,
              ),
              child: Text(widget.text),
            ),
            // Animated underline
            if (_isHovering || widget.isActive)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 2,
                width: _isHovering || widget.isActive ? 24 : 0,
                margin: const EdgeInsets.only(top: 6),
                decoration: BoxDecoration(
                  gradient: accentGradient,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
