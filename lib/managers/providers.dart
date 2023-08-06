import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:playbucks/components/user.dart';

final StateProvider<User> currentUserProvider = StateProvider(
  (ref) => const User(
    fullName: "John Doe",
    username: "johnny",
    balance: 100,
    bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
        "Pellentesque feugiat at risus sit amet scelerisque. Curabitur sollicitudin "
        "tincidunt erat, sed vehicula ligula ullamcorper at. In in tortor ipsum. "
        "Nullam et malesuada libero. Curabitur ultricies erat dui, sit amet porttitor "
        "neque finibus sit amet. Integer id massa risus."
  ),
);


final StateProvider<bool> typeProvider = StateProvider((ref) => true);