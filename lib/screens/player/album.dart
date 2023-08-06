import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:playbucks/api/file_manager.dart';

import 'package:playbucks/components/playlist.dart';
import 'package:playbucks/components/user.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:playbucks/utils/widgets.dart';
import 'package:playbucks/utils/functions.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late Album _album;

  @override
  void initState() {
    super.initState();
    _album = Album(
      name: "Work of Art",
      artiste: User.fromJson(userData),
      songs: const [
        Song(name: "Lonely At The Top"),
        Song(name: "Remember"),
        Song(name: "Terminator"),
        Song(name: "Yoga Yoga"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 0.1,
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => context.router.pop(),
        ),
        title: Text(
          "Album",
          style: context.textTheme.headlineSmall!.copyWith(fontSize: 20.sp),
        ),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: mainGold,
            height: 250.h,
            width: 390.w,
            alignment: Alignment.center,
            child: Text("Album Image", style: context.textTheme.headlineSmall),
          ),
          SizedBox(height: 50.h),
          Column(
            children: [
              Text(
                _album.name,
                style: context.textTheme.headlineSmall,
              ),
              Text(_album.artiste.fullName,
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600)),
              Text("${_album.songs.length} songs",
                  style: context.textTheme.bodyMedium)
            ],
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: ListView.builder(
              itemCount: _album.songs.length + 1,
              itemBuilder: (_, index) {
                if (index == _album.songs.length) {
                  return Column(
                    children: [
                      SizedBox(height: 50.h),
                      const Center(child: Copyright()),
                      SizedBox(height: 50.h),
                    ],
                  );
                }
                return ListTile(
                  selectedColor: neutral2,
                  onTap: () => FileManager.single(type: FileType.audio).then((path) {
                  if (path != null) {
                    context.pushNamed(Pages.mediaPlayer, extra: path.path);
                  }
                }),
                  leading: SizedBox(
                    height: 40.h,
                    width: 25.w,
                    child: Center(
                      child: Text(
                        "${index + 1}.",
                        style: context.textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  subtitle: Text(
                    "@${_album.artiste.username}",
                    style: context.textTheme.bodyMedium,
                  ),
                  title: Text(
                    _album.songs[index].name,
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  trailing: Text(
                    formatTime(_album.songs[index].duration),
                    style: context.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
