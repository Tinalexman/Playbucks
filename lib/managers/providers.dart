import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:playbucks/components/user.dart';

final StateProvider<User> currentUserProvider = StateProvider(
  (ref) => const User(
    fullName: "John Doe",
    username: "johnny",
    balance: 1200
  ),
);


final StateProvider<bool> typeProvider = StateProvider((ref) => true);