import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/view%20model/getx_controllers/certification_controller.dart';
import 'package:portfolio/res/modern_widgets.dart';
import 'package:get/get.dart';
import '../../res/constants.dart';
import '../../view model/responsive.dart';
import 'components/certification_grid.dart';

class Certifications extends StatelessWidget {
  final controller = Get.put(CertificationController());
  Certifications({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isLargeMobile(context))
            const SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              builder: (context, value, widget) {
                return Transform.translate(
                  offset: Offset((1 - value) * -30, 0),
                  child: Opacity(
                    opacity: value,
                    child: ModernSectionTitle(
                      title: 'Certifications',
                      subtitle: 'Professional credentials and achievements',
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: defaultPadding * 1.5),
          Expanded(
            child: Responsive(
              desktop: CertificateGrid(crossAxisCount: 3, ratio: 1.5),
              extraLargeScreen: CertificateGrid(crossAxisCount: 4, ratio: 1.6),
              largeMobile: CertificateGrid(crossAxisCount: 1, ratio: 1.8),
              mobile: CertificateGrid(crossAxisCount: 1, ratio: 1.4),
              tablet: CertificateGrid(ratio: 1.7, crossAxisCount: 2),
            ),
          ),
        ],
      ),
    );
  }
}
