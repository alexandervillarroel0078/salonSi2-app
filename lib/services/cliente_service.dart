import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cliente_perfil.dart';
import '../config.dart';

class ClienteService {
  final String apiUrl = '${AppConfig.baseUrl}/api/v1';

  Future<ClientePerfil?> obtenerPerfilCliente(int clienteId) async {
    final url = Uri.parse('$apiUrl/cliente/$clienteId/perfil');
    print('Llamando a: $url'); // 🧠 Depuración

    final response = await http.get(url);

    print('Respuesta: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ClientePerfil.fromJson(jsonData);
    } else {
      print('Error al obtener perfil del cliente: ${response.statusCode}');
      return null;
    }
  }
}
