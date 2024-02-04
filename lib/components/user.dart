import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String fullName;
  final String username;
  final String cover;
  final String bio;
  final String email;
  
  final DateTime joined;

  final double balance;

  const User({
    this.fullName = "",
    this.email = "",
    this.id = "",
    this.username = "",
    this.bio = "",
    this.balance = 0.0,
    this.cover = "",
    required this.joined,
  });


  @override
  List<Object?> get props => [id];

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map["_id"],
      email: map["email"],
      fullName: "${map["firstName"]} ${map["lastName"]}",
      joined: DateTime.parse(map["createdAt"])
    );
  }
}
