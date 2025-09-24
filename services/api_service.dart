import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://10.0.2.2:3000/api"; // Emulador Android
  // Se for no dispositivo físico, use o IP da máquina na mesma rede, ex: "http://192.168.1.10:3000/api"

  Future<String> getHello() async {
    final response = await http.get(Uri.parse("$baseUrl/hello"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data["message"];
    } else {
      throw Exception("Erro ao conectar: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> login(String email, String senha) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"email": email, "senha": senha}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Login falhou: ${response.body}");
    }
  }
}
