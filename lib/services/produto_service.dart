import 'dart:convert';
import 'package:exotica_app/env.dart';
import 'package:http/http.dart' as http;
import 'package:exotica_app/models/produto_model.dart';

class ProdutoService {
  Future<List<ProdutoModel>> fetchProdutos(String url, Map<String, dynamic> params) async {
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
        return jsonResponse.map((map) => ProdutoModel.fromMap(map)).toList();
      } else {
        throw Exception('Erro na solicitação POST: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na solicitação POST: $e');
    }
  }
}
