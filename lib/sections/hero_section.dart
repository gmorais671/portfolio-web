import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_theme.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onContactClick;
  const HeroSection({super.key, required this.onContactClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "OLÁ, EU SOU O GABRIEL",
            style: GoogleFonts.poppins(
              fontSize: 18,
              letterSpacing: 4,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Desenvolvedor Fullstack\n& Entusiasta de Tecnologia.",
            style: GoogleFonts.poppins(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: onContactClick,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            ),
            child: const Text(
              "VAMOS CONVERSAR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
