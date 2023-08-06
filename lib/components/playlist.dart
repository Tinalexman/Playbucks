import 'package:playbucks/components/user.dart';

class Song {
  final String id;
  final String link;
  final String name;
  final int duration;

  const Song({
    this.id = "",
    this.link = "",
    required this.name,
    this.duration = 100263,
  });
}

class Album {
  final String name;
  final List<Song> songs;
  final User artiste;

  const Album({
    required this.name,
    required this.artiste,
    required this.songs,
  });
}
