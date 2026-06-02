import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_theme.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determina se é mobile (< 800px)
        bool isMobile = constraints.maxWidth < 800;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
          width: double.infinity,
          color: const Color(0xFF121212), // Mantém consistência com ProjectsSection
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SOBRE MIM",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Conheça um pouco mais sobre minha trajetória profissional...",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              if (isMobile)
                _buildMobileContent()
              else
                _buildDesktopContent(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileContent() {
    // Conteúdo para dispositivos móveis: imagem seguida do texto
    return Column(
      children: [
        _buildProfileImage(),
        const SizedBox(height: 40),
        _buildAboutText(),
      ],
    );
  }

  Widget _buildDesktopContent() {
    // Conteúdo para desktop: lado a lado
    return Row(
      children: [
        Expanded(child: _buildAboutText()),
        const SizedBox(width: 50),
        _buildProfileImage(),
      ],
    );
  }

  Widget _buildProfileImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        'assets/images/profile_picture.png', // Caminho da sua foto
        height: 300,
        width: 300,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildAboutText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sou Gabriel Morais Marcondes, desenvolvedor Full Stack com foco em Flutter e soluções mobile de alto impacto. Tenho mais de 4 anos de experiência projetando e entregando aplicações cross-platform, modernizando sistemas legados e resolvendo problemas reais com software confiável.",
          style: GoogleFonts.poppins(
            fontSize: 18,
            height: 1.6,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Minha especialidade é transformar requisitos de campo e processos operacionais em aplicativos práticos e escaláveis: delivery de MVPs rápidos (ex.: MVP funcional em 3 semanas), arquiteturas offline-first com SQLite, integração com APIs REST (.NET / PHP) e features em tempo real via WebSocket (chat, rastreamento). Também possuo experiência com geração de documentos server-side e integração com dispositivos (impressoras térmicas).",
          style: GoogleFonts.poppins(
            fontSize: 16,
            height: 1.6,
            color: Colors.white60,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Valorizo código limpo, arquitetura sustentável e entregas orientadas ao produto. Trabalho bem em equipes ágeis, colaboro próximo ao PO e designers (Figma) e busco sempre equilibrar velocidade de entrega com qualidade (testes, manutenção e boas práticas). Gosto de desafios que combinam engenharia e impacto prático para o usuário final.",
          style: GoogleFonts.poppins(
            fontSize: 16,
            height: 1.6,
            color: Colors.white60,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Principais tecnologias: Flutter · Dart · SQLite · Firebase · WebSockets · PHP · .NET (C#) · MySQL · Git · Figma.",
          style: GoogleFonts.poppins(
            fontSize: 15,
            height: 1.6,
            color: Colors.white54,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Se quiser ver exemplos práticos, tenho estudos de caso e demos no meu portfólio — posso compartilhar ou marcar uma conversa rápida para entrar em detalhes sobre um projeto específico.",
          style: GoogleFonts.poppins(
            fontSize: 16,
            height: 1.6,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }
}