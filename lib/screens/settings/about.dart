import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/utils/constants.dart';

class AboutPage extends ConsumerStatefulWidget {
  const AboutPage({super.key});

  @override
  ConsumerState createState() => _AboutPageState();
}

class _AboutPageState extends ConsumerState<AboutPage> {
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
          "About Playbucks",
          style: context.textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 12.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Learn more about Playbucks and our mission",
                  style: context.textTheme.bodyMedium!.copyWith(color: theme60),
                ),
              ),
              SizedBox(height: 56.h),
              Image.asset("assets/Logo.png"),
              SizedBox(height: 24.h),
              Text(
                ref.watch(versionProvider),
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge!.copyWith(color: theme60),
              ),
              SizedBox(height: 56.h),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 414.w,
                  height: 50.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: theme)),
                  child: Text(
                    "Privacy Policy",
                    style: context.textTheme.bodyLarge,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 414.w,
                  height: 50.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: theme)),
                  child: Text(
                    "Terms of Service",
                    style: context.textTheme.bodyLarge,
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
