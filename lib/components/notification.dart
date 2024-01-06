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

class NotificationData {
  final String content;
  final List<NotificationLink> data;

  const NotificationData({
    this.content = "Check out the latest releases from the newest artistes",
    this.data = const [
      NotificationLink(),
      NotificationLink(),
      NotificationLink(),
    ],
  });
}

class NotificationLink {
  final String artisteName;
  final String song;
  final String link;

  const NotificationLink({
    this.artisteName = "Artiste Name",
    this.song = "Song Title",
    this.link = "",
  });
}


