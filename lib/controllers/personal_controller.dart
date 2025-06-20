import 'package:flutter/material.dart';
import '../models/personal.dart';
import '../services/personal_api.dart';

class PersonalController extends ChangeNotifier {
  List<Personal> _listaPersonal = [];
  bool _cargando = false;

  List<Personal> get listaPersonal => _listaPersonal;
  bool get cargando => _cargando;

  Future<void> cargarPersonal() async {
    _cargando = true;
    notifyListeners();

    try {
      _listaPersonal = await PersonalApi.obtenerPersonal();
    } catch (e) {
      _listaPersonal = [];
      debugPrint('Error al cargar personal: $e');
    }

    _cargando = false;
    notifyListeners();
  }
}
