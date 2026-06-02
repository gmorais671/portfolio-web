import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/app_theme.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
      color: const Color(0xFF121212),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "PROJETOS SELECIONADOS",
            style: TextStyle(
              letterSpacing: 2,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Alguns projetos que mostram minha experiência com Flutter, backend, offline-first, tempo real e automação.",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 900;
              final crossAxisCount = isWide ? 2 : 1;
              final childAspectRatio = isWide ? 1.35 : 1.0;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _projects.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 30,
                ),
                itemBuilder: (context, index) {
                  final project = _projects[index];
                  return ProjectCard(project: project);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final ProjectData project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  void _openModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => ProjectDetailsModal(project: project),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openModal(context),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (project.imagePath.isNotEmpty)
                Image.asset(
                  project.imagePath,
                  fit: BoxFit.cover,
                )
              else
                Container(color: const Color(0xFF1B1B1B)),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.15),
                      Colors.black.withOpacity(0.65),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      project.title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project.tech,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      project.shortDescription,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.5,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: const [
                        Text(
                          "Clique para detalhes",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectDetailsModal extends StatelessWidget {
  final ProjectData project;

  const ProjectDetailsModal({
    super.key,
    required this.project,
  });

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      backgroundColor: Colors.transparent,
      child: Container(
        width: 820,
        constraints: const BoxConstraints(maxHeight: 760),
        decoration: BoxDecoration(
          color: const Color(0xFF181818),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white10),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      project.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white70),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (project.imagePath.isNotEmpty) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          project.imagePath,
                          height: 260,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                    Text(
                      project.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Entregáveis",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...project.deliverables.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "• ",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Tecnologias e habilidades",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: project.skills
                          .map(
                            (skill) => Chip(
                              label: Text(skill),
                              backgroundColor: Colors.white10,
                              labelStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                              side: BorderSide.none,
                            ),
                          )
                          .toList(),
                    ),
                    if (project.linkedinPosts.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      const Text(
                        "Posts relacionados no LinkedIn",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...project.linkedinPosts.map(
                        (post) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: TextButton(
                            onPressed: () => _launchUrl(post.url),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.centerLeft,
                            ),
                            child: Text(
                              post.title,
                              style: const TextStyle(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white10),
                ),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                  ),
                  child: const Text("Fechar"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectData {
  final String title;
  final String tech;
  final String imagePath;
  final String shortDescription;
  final String description;
  final List<String> deliverables;
  final List<String> skills;
  final List<ProjectLink> linkedinPosts;

  const ProjectData({
    required this.title,
    required this.tech,
    required this.imagePath,
    required this.shortDescription,
    required this.description,
    required this.deliverables,
    required this.skills,
    required this.linkedinPosts,
  });
}

class ProjectLink {
  final String title;
  final String url;

  const ProjectLink({
    required this.title,
    required this.url,
  });
}

const List<ProjectData> _projects = [
  ProjectData(
    title: "App de Coleta Socioeconômica",
    tech: "Flutter · SQLite · Excel",
    imagePath: "assets/images/socioeconomic_cover.jpeg",
    shortDescription:
        "Aplicativo offline-first para digitalização de pesquisas de campo, substituindo formulários em papel por um fluxo rápido, confiável e pronto para exportação.",
    description:
        "Desenvolvi um aplicativo móvel de alta performance para digitalizar e organizar pesquisas socioeconômicas de campo, substituindo processos em papel por um fluxo offline-first com foco em usabilidade para pesquisadores e robustez em ambientes com conectividade limitada.",
    deliverables: [
      "Engine de formulários dinâmicos para questionários multi-etapa com validação em tempo real.",
      "Arquitetura offline-first com persistência local em SQLite, garantindo continuidade do trabalho mesmo sem internet.",
      "Exportação consolidada para Excel (.xlsx) diretamente no dispositivo, facilitando análise e integração com planilhas.",
      "Fluxo de uso simples e intuitivo para pesquisadores e operadores não técnicos.",
    ],
    skills: [
      "Flutter",
      "Dart",
      "SQLite",
      "Excel",
      "Offline-first",
      "UX para campo",
    ],
    linkedinPosts: [],
  ),
  ProjectData(
    title: "App de Inventário e Entregas",
    tech: "Flutter · Firestore · Bluetooth",
    imagePath: "assets/images/vm_tabacos.jpeg",
    shortDescription:
        "Solução para controle de estoque e entregas com impressão térmica via Bluetooth e sincronização com Firestore.",
    description:
        "Criei uma aplicação Flutter para um distribuidor local, com foco em controle de estoque, fluxo de entregas e geração de comprovantes impressos em impressora térmica. O app operou em produção por anos e foi pensado para uso simples no dia a dia operacional.",
    deliverables: [
      "Módulo de controle de inventário e acompanhamento de fluxo de vendas e entregas.",
      "Integração via Bluetooth com impressora térmica para emissão de comprovantes e assinaturas.",
      "Sincronização com Firestore para persistência e atualização de dados.",
      "Interface leve e objetiva, feita para operações rápidas em ambiente comercial.",
    ],
    skills: [
      "Flutter",
      "Dart",
      "Firestore",
      "Bluetooth",
      "Impressão térmica",
      "Gestão operacional",
    ],
    linkedinPosts: [],
  ),
  ProjectData(
    title: "Olá Cliente",
    tech: "Flutter · WebSocket · go_router",
    imagePath: "assets/images/figma_ola.jpg",
    shortDescription:
        "Primeiro app full Flutter da empresa, com rastreamento em tempo real, chat e navegação estruturada para manutenção escalável.",
    description:
        "Liderei o desenvolvimento do primeiro produto totalmente em Flutter da Sinapse Informática, transformando uma ideia inicial em um aplicativo funcional com rastreamento de técnicos em tempo real, chat e integração com sistemas backend existentes.",
    deliverables: [
      "Implementação de rastreamento geolocalizado em tempo real com WebSocket.",
      "Chat interno em tempo real usando a infraestrutura da empresa.",
      "Arquitetura de navegação com go_router, incluindo rotas aninhadas, parâmetros e fluxos de acesso.",
      "Integração com backend ASP.NET e manutenção de endpoints para novas funcionalidades.",
    ],
    skills: [
      "Flutter",
      "Dart",
      "WebSocket",
      "go_router",
      "Provider",
      "GetIt",
      "ASP.NET",
    ],
    linkedinPosts: [],
  ),
  ProjectData(
    title: "TCC — Controle por Lógica Fuzzy",
    tech: "C · PLC · Automação",
    imagePath: "assets/images/fuzzy_controller.jpeg",
    shortDescription:
        "Sistema embarcado para controle de reservatório em tempo real, usando lógica fuzzy para obter resposta mais estável e suave.",
    description:
        "Projeto de conclusão de curso voltado ao controle de nível de um reservatório de água. Implementei um controlador por lógica fuzzy na plataforma B&R PLC, buscando uma resposta mais suave e estável do que abordagens tradicionais com PID em cenários discretos.",
    deliverables: [
      "Implementação do controlador fuzzy em C na plataforma B&R PLC.",
      "Interface HMI para supervisão e testes do sistema.",
      "Estudo comparativo entre lógica fuzzy e PID para avaliar estabilidade e suavidade de controle.",
      "Aplicação de conceitos de controle e automação em um ambiente embarcado real.",
    ],
    skills: [
      "Lógica fuzzy",
      "C",
      "PLC",
      "Automação",
      "HMI",
      "Controle de processos",
    ],
    linkedinPosts: [],
  ),
];