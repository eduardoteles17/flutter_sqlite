import 'brand_model.dart';

class Tenis {
  final int id;
  final int userId;
  final int brandId;
  final String name;
  final String color;

  Tenis({
    required this.id,
    required this.userId,
    required this.brandId,
    required this.name,
    required this.color,
  });

  factory Tenis.fromMap(Map<String, dynamic> map) {
    return Tenis(
      id: map['id'],
      userId: map['user_id'],
      brandId: map['marca_id'],
      name: map['name'],
      color: map['color'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'brand_id': brandId,
      'name': name,
      'color': color,
    };
  }
}

class TenisWithBrand extends Tenis {
  final Brand brand;

  TenisWithBrand({
    required super.id,
    required super.userId,
    required super.brandId,
    required super.name,
    required super.color,
    required this.brand,
  });

  factory TenisWithBrand.fromTenis(Tenis tenis, Brand brand) {
    return TenisWithBrand(
      id: tenis.id,
      userId: tenis.userId,
      brandId: tenis.brandId,
      name: tenis.name,
      color: tenis.color,
      brand: brand,
    );
  }

  Tenis toTenis() {
    return Tenis(
      id: id,
      userId: userId,
      brandId: brandId,
      name: name,
      color: color,
    );
  }
}
