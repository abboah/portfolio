import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/res/floating_animations.dart';

import '../../../res/constants.dart';

class DownloadButton extends StatefulWidget {
  const DownloadButton({super.key});

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () {
          launchUrl(
            Uri.parse(
              'https://drive.google.com/file/d/1HSIe7rdk8VtrAL4DQuybfMHQgDrQ6xNs/view?usp=sharing',
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: modernGradient,
            boxShadow: [
              BoxShadow(
                color: accentPurple.withOpacity(_isHovering ? 0.4 : 0.2),
                blurRadius: _isHovering ? 25 : 15,
                spreadRadius: _isHovering ? 3 : 0,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: accentCyan.withOpacity(_isHovering ? 0.3 : 0.1),
                blurRadius: _isHovering ? 20 : 10,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          transform: Matrix4.identity()..scale(_isHovering ? 1.05 : 1.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Download CV',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: primaryColor,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              Icon(FontAwesomeIcons.download, color: primaryColor, size: 14),
            ],
          ),
        ),
      ),
    );
  }
}
