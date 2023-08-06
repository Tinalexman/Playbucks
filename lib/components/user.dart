import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String fullName;
  final String username;
  final String cover;
  final String bio;

  final double balance;

  const User({
    required this.fullName,
    this.id = "",
    this.username = "",
    this.bio = "",
    this.balance = 0.0,
    this.cover = "",
  });

  User.fromJson(Map<String, dynamic> map)
      : id = map["id"],
        fullName = map["fullName"],
        username = map["username"],
        cover = map["cover"],
        bio = map["bio"],
        balance = (map["balance"] as num).toDouble();

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "username": username,
        "cover": cover,
        "bio": bio,
        "balance": balance,
      };

  @override
  List<Object?> get props => [id];
}
