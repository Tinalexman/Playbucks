import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:playbucks/utils/widgets.dart';

enum PlayMode { repeatOne, repeatAll, shuffle }

class MediaPlayerPage extends StatefulWidget {
  final String path;

  const MediaPlayerPage({super.key, required this.path});

  @override
  State<MediaPlayerPage> createState() => _MediaPlayerPageState();
}

class _MediaPlayerPageState extends State<MediaPlayerPage> {
  late FixedExtentScrollController _scrollController;
  late List<String> _lyrics;
  late AudioPlayer _player;

  bool _isLiked = false;
  bool _isPlaying = false;
  bool _initialized = false;
  PlayMode _playMode = PlayMode.repeatAll;
  Duration _currentPosition = Duration.zero, _maxDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _lyrics = [];
    for (int i = 0; i < 11; ++i) {
      _lyrics.add(
          "Lyric Verse ${i + 1} is trying to make this text as long as it can be to test the responsiveness.");
    }

    _scrollController = FixedExtentScrollController();

    _player = AudioPlayer();
    _player.setSourceDeviceFile(widget.path);
    _player.onPositionChanged.listen(
      (event) {
        setState(() => _currentPosition = event);
      },
    );
    _player.onPlayerComplete.listen((event) {
      if (_playMode == PlayMode.repeatOne) {
        _player.seek(Duration.zero);
        setState(() {
          _currentPosition = Duration.zero;
        });
        _player.resume();
      }
    });
    _player.onDurationChanged.listen(
      (event) => setState(() {
        _maxDuration = event;
        _initialized = true;
      }),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  IconData get modeIcon {
    switch (_playMode) {
      case PlayMode.repeatOne:
        return Icons.repeat_one_rounded;
      case PlayMode.repeatAll:
        return Icons.repeat_rounded;
      case PlayMode.shuffle:
        return Icons.shuffle_rounded;
    }
  }

  void togglePlayMode() => setState(
        () {
          if (_playMode == PlayMode.repeatAll) {
            _playMode = PlayMode.repeatOne;
          } else if (_playMode == PlayMode.repeatOne) {
            _playMode = PlayMode.shuffle;
          } else {
            _playMode = PlayMode.repeatAll;
          }
        },
      );

  double get current {
    if (_maxDuration.inMilliseconds == 0) return 0.0;
    return _currentPosition.inMilliseconds / _maxDuration.inMilliseconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 0.01,
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => context.router.pop(),
        ),
        title: Text(
          "Player",
          style: context.textTheme.headlineSmall!.copyWith(fontSize: 20.sp),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 250.w,
                width: 390.w,
                decoration: BoxDecoration(
                  color: appRed,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Song Image",
                  style: context.textTheme.headlineMedium,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Song Title",
                style: context.textTheme.headlineMedium,
              ),
              Text(
                "Song Artiste",
                style: context.textTheme.bodyLarge,
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      togglePlayMode();
                    },
                    icon: Icon(modeIcon),
                    iconSize: 25.r,
                    splashRadius: 25.r,
                  ),
                  PlayerControl(
                    onNext: () {},
                    isPlaying: _isPlaying,
                    onPlayPause: () {
                      if (!_initialized) return;
                      setState(() => _isPlaying = !_isPlaying);
                      if (_isPlaying) {
                        _player.resume();
                      } else {
                        _player.pause();
                      }
                    },
                    onPrevious: () {},
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() => _isLiked = !_isLiked);
                    },
                    icon: Icon(
                      _isLiked
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: _isLiked ? appRed : null,
                    ),
                    iconSize: 25.r,
                    splashRadius: 25.r,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              RepaintBoundary(
                child: LinearProgressIndicator(
                  color: appRed,
                  backgroundColor: neutral2,
                  value: current,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 80.w,
                  controller: _scrollController,
                  physics: const FixedExtentScrollPhysics(),
                  diameterRatio: 2,
                  squeeze: 1,
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (_, index) {
                      if (index < 0 || index > 10) {
                        return null;
                      }
                      return ListTile(
                        title: Text(
                          _lyrics[index],
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodyLarge,
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
