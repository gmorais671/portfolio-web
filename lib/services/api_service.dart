import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  // Registrar Lead
  static Future<bool> registerLead(
    String name,
    String email,
    String company,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'company': company,
          'password': password,
        }),
      );
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  // Solicitar CV
  static Future<bool> requestCV(String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/send-cv'),
        headers: {'Authorization': 'Bearer $token'},
      );
      return response.statusCode == 202;
    } catch (e) {
      return false;
    }
  }

  // Adicione dentro da classe ApiService
  static Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/token'),
        body: {'username': email, 'password': password},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['access_token'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
