import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../res/constants.dart';

class ConnectButton extends StatefulWidget {
  const ConnectButton({super.key});

  @override
  State<ConnectButton> createState() => _ConnectButtonState();
}

class _ConnectButtonState extends State<ConnectButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            launchUrl(Uri.parse('https://wa.me/+233257234802'));
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 60,
            width: _isHovering ? 160 : 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultPadding),
              gradient: _isHovering
                  ? const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [accentCyan, accentGreen],
                    )
                  : modernGradient,
              boxShadow: [
                BoxShadow(
                  color: accentPurple.withOpacity(_isHovering ? 0.4 : 0.2),
                  offset: const Offset(0, 8),
                  blurRadius: _isHovering ? 25 : 15,
                  spreadRadius: _isHovering ? 3 : 0,
                ),
              ],
            ),
            transform: Matrix4.identity()..scale(_isHovering ? 1.05 : 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedPadding(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.only(right: _isHovering ? 8 : 4),
                  child: const Icon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                Text(
                  'Connect',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: primaryColor,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
