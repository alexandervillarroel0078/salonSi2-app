class ServicioCita {
  final int id;
  final String nombre;
  final int duracion;
  final double precio;
  final String imagen;
  final int cantidad;
  final String? comisionPorcentaje;
  final PersonalCita personal;

  ServicioCita({
    required this.id,
    required this.nombre,
    required this.duracion,
    required this.precio,
    required this.imagen,
    required this.cantidad,
    this.comisionPorcentaje,
    required this.personal,
  });

  factory ServicioCita.fromJson(Map<String, dynamic> json) {
    return ServicioCita(
      id: json['id'],
      nombre: json['nombre'],
      duracion: json['duracion'],
      precio: (json['precio'] as num).toDouble(),
      imagen: json['imagen'],
      cantidad: json['cantidad'],
      comisionPorcentaje: json['comision_porcentaje'],
      personal: PersonalCita.fromJson(json['personal']),
    );
  }
}

class PersonalCita {
  final int id;
  final String nombre;
  final String foto;

  PersonalCita({required this.id, required this.nombre, required this.foto});

  factory PersonalCita.fromJson(Map<String, dynamic> json) {
    return PersonalCita(
      id: json['id'],
      nombre: json['nombre'],
      foto: json['foto'],
    );
  }
}

class Cita {
  final int id;
  final String codigo;
  final String fecha;
  final String hora;
  final String estado;
  final String tipoAtencion;
  final String? ubicacion;
  final int duracion;
  final double precioTotal;
  final String? notas;
  final bool pagado;
  final String? metodoPago;
  final List<ServicioCita> servicios;

  Cita({
    required this.id,
    required this.codigo,
    required this.fecha,
    required this.hora,
    required this.estado,
    required this.tipoAtencion,
    this.ubicacion,
    required this.duracion,
    required this.precioTotal,
    this.notas,
    required this.pagado,
    this.metodoPago,
    required this.servicios,
  });

  factory Cita.fromJson(Map<String, dynamic> json) {
    return Cita(
      id: json['id'],
      codigo: json['codigo'],
      fecha: json['fecha'],
      hora: json['hora'],
      estado: json['estado'],
      tipoAtencion: json['tipo_atencion'],
      ubicacion: json['ubicacion'],
      duracion: json['duracion'],
      precioTotal: double.parse(json['precio_total']),
      notas: json['notas'],
      pagado: json['pagado'],
      metodoPago: json['metodo_pago'],
      servicios: (json['servicios'] as List)
          .map((s) => ServicioCita.fromJson(s))
          .toList(),
    );
  }
}
