import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playbucks/utils/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

// Bounce out. zoom scaling

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController mainController;
  late Animation<Offset> yAnimation;
  late Animation<double> zoomInAnimation;
  late Animation<double> loadAnimation;

  @override
  void initState() {
    super.initState();

    mainController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      reverseDuration: const Duration(seconds: 3),
    );

    zoomInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.5,
    ).animate(
      CurvedAnimation(
        parent: mainController,
        curve: const Interval(0.1, 0.6, curve: Curves.bounceOut),
      ),
    );

    loadAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: mainController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    yAnimation = Tween<Offset>(
      begin: const Offset(0, 12.0),
      end: const Offset(0, -1.0),
    ).animate(
      CurvedAnimation(
        parent: mainController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeIn),
      ),
    );

    Future.delayed(const Duration(milliseconds: 1500), () {
      mainController.forward();

      // Future.delayed(
      //   const Duration(seconds: 5),
      //   () => _controller.reverse().then(
      //         (_) => context.router.pushNamed(Pages.login),
      //       ),
      // );
    });
  }

  @override
  void dispose() {
    mainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 812.h,
          width: 375.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 120.h),
              SlideTransition(
                position: yAnimation,
                child: ScaleTransition(
                  scale: zoomInAnimation,
                  child: Image.asset("assets/Logo.png", width: 100.w, ),
                ),
              ),

              FadeTransition(
                opacity: loadAnimation,
                child: Column(
                  children: [
                    Text(
                      "Discover. Play. Earn.",
                      style: context.textTheme.headlineSmall,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Explore New Music, Earn Rewards, and Support Independent Artists.",
                      textAlign: TextAlign.center,
                      style:
                          context.textTheme.bodyLarge!.copyWith(color: theme60),
                    ),
                    SizedBox(height: 200.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainGold,
                        elevation: 1.0,
                        minimumSize: Size(320.w, 45.h),
                        maximumSize: Size(320.w, 45.h),
                      ),
                      onPressed: () => context.router.pushNamed(Pages.onboarding),
                      child: Text(
                        "Sign up for free",
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: primary,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: offWhite,
                        elevation: 1.0,
                        minimumSize: Size(320.w, 45.h),
                        maximumSize: Size(320.w, 45.h),
                      ),
                      onPressed: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset("assets/Apple svg.svg"),
                          Text(
                            "Continue with Apple",
                            style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: neutral2,
                        elevation: 1.0,
                        minimumSize: Size(320.w, 45.h),
                        maximumSize: Size(320.w, 45.h),
                      ),
                      onPressed: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset("assets/Google svg.svg"),
                          Text(
                            "Continue with Google",
                            style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: theme,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 26.h),
                    GestureDetector(
                      onTap: () => context.router.pushNamed(Pages.login),
                      child: Text(
                        "Log In",
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyLarge!
                            .copyWith(color: theme),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
