class User {
  final int id;
  final String name;
  final String email;
  final String passwordHash;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.passwordHash,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      passwordHash: map['passwordHash'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'passwordHash': passwordHash,
    };
  }
}
