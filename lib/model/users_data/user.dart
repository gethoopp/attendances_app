class User {
  final String? id;
  final String? cardNumber;
  final String? firstName;
  final String? lastName;

  const User({
    this.id,
    this.cardNumber,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      cardNumber: json['card_number'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  User copyWith({
    String? id,
    String? cardNumber,
    String? firstName,
    String? lastName,
  }) {
    return User(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}
