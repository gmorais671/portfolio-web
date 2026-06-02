import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/sections/about_section.dart';
import 'package:portfolio_web/sections/contact_section.dart';
import 'package:portfolio_web/widgets/footer.dart';
import 'core/app_theme.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  final homeKey = GlobalKey();       // Hero Section
  final projectsKey = GlobalKey();   // Projects Section
  final aboutKey = GlobalKey();      // About Me Section
  final contactKey = GlobalKey();    // Contact Section

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.8),
        elevation: 0,
        title: Text(
          'Gabriel M.',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => _scrollTo(homeKey),
            child: const Text('Home', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => _scrollTo(projectsKey),
            child: const Text('Projetos', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => _scrollTo(aboutKey),
            child: const Text('Sobre Mim', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => _scrollTo(contactKey),
            child: const Text('Contato', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HeroSection(key: homeKey, onContactClick: () => _scrollTo(contactKey)),
            ProjectsSection(key: projectsKey),
            AboutMeSection(key: aboutKey),
            ContactSection(key: contactKey),
            Footer(
              onNavTap: (index) {
                switch (index) {
                  case 0:
                    _scrollTo(homeKey);
                    break;
                  case 1:
                    _scrollTo(projectsKey);
                    break;
                  case 2:
                    _scrollTo(aboutKey);
                    break;
                  case 3:
                    _scrollTo(contactKey);
                    break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}