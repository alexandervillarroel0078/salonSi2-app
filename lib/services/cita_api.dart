import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cita.dart';
import '../config.dart';

class CitaApi {
  static Future<List<Cita>> obtenerCitasCliente(int clienteId) async {
    final url = Uri.parse(
      '${AppConfig.baseUrl}/api/v1/cliente/$clienteId/citas',
    );

    print('📤 Consultando citas para cliente ID: $clienteId');
    print('📡 URL: $url');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('✅ Citas recibidas: ${data.length}');
        return data.map((json) => Cita.fromJson(json)).toList();
      } else {
        print('❌ Error HTTP: ${response.statusCode}');
        throw Exception('Error al cargar las citas');
      }
    } catch (e) {
      print('🛑 Excepción: $e');
      throw Exception('Error: $e');
    }
  }
}
