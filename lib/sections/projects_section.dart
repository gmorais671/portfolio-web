import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(80),
      color: const Color(0xFF121212),
      child: Column(
        children: [
          const Text(
            "PROJETOS SELECIONADOS",
            style: TextStyle(letterSpacing: 2, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 40),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: MediaQuery.of(context).size.width > 900 ? 2 : 1,
            childAspectRatio: 1.5,
            mainAxisSpacing: 30,
            crossAxisSpacing: 30,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _projectCard("E-commerce API", "FastAPI & PostgreSQL"),
              _projectCard("App de Finanças", "Flutter & Firebase"),
              _projectCard("Dashboard Logística", "React & Node.js"),
              _projectCard("Este Portfólio", "Flutter & Python"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _projectCard(String title, String tech) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(tech, style: const TextStyle(color: AppColors.primary)),
          ],
        ),
      ),
    );
  }
}
