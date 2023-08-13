import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:palette_generator/palette_generator.dart';

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
  bool _loadedBackground = false;
  final List<Color> _background = [];

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

    _getBackgroundColors().then((value) {
      if (!mounted) return;
      setState(() {
        _background.addAll(value);
        _loadedBackground = true;
      });
    });
  }

  Future<Iterable<Color>> _getBackgroundColors() async {
    PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
        const AssetImage("assets/google icon.png"));
    return generator.colors;
  }

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      blur: 0.2,
      border: 0.0,
      borderRadius: 0.0,
      linearGradient: LinearGradient(
        colors: _loadedBackground
            ? _background
            : [
                playerMutedLight.withOpacity(0.7),
                playerDominant.withOpacity(0.6),
                playerMutedDark
              ],
        end: Alignment.bottomRight,
        begin: Alignment.topLeft,
      ),
      borderGradient: LinearGradient(
        colors: _loadedBackground
            ? _background
            : [
                mainGold.withOpacity(0.6),
                niceBlue.withOpacity(0.6),
                goodYellow.withOpacity(0.6)
              ],
        end: Alignment.bottomRight,
        begin: Alignment.topLeft,
      ),
      width: 390.w,
      height: 844.h,
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    color: mainGold,
                    height: 220.h,
                    width: 390.w,
                    alignment: Alignment.center,
                    child: Text("Album Image",
                        style: context.textTheme.headlineSmall),
                  ),
                  Positioned(
                    bottom: 15.h,
                    left: 15.w,
                    child: Text(
                      _album.name,
                      style: context.textTheme.headlineLarge,
                    ),
                  )
                ],
              ),
              SizedBox(height: 30.h),
              Text("5,521 monthly listeners",
                  style: context.textTheme.bodyLarge),
              Column(
                children: [
                  Text(_album.artiste.fullName,
                      style: context.textTheme.headlineSmall),
                  Text("12 listeners", style: context.textTheme.bodyMedium)
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
                      onTap: () =>
                          FileManager.single(type: FileType.audio).then((path) {
                        if (path != null) {
                          context.pushNamed(Pages.mediaPlayer,
                              extra: path.path);
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
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.play_arrow_rounded,
            color: Colors.black,
            size: 32.r,
          ),
        ),
      ),
    );
  }
}
