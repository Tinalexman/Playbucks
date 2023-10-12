import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/components/user.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:playbucks/api/file_manager.dart';
import 'package:playbucks/utils/widgets.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final List<String> _songs = [];

  @override
  Widget build(BuildContext context) {
    User user = ref.watch(currentUserProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () => context.router.pushNamed(
                      ref.watch(typeProvider.notifier).state
                          ? Pages.artisteDashboard
                          : Pages.listenerDashboard),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 18.r,
                            backgroundColor: user.cover.isEmpty ? neutral2 : Colors.transparent,
                            backgroundImage: user.cover.isEmpty ? null : FileImage(File(user.cover)),
                            child: user.cover.isEmpty
                                ? Text(
                                    user.fullName.substring(0, 1),
                                    style: context.textTheme.headlineSmall,
                                  )
                                : null,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello, ${user.username}",
                                style: context.textTheme.bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                "Welcome back",
                                style: context.textTheme.headlineSmall!
                                    .copyWith(
                                        fontSize: 18.sp, color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: ref.watch(typeProvider),
                            activeColor: mainGold,
                            onChanged: (val) =>
                                ref.watch(typeProvider.notifier).state = val!,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications_rounded,
                              color: Colors.white,
                            ),
                            splashRadius: 0.01,
                            iconSize: 22.r,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 100.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => context.router.pushNamed(Pages.playlist),
                            child: Container(
                              width: 120.w,
                              height: 200.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: mainGold,
                                borderRadius: BorderRadius.circular(20.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.redAccent.withOpacity(0.2),
                                    spreadRadius: 2.0,
                                    blurRadius: 0.8,
                                  )
                                ],
                              ),
                              child: Text(
                                "Work Of Art",
                                style: context.textTheme.bodyMedium!
                                    .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Trending right now!",
                                style: context.textTheme.headlineSmall!
                                    .copyWith(color: Colors.white),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              SizedBox(
                                height: 100.h,
                                width: 210.w,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    return GestureDetector(
                                      onTap: () => context.router.pushNamed(
                                          Pages.customArtistePage, extra: user.toJson()
                                      ),
                                      child: Container(
                                        width: 120.w,
                                        height: 100.h,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: mainGold,
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.redAccent
                                                  .withOpacity(0.2),
                                              spreadRadius: 2.0,
                                              blurRadius: 0.8,
                                            )
                                          ],
                                        ),
                                        child: Text(
                                          "Album ${index + 1}",
                                          style: context.textTheme.bodyMedium!
                                              .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (_, __) =>
                                      SizedBox(width: 10.w),
                                  itemCount: 5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Text(
                        "Recently Played",
                        style: context.textTheme.bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 100.h,
                        width: 390.w,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return Container(
                              width: 130.w,
                              height: 100.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: mainGold,
                                borderRadius: BorderRadius.circular(20.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.redAccent.withOpacity(0.2),
                                    spreadRadius: 2.0,
                                    blurRadius: 0.8,
                                  )
                                ],
                              ),
                              child: Text(
                                "Song ${index + 1}",
                                style: context.textTheme.bodyMedium!
                                    .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(width: 10.w),
                          itemCount: 5,
                        ),
                      ),
                      SizedBox(height: 50.h),
                    ],
                  ),
                ),
                SizedBox(height: 50.h),
                const Center(child: Copyright()),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
