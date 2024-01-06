import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playbucks/components/user.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/utils/constants.dart';

class ListenerDashboard extends ConsumerStatefulWidget {
  const ListenerDashboard({super.key});

  @override
  ConsumerState<ListenerDashboard> createState() => _ListenerDashboardState();
}

class _ListenerDashboardState extends ConsumerState<ListenerDashboard> {

  late double reward;

  @override
  void initState() {
    super.initState();
    reward = 0.25;
  }

  @override
  Widget build(BuildContext context) {
    User user = ref.watch(currentUserProvider);

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
          "User Profile",
          style: context.textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: theme,
                      backgroundImage: AssetImage(user.cover),
                    ),
                    SizedBox(
                      width: 200.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi User,",
                            style: context.textTheme.headlineSmall!
                                .copyWith(fontSize: 20.sp),
                          ),
                          Text(
                            user.email,
                            style: context.textTheme.bodyLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.router.pushNamed(Pages.editProfile),
                      child: Image.asset("assets/Edit.png"),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Following: 10",
                      style: context.textTheme.bodyLarge,
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () => context.router.pushNamed(Pages.followings),
                      child: Icon(Icons.chevron_right_rounded,
                          color: mainGold, size: 26.r),
                    )
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rewards: ${reward.toStringAsFixed(2)}PBC",
                      style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 20.sp),
                    ),
                    GestureDetector(
                      onTap: () => context.router.pushNamed(Pages.rewards, extra: reward,),
                      child: Container(
                        width: 90.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: mainGold,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Claim",
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: primary,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 50.h),
                GestureDetector(
                  onTap: () => context.router.pushNamed(Pages.notifications),
                  child: Text(
                    "Notifications",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: mainGold,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () => context.router.pushNamed(Pages.help),
                  child: Text(
                    "Help & Support",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: mainGold,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () => context.router.pushNamed(Pages.faq),
                  child: Text(
                    "FAQs",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: mainGold,
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      logout(ref);
                      context.router.goNamed(Pages.splash);
                    },
                    child: Text(
                      "Logout",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: mainGold,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
