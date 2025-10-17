import 'dart:convert';
import 'package:http/http.dart' as http;

class InstituicaoService {
  final String baseUrl = "http://10.0.2.2:3000/api/instituicoes";

  Future<List<dynamic>> listarInstituicoes() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) return json.decode(res.body);
    throw Exception("Erro ao carregar instituições");
  }

  Future<Map<String, dynamic>> criarInstituicao(String nome, String pais, String cidade) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"nome": nome, "pais": pais, "cidade": cidade}),
    );
    if (res.statusCode == 201) return json.decode(res.body);
    throw Exception("Erro ao criar instituição");
  }

  Future<Map<String, dynamic>> atualizarInstituicao(int id, String nome, String pais, String cidade) async {
    final res = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"nome": nome, "pais": pais, "cidade": cidade}),
    );
    if (res.statusCode == 200) return json.decode(res.body);
    throw Exception("Erro ao atualizar instituição");
  }

  Future<void> deletarInstituicao(int id) async {
    final res = await http.delete(Uri.parse("$baseUrl/$id"));
    if (res.statusCode != 200) throw Exception("Erro ao deletar instituição");
  }
}
