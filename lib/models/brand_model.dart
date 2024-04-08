class Brand {
  final int id;
  final int userId;
  final String name;

  Brand({
    required this.id,
    required this.userId,
    required this.name,
  });

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      id: map['id'],
      userId: map['user_id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
    };
  }
}
