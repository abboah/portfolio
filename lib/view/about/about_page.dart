import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/view/projects/components/title_text.dart';
import '../../view model/getx_controllers/about_controller.dart';

class AboutMePage extends StatelessWidget {
  AboutMePage({super.key});
  final controller = Get.put(AboutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const TitleText(prefix: 'About', title: 'Me'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(
                      "assets/images/profile.jpg",
                    ), // replace with your image
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Festus Abboah",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Flutter Developer | Mobile & Web",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // About Section
            Text(
              "Who Am I?",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Hi, I’m Festus Abboah — a dedicated Flutter developer with a passion for building meaningful digital experiences. I specialize in creating modern, responsive, and user-friendly applications for both mobile and web platforms.\n\n"
              "Over time, I’ve worked on projects ranging from real-time chat systems and ride-hailing features to e-commerce solutions and interactive learning tools. What excites me most is transforming complex problems into clean, intuitive, and scalable solutions that people actually enjoy using.\n\n"
              "Beyond writing code, I care deeply about design, usability, and performance. I strive to bridge the gap between great engineering and great user experiences, ensuring that every product I work on feels fast, reliable, and delightful. I’m constantly learning, experimenting, and improving — because in tech, there’s always a new challenge to take on.",
              style: TextStyle(color: Colors.grey[300], height: 1.5),
            ),

            const SizedBox(height: 30),

            // Skills Section
            Text(
              "What I Work With",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "My core stack revolves around Flutter and Dart, but I also work with tools and platforms that bring ideas to life and keep products scalable. Here are some of the areas I’m confident in:",
              style: TextStyle(color: Colors.grey[300], height: 1.5),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                SkillChip(label: "Flutter"),
                SkillChip(label: "Dart"),
                SkillChip(label: "Firebase"),
                SkillChip(label: "Supabase"),
                SkillChip(label: "REST APIs"),
                SkillChip(label: "Git & GitHub"),
                SkillChip(label: "UI/UX Implementation"),
                SkillChip(label: "Responsive Design"),
              ],
            ),

            const SizedBox(height: 30),

            // Contact Section
            Text(
              "Let’s Connect",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "I’m always open to collaborating on exciting projects, contributing to innovative teams, or simply having conversations about tech, design, and growth. Whether it’s a freelance project, a startup idea, or a full-time role, I’d love to hear from you.",
              style: TextStyle(color: Colors.grey[300], height: 1.5),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.white),
              title: const Text(
                "festusabboah.dev@gmail.com",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.link, color: Colors.white),
              title: const Text(
                "github.com/festusabboah",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.work, color: Colors.white),
              title: const Text(
                "linkedin.com/in/festusabboah",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class SkillChip extends StatelessWidget {
  final String label;
  const SkillChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.blueGrey[800],
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
