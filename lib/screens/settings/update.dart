import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/utils/constants.dart';

class AppUpdatePage extends ConsumerStatefulWidget {
  const AppUpdatePage({super.key});

  @override
  ConsumerState createState() => _AppUpdatePageState();
}

class _AppUpdatePageState extends ConsumerState<AppUpdatePage> {
  @override
  Widget build(BuildContext context) {
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
          "App Version and Update",
          style: context.textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12.h,
              ),
              Text(
                "Keep your app up to date for the best experience",
                style: context.textTheme.bodyMedium!.copyWith(color: theme60),
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Automatic Updates",
                    style: context.textTheme.bodyLarge,
                  ),
                  Switch(
                    value: ref.watch(autoUpdatesProvider),
                    onChanged: (val) {
                      ref.watch(autoUpdatesProvider.notifier).state = val;
                      setState(() {});
                    },
                    activeColor: mainGold,
                  ),
                ],
              ),
              SizedBox(height: 400.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 1.0,
                  minimumSize: Size(320.w, 45.h),
                  maximumSize: Size(320.w, 45.h),
                  backgroundColor: mainGold,
                ),
                onPressed: () {},
                child: Text(
                  "Check for updates",
                  style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500, color: primary),
                ),
              ),
              SizedBox(
                height: 48.h,
              ),
              Center(
                  child: Text(
                    ref.watch(versionProvider),
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyLarge!
                        .copyWith(color: theme60),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
