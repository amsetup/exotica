import 'dart:convert';
import 'package:exotica_app/env.dart';
import 'package:http/http.dart' as http;
import 'package:exotica_app/models/usuario_model.dart';

class UsuarioService {
  Future<List<UsuarioModel>> fetchUsuario(String url, Map<String, dynamic> params) async {
    try {
      final response = await http.post(
        Uri.parse("${EnvConfig.urlConfig()}$url"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(params),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((map) => UsuarioModel.fromMap(map)).toList();
      } else {
        throw Exception('Erro na solicitação POST: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na solicitação POST: $e');
    }
  }
}
