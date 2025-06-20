import 'package:flutter/material.dart';
import '../models/cita.dart';
import '../services/cita_api.dart';

class CitaController with ChangeNotifier {
  List<Cita> _citas = [];
  bool _cargando = false;

  List<Cita> get citas => _citas;
  bool get cargando => _cargando;

  Future<void> cargarCitas(int clienteId) async {
    _cargando = true;
    notifyListeners();

    try {
      _citas = await CitaApi.obtenerCitasCliente(clienteId);
    } catch (e) {
      print('Error al cargar citas: $e');
      _citas = [];
    }

    _cargando = false;
    notifyListeners();
  }
}
