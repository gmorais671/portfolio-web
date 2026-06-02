import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_theme.dart';
import '../services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _companyController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isRegistered = false;
  String? _token;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Verifica se o usuário já tem um token salvo
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token != null) {
      setState(() {
        _isRegistered = true;
        _token = token;
      });
    }
  }

  // Função para Registrar e fazer Login automático
  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // 1. Registrar
    final success = await ApiService.registerLead(
      _nameController.text,
      _emailController.text,
      _companyController.text,
      _passwordController.text,
    );

    if (success) {
      // 2. Fazer Login para pegar o token
      final token = await ApiService.login(
        _emailController.text,
        _passwordController.text,
      );

      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        setState(() {
          _isRegistered = true;
          _token = token;
        });
        _showSnackBar("Cadastro realizado com sucesso!", Colors.green);
      }
    } else {
      _showSnackBar("Erro ao cadastrar. E-mail já existe?", Colors.red);
    }

    setState(() => _isLoading = false);
  }

  // Função para solicitar o envio do CV por e-mail
  Future<void> _handleRequestCV() async {
    if (_token == null) return;

    setState(() => _isLoading = true);
    final success = await ApiService.requestCV(_token!);

    if (success) {
      _showSnackBar(
        "E-mail enviado! Verifique sua caixa de entrada.",
        AppColors.primary,
      );
    } else {
      _showSnackBar("Erro ao solicitar e-mail. Tente novamente.", Colors.red);
    }
    setState(() => _isLoading = false);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Column(
        children: [
          Text(
            "VAMOS TRABALHAR JUNTOS?",
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Interessado no meu perfil? Deixe seus dados e receba meu CV por e-mail.",
            style: TextStyle(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _isRegistered ? _buildSuccessState() : _buildRegisterForm(),
          ),
        ],
      ),
    );
  }

  // Estado 1: Formulário de Cadastro
  Widget _buildRegisterForm() {
    return Container(
      key: const ValueKey(1),
      constraints: const BoxConstraints(maxWidth: 500),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextField(_nameController, "Nome Completo", Icons.person),
            const SizedBox(height: 20),
            _buildTextField(_emailController, "E-mail", Icons.email),
            const SizedBox(height: 20),
            _buildTextField(
              _companyController,
              "Empresa (Opcional)",
              Icons.business,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              _passwordController,
              "Crie uma senha",
              Icons.lock,
              isPassword: true,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "CADASTRAR E SOLICITAR CV",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Estado 2: Botão de Enviar CV (Após cadastro/login)
  Widget _buildSuccessState() {
    return Container(
      key: const ValueKey(2),
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green, size: 80),
          const SizedBox(height: 20),
          const Text(
            "Obrigado pelo interesse!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: _isLoading ? null : _handleRequestCV,
            icon: const Icon(Icons.email_outlined, color: Colors.white),
            label: const Text(
              "ENVIAR CURRÍCULO PARA MEU E-MAIL",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            ),
          ),
          TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('auth_token');
              setState(() => _isRegistered = false);
            },
            child: const Text(
              "Usar outro e-mail",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white10),
        ),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? "Campo obrigatório" : null,
    );
  }
}
