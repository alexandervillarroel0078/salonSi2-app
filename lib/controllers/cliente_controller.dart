import 'package:flutter/material.dart';
import '../models/cliente_perfil.dart';
import '../services/cliente_service.dart';

class ClienteController with ChangeNotifier {
  ClientePerfil? _perfil;
  bool _cargando = false;

  final ClienteService _clienteService = ClienteService();

  ClientePerfil? get perfil => _perfil;
  bool get cargando => _cargando;

  Future<void> cargarPerfil(int clienteId) async {
    _cargando = true;
    notifyListeners();

    final perfilObtenido = await _clienteService.obtenerPerfilCliente(
      clienteId,
    );
    _perfil = perfilObtenido;

    _cargando = false;
    notifyListeners();
  }
}
