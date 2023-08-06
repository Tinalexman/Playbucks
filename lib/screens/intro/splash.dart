import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:playbucks/utils/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

// Bounce out. zoom scaling

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _zoomInAnimation;
  late Animation<double> _loadAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      reverseDuration: const Duration(seconds: 3),
    );

    _zoomInAnimation = Tween<double>(begin: 0.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.6, curve: Curves.bounceOut),
      ),
    );

    _loadAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 1.0, curve: Curves.easeIn),
      ),
    );

    Future.delayed(const Duration(milliseconds: 2500), () {
      _controller.forward();
      _controller.addListener(refresh);

      Future.delayed(
        const Duration(seconds: 5),
            () => _controller.reverse().then(
              (_) => context.router.pushNamed(Pages.login),
        ),
      );

    });
  }

  void refresh() => setState(() {});

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ScaleTransition(
                scale: _zoomInAnimation,
                child: Text(
                  "Playbucks",
                  style: context.textTheme.headlineSmall!
                      .copyWith(color: mainGold),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            FadeTransition(
              opacity: _loadAnimation,
              child: SpinKitFadingFour(
                color: mainGold,
                size: 25.r,
              ),
            )
          ],
        ),
      ),
    );
  }
}
