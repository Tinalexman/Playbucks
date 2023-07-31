import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playbucks/utils/constants.dart';

class PlayerControl extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onPlayPause;
  final VoidCallback onNext;
  final bool isPlaying;

  const PlayerControl({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            splashRadius: 25.r,
            iconSize: 25.r,
            onPressed: onPrevious,
            icon: const Icon(Icons.skip_previous_rounded),
          ),
          GestureDetector(
            onTap: onPlayPause,
            child: Container(
              width: 50.w,
              height: 50.w,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Icon(
                isPlaying ? Icons.pause_rounded :
                Icons.play_arrow_rounded,
                size: 32.r,
                color: primary,
              ),
            ),
          ),
          IconButton(
            splashRadius: 25.r,
            iconSize: 25.r,
            onPressed: onNext,
            icon: const Icon(Icons.skip_next_rounded),
          ),
        ],
      ),
    );
  }
}
