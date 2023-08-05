import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playbucks/components/user.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:playbucks/utils/widgets.dart';
import 'package:playbucks/utils/functions.dart';

class ArtisteDashboard extends ConsumerStatefulWidget {
  const ArtisteDashboard({super.key});

  @override
  ConsumerState<ArtisteDashboard> createState() => _ArtisteDashboardState();
}

class _ArtisteDashboardState extends ConsumerState<ArtisteDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
        title: Text(
          "Dashboard",
          style: context.textTheme.headlineSmall!.copyWith(fontSize: 20.sp),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              SizedBox(
                width: 390.w,
                height: 106.h,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 90.w,
                        height: 106.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: neutral2),
                        child: Text(
                          user.fullName.substring(0, 1),
                          style: context.textTheme.headlineLarge,
                        ),
                      ),
                    ),
                    SizedBox(width: 25.w),
                    SizedBox(
                      width: 200.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            user.fullName,
                            overflow: TextOverflow.fade,
                            style: context.textTheme.headlineLarge,
                          ),
                          Text("@${user.username}",
                              style: context.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              TabBar(
                controller: _tabController,
                indicatorColor: mainGold,
                tabs: const [
                  Tab(
                    child: Text("Summary"),
                  ),
                  Tab(
                    child: Text("Analytics"),
                  ),
                  Tab(
                    child: Text("Account"),
                  ),
                  Tab(
                    child: Text("Profile"),
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25.h,
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25.h,
                          ),
                          Text("Banking Details",
                              style: context.textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w600)),
                          Text(
                              "This information would be used to validate withdrawal",
                              style: context.textTheme.bodyMedium),
                          SizedBox(height: 100.h),
                          Center(
                            child: Text(
                              "You have not yet linked a bank card.",
                              style: context.textTheme.bodyMedium,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mainGold,
                                  elevation: 2.0,
                                  minimumSize: Size(100.w, 35.h)),
                              onPressed: () {},
                              child: Text(
                                "Add New Card",
                                style: context.textTheme.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.w600, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
