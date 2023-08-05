import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playbucks/components/user.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:playbucks/utils/functions.dart';

class ListenerDashboard extends ConsumerStatefulWidget {
  const ListenerDashboard({super.key});

  @override
  ConsumerState<ListenerDashboard> createState() => _ListenerDashboardState();
}

class _ListenerDashboardState extends ConsumerState<ListenerDashboard> {
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
        title: Text(
          "Dashboard",
          style: context.textTheme.headlineSmall!.copyWith(fontSize: 20.sp),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50.h),
                Center(
                  child: CircleAvatar(
                    radius: 60.r,
                    backgroundColor: neutral2,
                    child: user.cover.isEmpty
                        ? Text(
                            user.fullName.substring(0, 1),
                            style: context.textTheme.headlineLarge,
                          )
                        : Icon(
                            Icons.person_rounded,
                            size: 26.r,
                            color: mainGold,
                          ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  user.fullName,
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
                ),
                Text("@${user.username}", style: context.textTheme.bodyMedium),
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  "Analytics For ${formatDateTime(DateTime.now())}",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700, color: offWhite),
                ),
                const Divider(
                  color: neutral,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Amount Earned",
                          style: context.textTheme.bodyMedium,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Container(
                          width: 120.w,
                          height: 60.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: neutral2,
                          ),
                          child: Text(
                            "${currency()} ${formatAmount(user.balance.toStringAsFixed(0))}",
                            style: context.textTheme.headlineSmall,
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Songs Played",
                          style: context.textTheme.bodyMedium,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Container(
                          width: 120.w,
                          height: 60.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: neutral2,
                          ),
                          child: Text(
                            "23",
                            style: context.textTheme.headlineSmall,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  "Account Information",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700, color: offWhite),
                ),
                const Divider(
                  color: neutral,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "You have not yet linked a bank card.",
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 20.h,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mainGold,
                        elevation: 2.0,
                        minimumSize: Size(100.w, 35.h),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Add New Card",
                      style: context.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600, color: Colors.black),
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
