class ClientePerfil {
  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String? photoUrl;
  final bool status;

  ClientePerfil({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.photoUrl,
    required this.status,
  });

  factory ClientePerfil.fromJson(Map<String, dynamic> json) {
    return ClientePerfil(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      photoUrl: json['photo_url'],
      status: json['status'] == 1 || json['status'] == true,
    );
  }
}
