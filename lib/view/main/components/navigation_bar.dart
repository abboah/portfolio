import 'package:flutter/material.dart';
import 'package:portfolio/view%20model/responsive.dart';
import 'package:portfolio/view/intro/components/side_menu_button.dart';
import 'package:portfolio/view/main/components/connect_button.dart';
import '../../../res/constants.dart';
import 'navigation_button_list.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: accentCyan.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: !Responsive.isLargeMobile(context)
                  ? MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Image.asset(
                        'assets/images/triange_icon.png',
                        width: 32,
                        height: 32,
                      ),
                    )
                  : MenuButton(onTap: () => Scaffold.of(context).openDrawer()),
            ),
            const Spacer(flex: 2),
            if (!Responsive.isLargeMobile(context))
              const NavigationButtonList(),
            const Spacer(flex: 2),
            const ConnectButton(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
