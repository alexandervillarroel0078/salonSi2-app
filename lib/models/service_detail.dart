import 'personal.dart';

class ServiceDetail {
  final int servicioId;
  final String servicioNombre;
  final String servicioImagen;
  final List<Personal> personalCalificado;

  ServiceDetail({
    required this.servicioId,
    required this.servicioNombre,
    required this.servicioImagen,
    required this.personalCalificado,
  });

  factory ServiceDetail.fromJson(Map<String, dynamic> json) {
    return ServiceDetail(
      servicioId: json['servicio_id'] ?? 0,
      servicioNombre: json['servicio_nombre'] ?? 'Sin nombre',
      servicioImagen: json['servicio_imagen'] ?? '',
      personalCalificado: (json['personal_calificado'] as List? ?? [])
          .map((p) => Personal.fromJson(p))
          .toList(),
    );
  }
}
