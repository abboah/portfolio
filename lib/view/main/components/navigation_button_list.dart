import 'package:flutter/material.dart';
import 'package:portfolio/view%20model/controller.dart';
import 'package:portfolio/view%20model/responsive.dart';

import 'navigation_button.dart';

class NavigationButtonList extends StatelessWidget {
  const NavigationButtonList({super.key});
  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(
        text: 'Home',
        onTap: () => controller.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        ),
      ),
      if (!Responsive.isLargeMobile(context))
        _NavItem(
          text: 'About Me',
          onTap: () => controller.animateToPage(
            1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          ),
        ),
      _NavItem(
        text: 'Projects',
        onTap: () => controller.animateToPage(
          2,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        ),
      ),
      _NavItem(
        text: 'Certifications',
        onTap: () => controller.animateToPage(
          3,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        ),
      ),
      //   _NavItem(text: 'Achievements', onTap: () {}),
    ];

    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset((1 - value) * 50, 0),
          child: Opacity(
            opacity: value,
            child: Row(
              spacing: 32,
              children: List.generate(items.length, (index) {
                final itemDelay = (index * 0.1).clamp(0.0, 1.0);
                final itemProgress = ((value - itemDelay) / 0.6).clamp(
                  0.0,
                  1.0,
                );

                return Transform.translate(
                  offset: Offset((1 - itemProgress) * 20, 0),
                  child: Opacity(
                    opacity: itemProgress,
                    child: NavigationTextButton(
                      onTap: items[index].onTap,
                      text: items[index].text,
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

class _NavItem {
  final String text;
  final VoidCallback onTap;

  _NavItem({required this.text, required this.onTap});
}
