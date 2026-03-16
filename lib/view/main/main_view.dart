import 'package:flutter/material.dart';
import 'package:portfolio/view%20model/controller.dart';
import 'package:portfolio/res/constants.dart';
import 'package:portfolio/view/main/components/navigation_bar.dart';
import 'package:portfolio/res/smooth_scroll_widgets.dart';
import '../../view model/responsive.dart';
import 'components/drawer/drawer.dart';
import 'components/navigation_button_list.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MainView extends StatefulWidget {
  const MainView({super.key, required this.pages});
  final List<Widget> pages;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late PageController _scrollController;
  bool _showScrollToTop = true;

  @override
  void initState() {
    super.initState();
    _scrollController = controller;
    _scrollController.addListener(_updateScrollToTopVisibility);
  }

  void _updateScrollToTopVisibility() {
    final currentPage = _scrollController.page ?? 0;
    setState(() {
      _showScrollToTop = currentPage > 0.5;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollToTopVisibility);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                kIsWeb && !Responsive.isLargeMobile(context)
                    ? const SizedBox(height: defaultPadding * 2)
                    : const SizedBox(height: defaultPadding / 2),
                const SizedBox(height: 80, child: TopNavigationBar()),
                if (Responsive.isLargeMobile(context))
                  const Row(
                    children: [Spacer(), NavigationButtonList(), Spacer()],
                  ),
                Expanded(
                  flex: 9,
                  child: PageView(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _scrollController,
                    children: [...widget.pages],
                  ),
                ),
              ],
            ),
          ),
          // Smooth page indicator on the right
          if (!Responsive.isLargeMobile(context))
            Positioned(
              right: 24,
              top: 0,
              bottom: 0,
              child: Center(
                child: SmoothPageIndicator(
                  pageController: _scrollController,
                  pageCount: widget.pages.length,
                ),
              ),
            ),
          // Scroll to top button (bottom right)
          Positioned(
            right: 24,
            bottom: 24,
            child: ScrollToTopButton(
              pageController: _scrollController,
              visible: _showScrollToTop,
            ),
          ),
        ],
      ),
    );
  }
}
