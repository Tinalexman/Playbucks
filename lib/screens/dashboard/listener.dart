import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playbucks/components/user.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:playbucks/utils/functions.dart';
import 'package:playbucks/utils/widgets.dart';

class ListenerDashboard extends ConsumerStatefulWidget {
  const ListenerDashboard({super.key});

  @override
  ConsumerState<ListenerDashboard> createState() => _ListenerDashboardState();
}

class _ListenerDashboardState extends ConsumerState<ListenerDashboard>
    with TickerProviderStateMixin {
  late AnimationController _analyticController,
      _accountController,
      _dspController,
      _preferenceController;
  late Animation<double> _analyticAnimation,
      _accountAnimation,
      _dspAnimation,
      _preferenceAnimation;

  late List<Holder> _specificDSP, _notificationPreference;

  bool _expandedAnalytics = false,
      _expandedAccount = false,
      _expandedDSP = false,
      _expandedPreference = false;

  int _specificDSPIndex = 0, _notificationIndex = 0;

  @override
  void initState() {
    super.initState();

    _analyticController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _analyticAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _analyticController,
        curve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    _accountController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _accountAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _accountController,
        curve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    _dspController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _dspAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _dspController,
        curve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    _preferenceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _preferenceAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _preferenceController,
        curve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    _specificDSP = [
      Holder(content: "Spotify"),
      Holder(content: "Apple Music"),
      Holder(content: "Audiomack")
    ];

    _notificationPreference = [
      Holder(content: "Never"),
      Holder(content: "Sometimes"),
      Holder(content: "Often"),
      Holder(content: "Always"),
    ];
  }

  @override
  void dispose() {
    _preferenceController.dispose();
    _dspController.dispose();
    _accountController.dispose();
    _analyticController.dispose();
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
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: IconButton(
                onPressed: () => context.router.goNamed(Pages.login),
                icon: const Icon(Icons.power_settings_new_rounded),
                iconSize: 26.r,
                splashRadius: 20.r,
              ),
          )
        ],
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
                    backgroundColor: user.cover.isEmpty ? neutral2 : Colors.transparent,
                    backgroundImage: user.cover.isEmpty ? null : FileImage(File(user.cover)),
                    child: user.cover.isEmpty
                        ? Text(
                            user.fullName.substring(0, 1),
                            style: context.textTheme.headlineLarge,
                          )
                        : null,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  user.fullName,
                  style: context.textTheme.headlineSmall,
                ),
                SizedBox(
                  height: 50.h,
                ),
                SizedBox(
                  width: 390.w,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Analytics For ${formatDateTime(DateTime.now())}",
                            style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w700, color: offWhite),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() =>
                                  _expandedAnalytics = !_expandedAnalytics);
                              if (_expandedAnalytics) {
                                _analyticController.forward();
                              } else {
                                _analyticController.reverse();
                              }
                            },
                            icon: Icon(
                              !_expandedAnalytics
                                  ? Icons.arrow_downward_rounded
                                  : Icons.arrow_upward_rounded,
                            ),
                            iconSize: 26.r,
                            splashRadius: 20.r,
                          )
                        ],
                      ),
                      SizeTransition(
                        sizeFactor: _analyticAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            Wrap(spacing: 10.0, children: [
                              Text(
                                "Amount Earned:",
                                style: context.textTheme.bodyMedium,
                              ),
                              Text(
                                "${currency()} ${formatAmount(user.balance.toStringAsFixed(0))}",
                                style: context.textTheme.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ]),
                            SizedBox(height: 10.h),
                            Wrap(spacing: 10.0, children: [
                              Text(
                                "Songs Played:",
                                style: context.textTheme.bodyMedium,
                              ),
                              Text(
                                "24",
                                style: context.textTheme.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 390.w,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Account Information",
                            style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w700, color: offWhite),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(
                                  () => _expandedAccount = !_expandedAccount);
                              if (_expandedAccount) {
                                _accountController.forward();
                              } else {
                                _accountController.reverse();
                              }
                            },
                            icon: Icon(
                              !_expandedAccount
                                  ? Icons.arrow_downward_rounded
                                  : Icons.arrow_upward_rounded,
                            ),
                            iconSize: 26.r,
                            splashRadius: 20.r,
                          )
                        ],
                      ),
                      SizeTransition(
                        sizeFactor: _accountAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            Text(
                              "You have not yet linked a bank card.",
                              style: context.textTheme.bodyMedium,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainGold,
                                  elevation: 2.0,
                                  minimumSize: Size(100.w, 35.h),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Add New Card",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 390.w,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Digital Streaming Platform",
                            style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w700, color: offWhite),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() => _expandedDSP = !_expandedDSP);
                              if (_expandedDSP) {
                                _dspController.forward();
                              } else {
                                _dspController.reverse();
                              }
                            },
                            icon: Icon(
                              !_expandedDSP
                                  ? Icons.arrow_downward_rounded
                                  : Icons.arrow_upward_rounded,
                            ),
                            iconSize: 26.r,
                            splashRadius: 20.r,
                          )
                        ],
                      ),
                      SizeTransition(
                        sizeFactor: _dspAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),
                            Text(
                              "Which DSP do you want to receive streams and promotional content from?",
                              style: context.textTheme.bodyMedium,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Wrap(
                              spacing: 5.0,
                              children: List.generate(
                                _specificDSP.length,
                                    (index) => GestureDetector(
                                  onTap: () =>
                                      setState(() => _specificDSPIndex = index),
                                  child: Chip(
                                    label: Text(
                                      _specificDSP[index].content,
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: _specificDSPIndex != index
                                              ? null
                                              : Colors.black),
                                    ),
                                    elevation: 1,
                                    backgroundColor: _specificDSPIndex != index
                                        ? neutral2
                                        : mainGold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 390.w,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Music and Notification Preferences",
                            style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w700, color: offWhite),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() =>
                                  _expandedPreference = !_expandedPreference);
                              if (_expandedPreference) {
                                _preferenceController.forward();
                              } else {
                                _preferenceController.reverse();
                              }
                            },
                            icon: Icon(
                              !_expandedPreference
                                  ? Icons.arrow_downward_rounded
                                  : Icons.arrow_upward_rounded,
                            ),
                            iconSize: 26.r,
                            splashRadius: 20.r,
                          )
                        ],
                      ),
                      SizeTransition(
                        sizeFactor: _preferenceAnimation,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20.h),
                              Text(
                                "How often do you want to get updates on new songs?",
                                style: context.textTheme.bodyMedium,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Wrap(
                                spacing: 5.0,
                                children: List.generate(
                                  _notificationPreference.length,
                                      (index) => GestureDetector(
                                    onTap: () =>
                                        setState(() => _notificationIndex = index),
                                    child: Chip(
                                      label: Text(
                                        _notificationPreference[index].content,
                                        style: context.textTheme.bodyMedium!
                                            .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: _notificationIndex != index
                                                ? null
                                                : Colors.black,
                                        ),
                                      ),
                                      elevation: 1,
                                      backgroundColor: _notificationIndex != index
                                          ? neutral2
                                          : mainGold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
