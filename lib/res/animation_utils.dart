import 'package:flutter/material.dart';
import 'package:portfolio/res/constants.dart';
import 'dart:math' as math;

class AnimationUtils {
  // Smooth fade-in animation with slide
  static Widget fadeInUp(Widget child, {int delayMs = 0}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      builder: (context, value, widget) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 30),
          child: Opacity(opacity: value, child: child),
        );
      },
    );
  }

  // Scale pop animation
  static Widget scaleIn(Widget child, {int delayMs = 0}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      builder: (context, value, widget) {
        return Transform.scale(
          scale: value,
          child: Opacity(opacity: value, child: child),
        );
      },
    );
  }

  // Rotating animation
  static Widget rotateIn(Widget child, {int delayMs = 0}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: -0.1, end: 0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, value, widget) {
        return Transform.rotate(
          angle: value,
          child: Opacity(opacity: (value + 0.1) / 0.1, child: child),
        );
      },
    );
  }

  // Slide from left
  static Widget slideInFromLeft(Widget child, {int delayMs = 0}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOut,
      builder: (context, value, widget) {
        return Transform.translate(
          offset: Offset((1 - value) * -100, 0),
          child: Opacity(opacity: value, child: child),
        );
      },
    );
  }

  // Slide from right
  static Widget slideInFromRight(Widget child, {int delayMs = 0}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOut,
      builder: (context, value, widget) {
        return Transform.translate(
          offset: Offset((1 - value) * 100, 0),
          child: Opacity(opacity: value, child: child),
        );
      },
    );
  }

  // Staggered animation for lists
  static List<Widget> staggeredAnimation(
    List<Widget> children, {
    int delayBetweenMs = 100,
  }) {
    return List.generate(
      children.length,
      (index) => TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOut,
        builder: (context, value, widget) {
          return Transform.translate(
            offset: Offset(0, (1 - value) * 30),
            child: Opacity(opacity: value, child: children[index]),
          );
        },
      ),
    );
  }

  // Glow effect container
  static Widget glowingContainer({
    required Widget child,
    Color glowColor = accentCyan,
    double radius = 15,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 5,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }

  // Floating animation (bouncing effect)
  static Widget floating(
    Widget child, {
    Duration duration = const Duration(seconds: 3),
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: duration,
      curve: Curves.easeInOut,
      builder: (context, value, widget) {
        final offset = (math.sin(value * math.pi * 2) * 10);
        return Transform.translate(offset: Offset(0, offset), child: child);
      },
    );
  }

  // Pulse animation (breathing effect)
  static Widget pulse(
    Widget child, {
    Duration duration = const Duration(milliseconds: 2000),
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 1.0, end: 1.05),
      duration: duration,
      curve: Curves.easeInOut,
      builder: (context, value, widget) {
        return Transform.scale(scale: value, child: child);
      },
    );
  }
}
