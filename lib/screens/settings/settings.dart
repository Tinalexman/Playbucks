import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/utils/constants.dart';

class _Setting {
  final String title;
  final String icon;
  final String link;

  const _Setting({
    this.title = "",
    this.icon = "",
    this.link = "",
  });
}

const List<_Setting> _settings = [
  _Setting(
    title: "Account Settings",
    link: Pages.accountSettings,
    icon: "assets/settings.svg",
  ),
  _Setting(
    title: "Notification Preference",
    link: Pages.notificationPreference,
    icon: "assets/bell.svg",
  ),
  _Setting(
    title: "Language and Region",
    link: Pages.languageAndRegion,
    icon: "assets/globe.svg",
  ),
  _Setting(
    title: "Connected Accounts",
    icon: "assets/server.svg",
    link: Pages.accounts,
  ),
  _Setting(
    title: "App Version and updates",
    icon: "assets/upload.svg",
    link: Pages.appUpdate,
  ),
  _Setting(
    title: "Help and Support",
    icon: "assets/help-circle.svg",
    link: Pages.help,
  ),
  _Setting(
    title: "About Playbucks",
    icon: "assets/archive.svg",
    link: Pages.about,
  ),
];

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 0.1,
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => context.router.pop(),
        ),
        centerTitle: true,
        title: Text(
          "Settings",
          style: context.textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (_, index) {
                    if (index == _settings.length) {
                      return Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.logout_rounded,
                              color: redError,
                              size: 26.r,
                            ),
                            title: Text(
                              "Sign out",
                              style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: redError,
                              ),
                            ),
                            onTap: () => showDialog(
                              context: context,
                              builder: (_) => const _SignOutContainer(),
                              barrierDismissible: true,
                            ),
                          ),
                          SizedBox(height: 48.h),
                        ],
                      );
                    }

                    return _SettingContainer(setting: _settings[index]);
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 24.h),
                  itemCount: _settings.length + 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SignOutContainer extends ConsumerWidget {
  const _SignOutContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 390.w,
        height: 200.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: neutral2,
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sign Out",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Boxicons.bx_x),
                  iconSize: 26.r,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              "You are about to sign out from your Playbucks account",
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium!.copyWith(color: theme60),
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Text(
                    "Cancel",
                    style: context.textTheme.bodyLarge!.copyWith(color: mainGold),
                  ),
                ),
                SizedBox(width: 20.w),
                ElevatedButton(
                  onPressed: () {
                    logout(ref);
                    context.router.goNamed(Pages.splash);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainGold,
                    minimumSize: Size(120.w, 50.h),
                    maximumSize: Size(120.w, 50.h),
                  ),
                  child: Text(
                    "Sign Out",
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w500, color: primary),
                  ),
                ),
                SizedBox(height: 10.h)
              ],
            )
          ],
        ),
      )



    );
  }
}

class _SettingContainer extends StatelessWidget {
  final _Setting setting;

  const _SettingContainer({
    super.key,
    required this.setting,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.pushNamed(setting.link),
      child: Container(
        width: 375.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: neutral2),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  setting.icon,
                ),
                SizedBox(width: 15.w),
                Text(setting.title,
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600))
              ],
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 26.r,
            ),
          ],
        ),
      ),
    );
  }
}
