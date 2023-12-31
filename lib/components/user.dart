import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String fullName;
  final String username;
  final String cover;
  final String bio;
  final String email;

  final double balance;

  const User({
    this.fullName = "",
    this.email = "",
    this.id = "",
    this.username = "",
    this.bio = "",
    this.balance = 0.0,
    this.cover = "",
  });


  @override
  List<Object?> get props => [id];
}
