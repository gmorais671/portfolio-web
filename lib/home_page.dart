import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/sections/contacr_section.dart';
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

  void _scrollTo(double offset) {
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.8),
        elevation: 0,
        title: Text(
          'G.',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => _scrollTo(0),
            child: const Text('Home', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => _scrollTo(800),
            child: const Text(
              'Projetos',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () => _scrollTo(1600),
            child: const Text('Contato', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HeroSection(onContactClick: () => _scrollTo(1600)),
            const ProjectsSection(),
            const ContactSection(), // Substitua o Container antigo por este
            Footer(
              onNavTap: (index) {
                if (index == 0) _scrollTo(0);
                if (index == 1) _scrollTo(800);
                if (index == 2) _scrollTo(1600);
              },
            ),
          ],
        ),
      ),
    );
  }
}
