import 'package:flutter/material.dart';
import '../models/service.dart';
import '../services/service_api.dart';

class ServiceController with ChangeNotifier {
  List<Service> _servicios = [];
  bool _cargando = false;

  List<Service> get servicios => _servicios;
  bool get cargando => _cargando;

  Future<void> cargarServicios() async {
    _cargando = true;
    notifyListeners();

    _servicios = await ServiceApi.getServicios();

    _cargando = false;
    notifyListeners();
  }

  void limpiar() {
    _servicios = [];
    _cargando = false;
    notifyListeners();
  }
}
