class Personal {
  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String? photoUrl;
  final String? fechaIngreso;
  final String? descripcion;
  final String? instagram;
  final String? facebook;
  final int status;
  final String? banco;
  final String? nroCuenta;
  final String? tipoCuenta;
  final int cargoPersonalId;

  Personal({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.photoUrl,
    this.fechaIngreso,
    this.descripcion,
    this.instagram,
    this.facebook,
    required this.status,
    this.banco,
    this.nroCuenta,
    this.tipoCuenta,
    required this.cargoPersonalId,
  });

  factory Personal.fromJson(Map<String, dynamic> json) {
    return Personal(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Sin nombre',
      email: json['email'],
      phone: json['phone'],
      photoUrl: json['photo_url'],
      fechaIngreso: json['fecha_ingreso'],
      descripcion: json['descripcion'],
      instagram: json['instagram'],
      facebook: json['facebook'],
      status: json['status'] ?? 1,
      banco: json['banco'],
      nroCuenta: json['nro_cuenta'],
      tipoCuenta: json['tipo_cuenta'],
      cargoPersonalId: json['cargo_personal_id'] ?? 0,
    );
  }
}
