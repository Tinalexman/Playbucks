import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playbucks/components/search.dart';

import 'package:playbucks/components/user.dart';
import 'package:playbucks/components/notification.dart';

export 'package:playbucks/components/notification.dart';

const User dummyUser = User(
  fullName: "John Doe",
  username: "johnny",
  email: "johndoe@mail.com",
  cover: "assets/Guy.png",
  balance: 0.25,
  bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
      "Pellentesque feugiat at risus sit amet scelerisque. Curabitur sollicitudin "
      "tincidunt erat, sed vehicula ligula ullamcorper at. In in tortor ipsum. "
      "Nullam et malesuada libero. Curabitur ultricies erat dui, sit amet porttitor "
      "neque finibus sit amet. Integer id massa risus.",
);

final StateProvider<User> currentUserProvider =
    StateProvider((ref) => dummyUser);
final StateProvider<bool> typeProvider = StateProvider((ref) => true);
final StateProvider<bool> autoUpdatesProvider = StateProvider((ref) => false);
final StateProvider<String> versionProvider =
    StateProvider((ref) => "Version 1.1.0");
final StateProvider<List<String>> connectedAccountsProvider =
    StateProvider((ref) => ["Spotify", "Apple Music"]);
final StateProvider<List<User>> followersProvider =
    StateProvider((ref) => List.generate(5, (_) => dummyUser));

final StateProvider<List<NotificationData>> notificationsProvider =
    StateProvider(
  (ref) => List.generate(
    5,
    (_) => const NotificationData(),
  ),
);

final StateProvider<List<SearchTerm>> searchesProvider = StateProvider(
  (ref) => List.generate(
    5,
    (_) => const SearchTerm(),
  ),
);

final StateProvider<List<NotificationPreference>>
    notificationPreferenceProvider = StateProvider(
  (ref) => [
    NotificationPreference(title: "New Releases"),
    NotificationPreference(title: "Promotions"),
    NotificationPreference(title: "Artist Interactions")
  ],
);

void logout(WidgetRef ref) {
  ref.invalidate(notificationPreferenceProvider);
  ref.invalidate(currentUserProvider);
  ref.invalidate(autoUpdatesProvider);
}
