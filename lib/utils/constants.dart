import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const Color theme = Color.fromARGB(255, 245, 245, 245);
const Color mainGold = Color.fromARGB(255, 234, 163, 45);
const Color niceBlue = Color.fromARGB(255, 73, 121, 209);
const Color possibleGreen = Color.fromARGB(255, 0, 158, 96);
const Color goodYellow = Color.fromARGB(255, 252, 163, 17);
const Color primary = Color(0xCC08062B);
const Color fadedPrimary = Color.fromARGB(25, 31, 31, 31);
const Color midPrimary = Color.fromARGB(255, 65, 65, 65);
const Color neutral = Color.fromARGB(180, 200, 200, 200);
const Color neutral2 = Color.fromARGB(35, 152, 152, 152);
const Color neutral3 = Color.fromARGB(255, 165, 165, 165);
const Color statusColor = Color.fromARGB(255, 229, 229, 229);
const Color offWhite = Color.fromRGBO(224, 224, 224, 1.0);

const Color playerDominant = Color(0xFF90A098);
const Color playerMutedDark = Color(0xFF685060);
const Color playerMutedLight = Color(0xFFA0C0B0);

const Color homeDominant = Color(0xFF252E33);
const Color homeMutedDark = Color(0xFF13151C);

extension PathExtension on String {
  String get path => "/$this";
}

extension ContextExtension on BuildContext {
  GoRouter get router => GoRouter.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);
}

class Pages {
  static const String splash = 'splash';
  static const String onboarding = 'onboarding';
  static const String login = 'login';
  static const String register = 'register';
  static const String artisteDashboard = 'dashboard-artiste';
  static const String listenerDashboard = 'dashboard-listener';
  static const String withdraw = 'withdraw';
  static const String deposit = 'deposit';
  static const String mediaPlayer = 'media-player';
  static const String home = 'home';
  static const String usertype = 'user-type';
  static const String registerListener = 'register-listener';
  static const String registerArtiste = 'register-artiste';
  static const String customArtistePage = 'custom-artiste';
  static const String editProfile = 'edit-profile';
  static const String playlist = 'playlist';
}

const String loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque feugiat at risus sit amet scelerisque. Curabitur sollicitudin tincidunt erat, sed vehicula ligula ullamcorper at. In in tortor ipsum. Nullam et malesuada libero. Curabitur ultricies erat dui, sit amet porttitor neque finibus sit amet. Integer id massa risus. Donec a justo libero. Ut et gravida massa. Sed vehicula, mauris at blandit accumsan, est odio condimentum urna, ut ornare ex elit non ante. Aenean pellentesque, dui ac ornare placerat, lectus elit volutpat urna, at convallis eros nisl vitae magna. Morbi massa odio, pellentesque a orci nec, dignissim lacinia ipsum."
    "\n\nNam dignissim dignissim quam nec bibendum. Nam congue iaculis nibh ac lobortis. Ut sodales ipsum ac nulla scelerisque finibus. Donec pretium sapien justo, ut pellentesque justo tristique nec. Nunc congue risus tellus, ac elementum ante gravida vitae. Cras bibendum suscipit sem id suscipit. Maecenas gravida libero at dui placerat, eget viverra ex maximus."
    "\n\nDonec convallis sem urna, a feugiat magna fermentum pharetra. Integer eu tellus consectetur, interdum arcu sit amet, rhoncus metus. Vivamus sodales, sem vel vulputate scelerisque, urna libero blandit nulla, in gravida justo mi eget est. Fusce luctus neque lobortis felis iaculis pharetra. Quisque orci magna, dignissim ac nibh at, egestas vehicula odio. Phasellus magna mi, varius a finibus a, hendrerit eu sapien. Cras ac auctor dolor, eget ornare diam. Sed non nibh ac neque pulvinar commodo quis id leo. Maecenas ultricies sapien at est venenatis placerat. Fusce consequat orci posuere, placerat lacus vitae, accumsan justo."
    "\n\nCurabitur mattis placerat fermentum. Nulla tristique interdum euismod. In tristique ex dui. Praesent condimentum fringilla nisi consequat iaculis. Sed in ex et metus viverra egestas sit amet vitae nisi. Praesent ultricies felis sit amet ligula rhoncus fermentum. Nam suscipit turpis eget turpis fringilla euismod. Duis id iaculis elit. Maecenas ac efficitur nunc, eget consequat quam. Nullam eget est eros. Integer et malesuada purus. Nam auctor ut urna at lobortis. Maecenas varius facilisis magna sit amet consequat."
    "\n\nNullam nec augue id sapien cursus egestas. Cras purus dolor, tempor a mollis at, sodales vel ex. Ut nec nisi sit amet nisl ornare accumsan a a justo. Sed ac vehicula purus. Donec et aliquet nibh, at pharetra nunc. Maecenas molestie hendrerit velit nec tristique. Aenean lobortis pellentesque sapien, vulputate scelerisque lorem rutrum sed. Maecenas eu nisl nec magna sagittis viverra nec eget elit. Nam diam nisi, ultricies id fringilla nec, aliquam at ipsum. In eget viverra leo. Pellentesque aliquet lorem turpis, nec sagittis nibh dignissim vitae. Etiam at magna sed urna sagittis accumsan non sed diam. Praesent non arcu quis nisi tempor tristique. Praesent non ex congue, ornare turpis et, condimentum ante. Aliquam dignissim, massa in egestas fermentum, odio odio posuere erat, eu posuere dolor leo finibus turpis.";


const Map<String, dynamic> userData = {
  "id" : "",
  "fullName" : "Asake",
  "username" : "asake",
  "cover" : "",
  "bio" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
      "Pellentesque feugiat at risus sit amet scelerisque. "
      "Curabitur sollicitudin tincidunt erat, sed vehicula ligula "
      "ullamcorper at. In in tortor ipsum. Nullam et malesuada libero. "
      "Curabitur ultricies erat dui, sit amet porttitor neque finibus sit amet. "
      "Integer id massa risus. Donec a justo libero. Ut et gravida massa. "
      "Sed vehicula, mauris at blandit accumsan, est odio condimentum urna, "
      "ut ornare ex elit non ante. Aenean pellentesque, dui ac ornare placerat, "
      "lectus elit volutpat urna, at convallis eros nisl vitae magna. "
      "Morbi massa odio, pellentesque a orci nec, dignissim lacinia ipsum.",
  "balance" : 0.0,
};