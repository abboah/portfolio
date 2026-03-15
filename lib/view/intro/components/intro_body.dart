import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../../../res/constants.dart';
import '../../../view model/responsive.dart';
import 'combine_subtitle.dart';
import 'description_text.dart';
import 'download_button.dart';
import 'headline_text.dart';
import 'animated_decorative_background.dart';

class IntroBody extends StatelessWidget {
  const IntroBody({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return AnimatedDecorativeBackground(
      child: Row(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!Responsive.isDesktop(context))
                  SizedBox(height: size.height * 0.06),
                if (!Responsive.isDesktop(context))
                  Row(
                    children: [
                      SizedBox(width: size.width * 0.23),
                      Container(
                        width: 150,
                        height: 200,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.blue.withOpacity(0.5),
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.asset(
                            'images/me.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (!Responsive.isDesktop(context))
                  SizedBox(height: size.height * 0.1),
                // Hero headline with animation
                const Responsive(
                  desktop: MyPortfolioText(start: 40, end: 50),
                  largeMobile: MyPortfolioText(start: 40, end: 35),
                  mobile: MyPortfolioText(start: 35, end: 30),
                  tablet: MyPortfolioText(start: 50, end: 40),
                ),
                if (kIsWeb && Responsive.isLargeMobile(context))
                  Container(height: defaultPadding, color: Colors.transparent),
                // Subtitle with animation
                const CombineSubtitleText(),
                const SizedBox(height: defaultPadding / 2),
                // Description text with animation
                const Responsive(
                  desktop: AnimatedDescriptionText(start: 14, end: 15),
                  largeMobile: AnimatedDescriptionText(start: 14, end: 12),
                  mobile: AnimatedDescriptionText(start: 14, end: 12),
                  tablet: AnimatedDescriptionText(start: 17, end: 14),
                ),
                const SizedBox(height: defaultPadding * 2),
                // Download button with animation
                const DownloadButton(),
              ],
            ),
          ),
          const Spacer(),
          if (Responsive.isDesktop(context))
            Container(
              width: 250,
              height: 300,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.blue.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset('assets/images/me.png', fit: BoxFit.cover),
              ),
            ),
          const Spacer(),
        ],
      ),
    );
  }
}
