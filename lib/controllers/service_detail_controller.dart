import 'package:flutter/material.dart';
import '../models/service_detail.dart';
import '../services/service_detail_api.dart';

class ServiceDetailController with ChangeNotifier {
  ServiceDetail? detalle;
  bool cargando = false;

  Future<void> cargarDetalle(int serviceId) async {
    cargando = true;
    notifyListeners();

    detalle = await ServiceDetailApi.getPersonalPorServicio(serviceId);

    cargando = false;
    notifyListeners();
  }
}
