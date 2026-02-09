import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/app_theme.dart';

class Footer extends StatelessWidget {
  final void Function(int sectionIndex)? onNavTap;

  const Footer({super.key, this.onNavTap});

  // URLs dos seus perfis (troque pelos seus links reais)
  static const String githubUrl = 'https://github.com/gmorais671';
  static const String linkedinUrl =
      'https://www.linkedin.com/in/gabriel-morais-marcondes/';

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Não foi possível abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "© ${DateTime.now().year} Gabriel Morais Marcondes",
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Text(
            "Feito com Flutter & Python",
            style: const TextStyle(color: Colors.white24, fontSize: 12),
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            children: [
              TextButton(
                onPressed: () => onNavTap?.call(0),
                child: const Text(
                  "Home",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              TextButton(
                onPressed: () => onNavTap?.call(1),
                child: const Text(
                  "Projetos",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              TextButton(
                onPressed: () => onNavTap?.call(2),
                child: const Text(
                  "Contato",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              TextButton(
                onPressed: () => _launchUrl(githubUrl),
                child: Text(
                  "GitHub",
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
              TextButton(
                onPressed: () => _launchUrl(linkedinUrl),
                child: Text(
                  "LinkedIn",
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
