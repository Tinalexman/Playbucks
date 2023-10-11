import 'package:audio_waveforms_fix/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:playbucks/utils/widgets.dart';
import 'package:playbucks/utils/functions.dart';

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
  late PlayerController _playerController;

  bool _isLiked = false;
  bool _isPlaying = false;
  bool _initialized = false;
  PlayMode _playMode = PlayMode.repeatAll;

  int _totalDuration = 0, _currentPosition = 0;

  @override
  void initState() {
    super.initState();
    _lyrics = [];
    for (int i = 0; i < 11; ++i) {
      _lyrics.add(
          "Lyric Verse ${i + 1} is trying to make this text as long as it can be to test the responsiveness.");
    }

    _scrollController = FixedExtentScrollController();
    _playerController = PlayerController();

    _playerController.preparePlayer(widget.path, 1.0).then((_) async {
      _totalDuration = await _playerController.getDuration(DurationType.max);
      _playerController.onCurrentDurationChanged
          .listen((event) {
            if(!mounted) return;
            setState(() => _currentPosition = event);
      });
      setState(() => _initialized = true);
    });
  }

  @override
  void dispose() {
    _playerController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 0.01,
          icon: const Icon(Icons.chevron_left_rounded, color: Colors.white),
          onPressed: () => context.router.pop(),
        ),
        centerTitle: true,
        title: Text(
          "PLAYER",
          style: context.textTheme.headlineSmall!.copyWith(fontSize: 16.sp, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.list_rounded, color: Colors.white),
            iconSize: 26.r,
            splashRadius: 20.r,
          )
        ],
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
                  color: mainGold,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Song Image",
                  style: context.textTheme.headlineMedium!.copyWith(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Song Title",
                style: context.textTheme.headlineMedium!.copyWith(color: Colors.white),
              ),
              Text(
                "Song Artiste",
                style: context.textTheme.bodyLarge!.copyWith(color: Colors.white),
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
                    icon: Icon(modeIcon, color: Colors.white),
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
                        _playerController.startPlayer(
                          finishMode: _playMode == PlayMode.repeatOne
                              ? FinishMode.loop
                              : FinishMode.pause,
                        );
                      } else {
                        _playerController.pausePlayer();
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
                      color: _isLiked ? mainGold : Colors.white,
                    ),
                    iconSize: 25.r,
                    splashRadius: 25.r,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              _initialized
                  ? RepaintBoundary(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              formatTime(_currentPosition),
                              style: context.textTheme.bodySmall!
                                  .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                            AudioFileWaveforms(
                              playerController: _playerController,
                              size: Size(240.w, 60.h),
                              enableSeekGesture: true,
                              density: 1.2,
                              backgroundColor: Colors.transparent,
                              playerWaveStyle: const PlayerWaveStyle(
                                liveWaveColor: mainGold,
                                fixedWaveColor: neutral2,
                                visualizerHeight: 15.0,
                              ),
                            ),
                            Text(
                              formatTime(_totalDuration),
                              style: context.textTheme.bodySmall!
                                  .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ]),
                    )
                  : Text(
                      "Creating Waveform",
                      style: context.textTheme.bodyMedium,
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
                          style: context.textTheme.bodyLarge!.copyWith(color: Colors.white),
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
