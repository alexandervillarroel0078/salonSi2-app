// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/service.dart';

class ServiceApi {
  static Future<List<Service>> getServicios() async {
    final url = Uri.parse('${AppConfig.baseUrl}/api/v1/servicios');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> serviciosJson = jsonData['services'];

        return serviciosJson.map((json) => Service.fromJson(json)).toList();
      } else {
        print('Error ${response.statusCode}: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error al obtener servicios: $e');
      return [];
    }
  }
}
