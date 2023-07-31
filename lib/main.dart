import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:playbucks/managers/theme.dart';
import 'package:playbucks/screens/auth/login.dart';
import 'package:playbucks/screens/auth/register.dart';
import 'package:playbucks/screens/choose_music.dart';
import 'package:playbucks/screens/dashboard/artiste.dart';
import 'package:playbucks/screens/dashboard/listener.dart';
import 'package:playbucks/screens/intro/onboarding.dart';
import 'package:playbucks/screens/intro/splash.dart';
import 'package:playbucks/screens/payment/deposit.dart';
import 'package:playbucks/screens/payment/withdraw.dart';
import 'package:playbucks/screens/player/player.dart';
import 'package:playbucks/utils/constants.dart';

void main() {
  runApp(const ProviderScope(child: Playbucks()));
}

class Playbucks extends StatelessWidget {
  const Playbucks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, widget) =>
          MaterialApp.router(
            title: 'Playbucks',
            debugShowCheckedModeBanner: false,
            darkTheme: PlaybucksTheme.dark(),
            theme: PlaybucksTheme.light(),
            routerConfig: GoRouter(
              initialLocation: Pages.choose.path,
              routes: [
                GoRoute(
                  path: Pages.splash.path,
                  name: Pages.splash,
                  builder: (_, __) => const SplashPage(),
                ),
                GoRoute(
                  path: Pages.onboarding.path,
                  name: Pages.onboarding,
                  builder: (_, __) => const OnboardingScreen(),
                ),
                GoRoute(
                  path: Pages.login.path,
                  name: Pages.login,
                  builder: (_, __) => const LoginPage(),
                ),
                GoRoute(
                  path: Pages.register.path,
                  name: Pages.register,
                  builder: (_, __) => const RegisterPage(),
                ),
                GoRoute(
                  path: Pages.artisteDashboard.path,
                  name: Pages.artisteDashboard,
                  builder: (_, __) => const ArtisteDashboard(),
                ),
                GoRoute(
                  path: Pages.listenerDashboard.path,
                  name: Pages.listenerDashboard,
                  builder: (_, __) => const ListenerDashboard(),
                ),
                GoRoute(
                  path: Pages.deposit.path,
                  name: Pages.deposit,
                  builder: (_, __) => const DepositPage(),
                ),
                GoRoute(
                  path: Pages.withdraw.path,
                  name: Pages.withdraw,
                  builder: (_, __) => const WithdrawPage(),
                ),
                GoRoute(
                  path: Pages.mediaPlayer.path,
                  name: Pages.mediaPlayer,
                  builder: (_, state) {
                    String path = state.extra as String;
                    return MediaPlayerPage(path: path);
                  },
                ),
                GoRoute(
                  path: Pages.choose.path,
                  name: Pages.choose,
                  builder: (_, __) => const Chooser()
                )
              ],
            ),
          ),
      splitScreenMode: true,
      designSize: const Size(390, 844),
      minTextAdapt: true,
    );
  }
}
