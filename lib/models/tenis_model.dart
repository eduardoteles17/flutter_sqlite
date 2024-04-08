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
      brandId: map['brand_id'],
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
