import 'package:flutter/material.dart';

/// Custom scroll physics for smooth, buttery scrolling experience
class SmoothScrollPhysics extends ScrollPhysics {
  const SmoothScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  SmoothScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SmoothScrollPhysics(parent: buildParent(ancestor));
  }

  // Custom friction for smooth deceleration
  double get frictionFactor => 0.05;

  @override
  Tolerance get tolerance => const Tolerance(velocity: 50.0, distance: 50.0);
}

/// Enhanced scroll behavior with momentum and deceleration
class EnhancedScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(parent: SmoothScrollPhysics());
  }

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

/// Smooth page scroll animator with easing curves
class SmoothPageScroller {
  final PageController controller;
  final Duration defaultDuration;
  final Curve defaultCurve;

  SmoothPageScroller({
    required this.controller,
    this.defaultDuration = const Duration(milliseconds: 600),
    this.defaultCurve = Curves.easeInOutCubic,
  });

  /// Scroll to page with smooth animation
  Future<void> scrollToPage(int page, {Duration? duration, Curve? curve}) {
    return controller.animateToPage(
      page,
      duration: duration ?? defaultDuration,
      curve: curve ?? defaultCurve,
    );
  }

  /// Scroll next page
  Future<void> nextPage({Duration? duration, Curve? curve}) async {
    final nextPage = (controller.page?.toInt() ?? 0) + 1;
    await scrollToPage(nextPage, duration: duration, curve: curve);
  }

  /// Scroll previous page
  Future<void> previousPage({Duration? duration, Curve? curve}) async {
    final prevPage = (controller.page?.toInt() ?? 0) - 1;
    await scrollToPage(prevPage, duration: duration, curve: curve);
  }

  /// Jump to page instantly
  void jumpToPage(int page) {
    controller.jumpToPage(page);
  }

  /// Dispose controller
  void dispose() {
    controller.dispose();
  }
}
