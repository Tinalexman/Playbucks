import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playbucks/components/user.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/utils/constants.dart';

class FollowingsPage extends ConsumerStatefulWidget {
  const FollowingsPage({super.key});

  @override
  ConsumerState<FollowingsPage> createState() => _FollowingsPageState();
}

class _FollowingsPageState extends ConsumerState<FollowingsPage> {
  @override
  Widget build(BuildContext context) {
    List<User> followings = ref.watch(followersProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          iconSize: 26.r,
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => context.router.pop(),
        ),
        centerTitle: true,
        title: Text(
          "Following",
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (_, index) {
                    if (index == followings.length) {
                      return SizedBox(height: 50.h);
                    }

                    return _FollowingContainer(following: followings[index]);
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 20.h),
                  itemCount: followings.length + 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FollowingContainer extends StatelessWidget {
  final User following;

  const _FollowingContainer({
    super.key,
    required this.following,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: theme,
            backgroundImage: AssetImage(following.cover),
          ),
          SizedBox(
            width: 250.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  following.fullName,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      useSafeArea: true,
                      builder: (_) => _UnfollowDialog(
                        artiste: following.fullName,
                      ),
                    );
                  },
                  child: Container(
                    width: 90.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: mainGold),
                      ),
                    alignment: Alignment.center,
                    child: Text(
                      "Unfollow",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: mainGold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _UnfollowDialog extends StatelessWidget {
  final String artiste;

  const _UnfollowDialog({
    super.key,
    required this.artiste,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: 390.w,
          height: 150.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: mainGold),
            color: neutral2,
          ),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Are you sure you want to unfollow $artiste?",
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge!.copyWith(color: mainGold),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Text(
                      "No",
                      style: context.textTheme.bodyLarge!
                          .copyWith(color: mainGold),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  ElevatedButton(
                    onPressed: () => context.router.pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainGold,
                      minimumSize: Size(140.w, 50.h),
                      maximumSize: Size(140.w, 50.h),
                    ),
                    child: Text(
                      "Yes, I'm sure",
                      style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500, color: primary),
                    ),
                  ),
                  SizedBox(height: 10.h)
                ],
              )
            ],
          ),
        ));
  }
}
