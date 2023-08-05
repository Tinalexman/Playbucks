class User {
  final String fullName;
  final String username;
  final String cover;

  final double balance;


  const User({
    required this.fullName,
    required this.username,
    this.balance = 0.0,
    this.cover = "",
  });
}

