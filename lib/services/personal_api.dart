import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/personal.dart';

class PersonalApi {
  static Future<List<Personal>> obtenerPersonal() async {
    final url = Uri.parse('${AppConfig.baseUrl}/api/v1/personal');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> personalJson = data['personal'];

      return personalJson.map((json) => Personal.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar el personal');
    }
  }
}
