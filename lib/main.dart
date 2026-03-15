import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/res/constants.dart';
import 'package:portfolio/view/splash/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: accentPurple,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: bgColor,
        useMaterial3: true,
        // Enhanced typography
        textTheme:
            GoogleFonts.interTextTheme(
              Theme.of(context).textTheme.apply(
                bodyColor: lightTextColor,
                displayColor: lightTextColor,
              ),
            ).copyWith(
              displayLarge: GoogleFonts.inter(
                fontSize: 56,
                fontWeight: FontWeight.w900,
                color: primaryColor,
                letterSpacing: -2,
              ),
              displayMedium: GoogleFonts.inter(
                fontSize: 44,
                fontWeight: FontWeight.w800,
                color: primaryColor,
                letterSpacing: -1,
              ),
              displaySmall: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: primaryColor,
                letterSpacing: -0.5,
              ),
              headlineMedium: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
              bodyLarge: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: bodyTextColor,
              ),
              bodyMedium: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: bodyTextColor,
              ),
              labelLarge: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: accentCyan,
              ),
            ),
        // Smooth transitions
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: ZoomPageTransitionsBuilder(),
            TargetPlatform.linux: ZoomPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),

      home: const SplashView(),
    );
  }
}
