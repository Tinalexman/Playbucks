import 'package:flutter/material.dart';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:playbucks/utils/functions.dart';
import 'package:playbucks/utils/widgets.dart';

class _Model {
  final String image;
  final String header;
  final String text;

  const _Model({required this.image, required this.header, required this.text});
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();
  late List<_Model> models;

  int index = 0;

  @override
  void initState() {
    super.initState();
    models = const [
      _Model(
        image: "assets/Onboard One.png",
        header: "Discover and Enjoy Independent Music",
        text:
            "Join a community of music enthusiasts and discover unique tracks from independent artists. Get reward for engaging with the music you love.",
      ),
      _Model(
        image: "assets/Onboard Two.png",
        header: "Your Music, Your way",
        text:
            "We curate music recommendations based on your listening preferences and habits.",
      ),
      _Model(
        image: "assets/Onboard Three.png",
        header: "Earn as you Listen.",
        text:
            "Engage with promoted songs and campaigns to earn rewards. Support independent artists while enjoying great music.",
      ),
    ];
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  3,
                  (index) => ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 60.w,
                      minHeight: 5.h,
                      maxWidth: 60.w,
                      maxHeight: 5.h,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.5.h),
                        color: index == index ? mainGold : midPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => pageController.animateToPage(
                    models.length - 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                  ),
                  child: Text(
                    index < models.length - 1 ? "Skip" : "",
                    style: context.textTheme.bodyMedium!.copyWith(
                        color: mainGold,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1.5.h),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: 428.w,
                height: 500.h,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: models.length,
                  controller: pageController,
                  onPageChanged: (val) => setState(() => index = val),
                  itemBuilder: (_, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        models[index].image,
                        fit: BoxFit.contain,
                        width: 330.r,
                        height: 330.r,
                      ),
                      SizedBox(height: 48.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            models[index].header,
                            style: context.textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            models[index].text,
                            style: context.textTheme.bodyMedium,
                          )
                        ],
                      ),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
              index == models.length - 1
                  ? GestureDetector(
                      onTap: () =>
                          context.router.pushReplacementNamed(Pages.register),
                      child: Container(
                        width: 400.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: mainGold,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Get Started",
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: primary,
                          ),
                        ),
                      ),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        2,
                        (i) => GestureDetector(
                          onTap: () {
                            if (index == 0 && i == 0) return;
                            if (index < models.length - 1) {
                              pageController.animateToPage(
                                index + (i == 0 ? -1 : 1),
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut,
                              );
                            }
                          },
                          child: Container(
                            width: 50.r,
                            height: 50.r,
                            decoration: BoxDecoration(
                              color: i == 0 && index == 0
                                  ? mainGold.withOpacity(0.4)
                                  : mainGold,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              i == 0
                                  ? Icons.chevron_left_rounded
                                  : Icons.chevron_right_rounded,
                              size: 26.r,
                              color: i == 0 && index == 0
                                  ? primary.withOpacity(0.4)
                                  : primary,
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}