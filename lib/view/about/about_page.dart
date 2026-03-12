import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/res/constants.dart';
import 'package:portfolio/res/modern_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../view model/getx_controllers/about_controller.dart';

class AboutMePage extends StatelessWidget {
  AboutMePage({super.key});
  final controller = Get.put(AboutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Modern Section Title
            ModernSectionTitle(
              title: 'About Me',
              subtitle:
                  'Crafting digital experiences with passion and precision',
            ),

            const SizedBox(height: 30),

            // Profile Section with modern card
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: accentGradient,
                      boxShadow: [glowShadow],
                    ),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/images/profile.jpg"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Festus Abboah",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: modernGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Flutter Developer | Mobile & Web",
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // About Section
            ModernSectionTitle(title: 'Who Am I?'),
            const SizedBox(height: 12),
            Text(
              "Hi, I'm Festus Abboah — a dedicated Flutter developer with a passion for building meaningful digital experiences. I specialize in creating modern, responsive, and user-friendly applications for both mobile and web platforms.\n\n"
              "Over time, I've worked on projects ranging from real-time chat systems and ride-hailing features to e-commerce solutions and interactive learning tools. What excites me most is transforming complex problems into clean, intuitive, and scalable solutions that people actually enjoy using.\n\n"
              "Beyond writing code, I care deeply about design, usability, and performance. I strive to bridge the gap between great engineering and great user experiences, ensuring that every product I work on feels fast, reliable, and delightful.",
              style: TextStyle(color: bodyTextColor, height: 1.7, fontSize: 15),
            ),

            const SizedBox(height: 40),

            // Skills Section
            ModernSectionTitle(title: 'Skills & Tools'),
            const SizedBox(height: 12),
            Text(
              "My expertise spans across multiple technologies and tools. Here's what I work with:",
              style: TextStyle(color: bodyTextColor, height: 1.6, fontSize: 15),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                ModernSkillChip(label: "Flutter"),
                ModernSkillChip(label: "Dart"),
                ModernSkillChip(label: "Firebase"),
                ModernSkillChip(label: "Supabase"),
                ModernSkillChip(label: "REST APIs"),
                ModernSkillChip(label: "Git & GitHub"),
                ModernSkillChip(label: "UI/UX"),
                ModernSkillChip(label: "Responsive Design"),
                ModernSkillChip(label: "State Management"),
                ModernSkillChip(label: "Web Development"),
              ],
            ),

            const SizedBox(height: 40),

            // Connect Section
            ModernSectionTitle(title: "Let's Connect"),
            const SizedBox(height: 12),
            Text(
              "I'm always open to collaborating on exciting projects or discussing new opportunities.",
              style: TextStyle(color: bodyTextColor, height: 1.6, fontSize: 15),
            ),
            const SizedBox(height: 20),
            ModernContactCard(
              icon: Icons.email,
              title: "Email",
              value: "festusabboah10@gmail.com",
              onTap: () =>
                  launchUrl(Uri.parse("mailto:festusabboah10@gmail.com")),
            ),
            const SizedBox(height: 12),
            ModernContactCard(
              icon: Icons.code,
              title: "GitHub",
              value: "github.com/abboah",
              onTap: () => launchUrl(Uri.parse("https://github.com/abboah")),
            ),
            const SizedBox(height: 12),
            ModernContactCard(
              icon: Icons.work,
              title: "LinkedIn",
              value: "linkedin.com/in/festusabboah",
              onTap: () => launchUrl(
                Uri.parse("https://www.linkedin.com/in/festusabboah"),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

/// Modern skill chip with gradient and hover effect
class ModernSkillChip extends StatefulWidget {
  final String label;

  const ModernSkillChip({super.key, required this.label});

  @override
  State<ModernSkillChip> createState() => _ModernSkillChipState();
}

class _ModernSkillChipState extends State<ModernSkillChip> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: _isHovering
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    accentPurple.withOpacity(0.8),
                    accentCyan.withOpacity(0.6),
                  ],
                )
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    secondaryColor.withOpacity(0.6),
                    secondaryColor.withOpacity(0.3),
                  ],
                ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: accentCyan.withOpacity(_isHovering ? 0.4 : 0.2),
            width: 1.5,
          ),
          boxShadow: [
            if (_isHovering)
              BoxShadow(
                color: accentCyan.withOpacity(0.2),
                blurRadius: 15,
                spreadRadius: 2,
              ),
          ],
        ),
        transform: Matrix4.identity()..scale(_isHovering ? 1.08 : 1.0),
        child: Text(
          widget.label,
          style: TextStyle(
            color: _isHovering ? primaryColor : bodyTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}

/// Modern contact card with icon and link
class ModernContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const ModernContactCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  State<ModernContactCard> createState() => _ModernContactCardState();
}

class _ModernContactCardState extends State<ModernContactCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: ModernCard(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              secondaryColor.withOpacity(_isHovering ? 0.9 : 0.7),
              darkColor.withOpacity(_isHovering ? 0.6 : 0.4),
            ],
          ),
          borderRadius: 16,
          padding: const EdgeInsets.all(16),
          enableGlow: true,
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: _isHovering ? modernGradient : accentGradient,
                  boxShadow: [if (_isHovering) glowShadow],
                ),
                child: Icon(widget.icon, color: primaryColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: bodyTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.value,
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_outward,
                color: accentCyan.withOpacity(_isHovering ? 1.0 : 0.5),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
