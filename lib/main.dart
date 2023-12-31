import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:playbucks/components/user.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/screens/auth/forgot.dart';
import 'package:playbucks/screens/auth/login.dart';
import 'package:playbucks/screens/auth/register.dart';
import 'package:playbucks/screens/auth/registration.dart';
import 'package:playbucks/screens/home/home.dart';
import 'package:playbucks/screens/dashboard/artiste.dart';
import 'package:playbucks/screens/dashboard/listener.dart';
import 'package:playbucks/screens/intro/onboarding.dart';
import 'package:playbucks/screens/intro/splash.dart';
import 'package:playbucks/screens/payment/deposit.dart';
import 'package:playbucks/screens/payment/withdraw.dart';
import 'package:playbucks/screens/player/player.dart';
import 'package:playbucks/screens/player/album.dart';
import 'package:playbucks/screens/settings/about.dart';
import 'package:playbucks/screens/settings/account.dart';
import 'package:playbucks/screens/settings/accounts.dart';
import 'package:playbucks/screens/settings/help.dart';
import 'package:playbucks/screens/settings/language.dart';
import 'package:playbucks/screens/settings/settings.dart';
import 'package:playbucks/screens/settings/notification.dart';
import 'package:playbucks/screens/settings/update.dart';
import 'package:playbucks/utils/constants.dart';

void main() {
  runApp(const ProviderScope(child: Playbucks()));
}

class Playbucks extends StatefulWidget {
  const Playbucks({Key? key}) : super(key: key);

  @override
  State<Playbucks> createState() => _PlaybucksState();
}

class _PlaybucksState extends State<Playbucks> {
  late GoRouter router;

  @override
  void initState() {
    super.initState();
    router = GoRouter(
      initialLocation: Pages.splash.path,
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
          path: Pages.forgotPassword.path,
          name: Pages.forgotPassword,
          builder: (_, __) => const ForgotPasswordPage(),
        ),
        GoRoute(
          path: Pages.passwordReset.path,
          name: Pages.passwordReset,
          builder: (_, __) => const PasswordResetPage(),
        ),
        GoRoute(
          path: Pages.pushNotify.path,
          name: Pages.pushNotify,
          builder: (_, __) => const PushNotificationPage(),
        ),
        GoRoute(
          path: Pages.authInfo.path,
          name: Pages.authInfo,
          builder: (_, state) =>
              AuthInfoPage(infoState: state.extra as AuthInfoState),
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
          builder: (_, state) => MediaPlayerPage(path: state.extra as String),
        ),
        GoRoute(
          path: Pages.home.path,
          name: Pages.home,
          builder: (_, __) => const Home(),
        ),
        GoRoute(
          path: Pages.usertype.path,
          name: Pages.usertype,
          builder: (_, __) => const UserTypePage(),
        ),
        GoRoute(
          path: Pages.registerListener.path,
          name: Pages.registerListener,
          builder: (_, __) => const ListenerRegistration(),
        ),
        GoRoute(
          path: Pages.registerArtiste.path,
          name: Pages.registerArtiste,
          builder: (_, __) => const ArtisteRegistration(),
        ),
        GoRoute(
          path: Pages.editProfile.path,
          name: Pages.editProfile,
          builder: (_, __) => const EditProfile(),
        ),
        GoRoute(
          path: Pages.playlist.path,
          name: Pages.playlist,
          builder: (_, __) => const AlbumPage(),
        ),
        GoRoute(
          path: Pages.settings.path,
          name: Pages.settings,
          builder: (_, __) => const SettingsPage(),
        ),
        GoRoute(
          path: Pages.accountSettings.path,
          name: Pages.accountSettings,
          builder: (_, __) => const AccountSettingsPage(),
        ),
        GoRoute(
          path: Pages.changeEmail.path,
          name: Pages.changeEmail,
          builder: (_, __) => const ChangeEmailPage(),
        ),
        GoRoute(
          path: Pages.changePassword.path,
          name: Pages.changePassword,
          builder: (_, __) => const ChangePasswordPage(),
        ),
        GoRoute(
          path: Pages.notificationPreference.path,
          name: Pages.notificationPreference,
          builder: (_, __) => const NotificationPreferencePage(),
        ),
        GoRoute(
          path: Pages.notificationFrequency.path,
          name: Pages.notificationFrequency,
          builder: (_, state) =>
              NotificationFrequency(preference: state.extra as NotificationPreference),
        ),
        GoRoute(
          path: Pages.faq.path,
          name: Pages.faq,
          builder: (_, __) => const FAQPage(),
        ),
        GoRoute(
          path: Pages.languageAndRegion.path,
          name: Pages.languageAndRegion,
          builder: (_, __) => const LanguageRegionPage(),
        ),
        GoRoute(
          path: Pages.selectLanguage.path,
          name: Pages.selectLanguage,
          builder: (_, __) => const SelectLanguagePage(),
        ),
        GoRoute(
          path: Pages.selectRegion.path,
          name: Pages.selectRegion,
          builder: (_, __) => const SelectRegionPage(),
        ),
        GoRoute(
          path: Pages.appUpdate.path,
          name: Pages.appUpdate,
          builder: (_, __) => const AppUpdatePage(),
        ),
        GoRoute(
          path: Pages.accounts.path,
          name: Pages.accounts,
          builder: (_, __) => const AccountsPage(),
        ),
        GoRoute(
          path: Pages.about.path,
          name: Pages.about,
          builder: (_, __) => const AboutPage(),
        ),
        GoRoute(
          path: Pages.help.path,
          name: Pages.help,
          builder: (_, __) => const HelpPage(),
        ),
        GoRoute(
          path: Pages.customArtistePage.path,
          name: Pages.customArtistePage,
          builder: (_, state) =>
              CustomArtistePage(artiste: state.extra as User),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, widget) => MaterialApp.router(
        title: 'Playbucks',
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        darkTheme: FlexThemeData.dark(
          fontFamily: "Nunito",
          useMaterial3: true,
          scheme: FlexScheme.gold,
        ),
        theme: FlexThemeData.dark(
          fontFamily: "Nunito",
          useMaterial3: true,
          scheme: FlexScheme.gold,
        ),
        routerConfig: router,
      ),
      splitScreenMode: true,
      designSize: const Size(375, 812),
      minTextAdapt: true,
    );
  }
}
