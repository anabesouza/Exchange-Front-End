// Em lib/provider/userProvider.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  String? _userMessage;
  String? get userMessage => _userMessage;

  Future<void> loginMaster(String name, String password) async {
    final url = Uri.parse("http://10.0.2.2:3000/users/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _userMessage = data['message'];
      } else {
        _userMessage = 'Login falhou: ${response.body}';
      }
    } catch (e) {
      _userMessage = 'Erro de conexão: $e';
    }

    notifyListeners();
  }
}
