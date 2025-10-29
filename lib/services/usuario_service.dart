import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';

class UsuarioService {
  final String baseUrl = 'http://localhost:4000/api/usuarios'; // ajuste conforme o backend

  Future<List<Usuario>> getUsuarios() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Usuario.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao carregar usuários');
    }
  }

  Future<Usuario> createUsuario(Usuario usuario) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(usuario.toJson()),
    );
    if (response.statusCode == 201) {
      return Usuario.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao criar usuário');
    }
  }

  Future<void> updateUsuario(String matricula, Usuario usuario) async {
    await http.put(
      Uri.parse('$baseUrl/$matricula'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(usuario.toJson()),
    );
  }

  Future<void> deleteUsuario(String matricula) async {
    await http.delete(Uri.parse('$baseUrl/$matricula'));
  }
}
