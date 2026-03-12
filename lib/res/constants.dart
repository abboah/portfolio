import 'package:flutter/material.dart';

// Modern Tech Color Palette — Blackout Edition
const primaryColor = Colors.white;
const secondaryColor = Color(0xFF0D0D0D); // Near black
const darkColor = Color(0xFF050505); // True black

// Accents dimmed to glow subtly on pure black
const accentPurple = Color(0xFF4C1D95); // Dark deep purple
const accentCyan = Color(0xFF164E63); // Dark deep cyan
const accentGreen = Color(0xFF064E3B); // Dark deep emerald
const accentPink = Color(0xFF831843); // Dark deep pink

// Text colors
const bodyTextColor = Color(0xFF6B7280); // Dim grey
const lightTextColor = Color(0xFFD1D5DB); // Faded white
const mutedTextColor = Color(0xFF374151); // Very dark grey

// Background
const bgColor = Color(0xFF080808); // Near-pure black

// Gradients
const LinearGradient modernGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [accentPurple, accentCyan],
);

const LinearGradient heroGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF4C1D95), Color(0xFF1E3A8A), Color(0xFF0D0D0D)],
);

const LinearGradient accentGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [accentCyan, accentGreen],
);

const defaultPadding = 20.0;

// Shadows — tight and dark, barely-there glow
const BoxShadow modernShadow = BoxShadow(
  color: Color(0x404C1D95),
  blurRadius: 16,
  offset: Offset(0, 8),
);

const BoxShadow glowShadow = BoxShadow(
  color: Color(0x33164E63),
  blurRadius: 28,
  offset: Offset(0, 8),
  spreadRadius: 2,
);
