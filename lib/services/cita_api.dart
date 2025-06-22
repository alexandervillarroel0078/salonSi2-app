// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/cita.dart';

class CitaApi {
  static final String apiUrl = '${AppConfig.baseUrl}/api/v1';

  static Future<List<Cita>> obtenerCitasCliente(int clienteId) async {
    final url = Uri.parse('$apiUrl/cliente/$clienteId/citas');
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

  static Future<bool> confirmarPago(int citaId) async {
    final url = Uri.parse('$apiUrl/citas/confirmar_pago/$citaId');
    print('📡 Confirmando pago en: $url');

    try {
      final response = await http.post(url);
      print('📥 Respuesta pago: ${response.statusCode}');

      return response.statusCode == 200;
    } catch (e) {
      print('🛑 Error al confirmar pago: $e');
      return false;
    }
  }

  static Future<bool> enviarCalificaciones(
    int citaId,
    Map<int, int> calificaciones,
  ) async {
final url = Uri.parse('$apiUrl/cliente/agendas/$citaId/confirmar');

    // Convertimos calificaciones de {servicioId: estrellas} a una lista aceptable para backend
    final body = {
      'servicio_id[]': calificaciones.keys.map((id) => id.toString()).toList(),
      'calificacion[]': calificaciones.values
          .map((val) => val.toString())
          .toList(),
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          // Si usas token: 'Authorization': 'Bearer $token',
        },
        body: body,
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error enviando calificaciones: $e');
      return false;
    }
  }

}
