import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:playbucks/components/user.dart';

const User dummyUser = User(
    fullName: "John Doe",
    username: "johnny",
    balance: 100,
    bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
        "Pellentesque feugiat at risus sit amet scelerisque. Curabitur sollicitudin "
        "tincidunt erat, sed vehicula ligula ullamcorper at. In in tortor ipsum. "
        "Nullam et malesuada libero. Curabitur ultricies erat dui, sit amet porttitor "
        "neque finibus sit amet. Integer id massa risus.");

class NotificationPreference {
  final String title;
  bool chosen;
  String content;

  NotificationPreference({
    required this.title,
    this.chosen = false,
    this.content = "Off",
  });
}




final StateProvider<User> currentUserProvider = StateProvider((ref) => dummyUser);
final StateProvider<bool> typeProvider = StateProvider((ref) => true);
final StateProvider<bool> autoUpdatesProvider = StateProvider((ref) => false);
final StateProvider<String> versionProvider = StateProvider((ref) => "Version 1.1.0");
final StateProvider<List<String>> connectedAccountsProvider = StateProvider((ref) => ["Spotify", "Apple Music"]);




final StateProvider<List<NotificationPreference>> notificationPreferenceProvider =
    StateProvider(
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
