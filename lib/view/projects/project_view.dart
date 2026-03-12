import 'package:flutter/material.dart';
import 'package:portfolio/res/constants.dart';
import 'package:portfolio/view%20model/getx_controllers/projects_controller.dart';
import 'package:portfolio/view%20model/responsive.dart';
import 'package:portfolio/res/modern_widgets.dart';
import 'package:get/get.dart';
import 'components/projects_grid.dart';

class ProjectsView extends StatelessWidget {
  ProjectsView({super.key});
  final controller = Get.put(ProjectController());
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
                      title: 'Projects',
                      subtitle: 'Showcasing my latest work and experience',
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: defaultPadding * 1.5),
          Expanded(
            child: Responsive(
              desktop: ProjectGrid(crossAxisCount: 3),
              extraLargeScreen: ProjectGrid(crossAxisCount: 4),
              largeMobile: ProjectGrid(crossAxisCount: 1, ratio: 1.8),
              mobile: ProjectGrid(crossAxisCount: 1, ratio: 1.5),
              tablet: ProjectGrid(ratio: 1.4, crossAxisCount: 2),
            ),
          ),
        ],
      ),
    );
  }
}
