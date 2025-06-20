//model/service.dart
class Service {
  final int id;
  final String name;
  final String description;
  final String category;
  final String imagePath;
  final double price;
  final double discountPrice;
  final int durationMinutes;
  final bool hasDiscount;
  final bool hasAvailable;
  final String tipoAtencion;
  final List<Personal> personalList;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imagePath,
    required this.price,
    required this.discountPrice,
    required this.durationMinutes,
    required this.hasDiscount,
    required this.hasAvailable,
    required this.tipoAtencion,
    required this.personalList,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      imagePath: json['image_path'],
      price: (json['price'] as num).toDouble(),
      discountPrice: (json['discount_price'] as num).toDouble(),
      durationMinutes: json['duration_minutes'],
      hasDiscount: json['has_discount'] == 1,
      hasAvailable: json['has_available'] == 1,
      tipoAtencion: json['tipo_atencion'],
      personalList: (json['personal'] as List)
          .map((p) => Personal.fromJson(p))
          .toList(),
    );
  }
}

class Personal {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String photoUrl;
  final String descripcion;

  Personal({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photoUrl,
    required this.descripcion,
  });

  factory Personal.fromJson(Map<String, dynamic> json) {
    return Personal(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      photoUrl: json['photo_url'],
      descripcion: json['descripcion'],
    );
  }
}
