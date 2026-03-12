import 'package:flutter/material.dart';
import 'package:portfolio/res/constants.dart';
import 'package:portfolio/res/floating_animations.dart';

class MyPortfolioText extends StatelessWidget {
  const MyPortfolioText({super.key, required this.start, required this.end});
  final double start;
  final double end;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: start, end: end),
          duration: const Duration(milliseconds: 600),
          builder: (context, value, child) {
            return TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOut,
              builder: (context, opacity, widget) {
                return Transform.translate(
                  offset: Offset(0, (1 - opacity) * 30),
                  child: Opacity(
                    opacity: opacity,
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            primaryColor,
                            accentCyan.withOpacity(0.8),
                            accentPurple.withOpacity(0.8),
                          ],
                          stops: const [0, 0.5, 1],
                        ).createShader(bounds);
                      },
                      child: Text(
                        'Festus Abboah',
                        style: Theme.of(context).textTheme.displayLarge!
                            .copyWith(
                              color: primaryColor,
                              fontWeight: FontWeight.w900,
                              fontSize: value,
                              letterSpacing: -1.5,
                            ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
