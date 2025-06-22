import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart'; 

class CalificacionApi {
  static Future<bool> enviarCalificacion(
    int agendaId,
    Map<int, int> valoraciones,
    Map<int, String> comentarios,
  ) async {
    final url = Uri.parse(
      '${AppConfig.baseUrl}/cliente/agenda/confirmar/guardar/$agendaId',
    );
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'valoraciones': valoraciones,
        'comentarios': comentarios,
      }),
    );

    return response.statusCode == 200;
  }
}
