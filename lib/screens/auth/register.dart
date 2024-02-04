import 'package:flutter/material.dart';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playbucks/api/user_service.dart';
import 'package:playbucks/components/user.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:playbucks/utils/functions.dart';
import 'package:playbucks/utils/widgets.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterPage> createState() => _SignupState();
}

class _SignupState extends ConsumerState<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController controller = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final TextEditingController firstController = TextEditingController();
  final TextEditingController lastController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final Map<String, String> _authDetails = {
    "email": "",
    "password": "",
    "fullName": "",
  };

  final Map<String, String> musicPreferences = {
    "Pop": "assets/pop.jpg",
    "Hip Hop": "assets/hip pop.jpg",
    "Afro": "assets/afro.jpg",
    "Rock": "assets/rock.jpg",
    "Jazz": "assets/jazz.jpg",
    "Rap": "assets/rap.jpg",
  };

  final Map<String, String> dspPreferences = {
    "Spotify": "assets/Spotify svg.svg",
    "Apple Music": "assets/Apple svg.svg",
  };

  DateTime? pickedDate;
  String? gender, dsp;

  String music = "";

  bool showPassword = false, showConfirm = false;
  bool termsRead = false;

  int pageIndex = 0;

  @override
  void dispose() {
    controller.dispose();
    confirmController.dispose();
    emailController.dispose();
    ageController.dispose();
    firstController.dispose();
    lastController.dispose();
    usernameController.dispose();

    super.dispose();
  }

  void navigate(User? user) {
    ref.watch(currentUserProvider.notifier).state = user!;
    context.router.pushNamed(Pages.home);
  }

  void register() {
    authenticate(_authDetails, login: false).then((resp) {
      if (!mounted) return;
      if (!resp.success) {
        showError(resp.message);
        return;
      } else {
        navigate(resp.value);
      }
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: loader,
      ),
    );
  }

  Widget get child {
    if (pageIndex == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Join our music community to discover, enjoy, and get rewarded for independent music.",
            style: context.textTheme.bodyLarge!.copyWith(color: theme60),
          ),
          SizedBox(height: 24.h),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What's your email?",
                  style: context.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5.h),
                SpecialForm(
                  width: 390.w,
                  height: 40.h,
                  controller: emailController,
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      showError("Please fill in your email.");
                      return '';
                    }
                    return null;
                  },
                  onSave: (value) => _authDetails["email"] = value!,
                  hint: "e.g you@example.com",
                ),
                SizedBox(height: 5.h),
                Text(
                  "You’ll be asked to confirm this later.",
                  style: context.textTheme.bodySmall!.copyWith(color: theme60),
                ),
                SizedBox(height: 24.h),
                Text(
                  "Set a password",
                  style: context.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5.h),
                SpecialForm(
                  width: 390.w,
                  height: 40.h,
                  obscure: !showPassword,
                  controller: controller,
                  type: TextInputType.text,
                  suffix: GestureDetector(
                    onTap: () => setState(() => showPassword = !showPassword),
                    child: AnimatedSwitcherTranslation.right(
                      duration: const Duration(milliseconds: 500),
                      child: Icon(
                        showPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        key: ValueKey<bool>(showPassword),
                        size: 18.r,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  onValidate: (value) {
                    if (value!.length < 8) {
                      showError("Password is too short. Use at least 8 characters");
                      return '';
                    }
                    return null;
                  },
                  onSave: (value) => _authDetails["password"] = value!,
                  hint: "e.g 12345678",
                ),
                SizedBox(height: 5.h),
                Text(
                  "Must be at least 8 characters.",
                  style: context.textTheme.bodySmall!.copyWith(color: theme60),
                ),
                SizedBox(height: 24.h),
                Text(
                  "Confirm password",
                  style: context.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5.h),
                SpecialForm(
                  width: 390.w,
                  height: 40.h,
                  obscure: !showConfirm,
                  controller: confirmController,
                  type: TextInputType.text,
                  suffix: GestureDetector(
                    onTap: () => setState(() => showConfirm = !showConfirm),
                    child: AnimatedSwitcherTranslation.right(
                      duration: const Duration(milliseconds: 500),
                      child: Icon(
                        showConfirm
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        key: ValueKey<bool>(showConfirm),
                        size: 18.r,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  onValidate: (value) {
                    if (value!.length < 8) {
                      showError("Password is too short. Use at least 8 characters");
                      return '';
                    }
                    return null;
                  },
                  onSave: (value) => _authDetails["password"] = value!,
                  hint: "e.g 12345678",
                ),
                SizedBox(height: 5.h),
                Text(
                  "Both passwords must match.",
                  style: context.textTheme.bodySmall!.copyWith(color: theme60),
                ),
                SizedBox(
                  height: 200.h,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainGold,
                    elevation: 1.0,
                    minimumSize: Size(390.w, 40.h),
                  ),
                  onPressed: () => setState(() => ++pageIndex),
                  child: Text(
                    "Next",
                    style: context.textTheme.bodyLarge!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (pageIndex == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Finish creating your account by setting up your profile.",
            style: context.textTheme.bodyLarge!.copyWith(color: theme60),
          ),
          SizedBox(height: 24.h),
          Text(
            "What's your name?",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SpecialForm(
                width: 150.w,
                height: 40.h,
                controller: firstController,
                type: TextInputType.text,
                hint: "First name",
              ),
              SpecialForm(
                width: 150.w,
                height: 40.h,
                controller: lastController,
                type: TextInputType.text,
                hint: "Last name",
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Text(
            "This appears on your profile.",
            style: context.textTheme.bodySmall!.copyWith(color: theme60),
          ),
          SizedBox(height: 24.h),
          Text(
            "Username",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5.h),
          SpecialForm(
            width: 370.w,
            height: 40.h,
            controller: usernameController,
            type: TextInputType.text,
            hint: "e.g JohnnyDoe",
            prefix: SizedBox(
              height: 40.h,
              width: 30.w,
              child: Center(
                child: Text(
                  "@",
                  style: context.textTheme.bodyLarge!.copyWith(color: theme),
                ),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            "Create a unique username.",
            style: context.textTheme.bodySmall!.copyWith(color: theme60),
          ),
          SizedBox(
            height: 300.h,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: mainGold,
              elevation: 1.0,
              minimumSize: Size(390.w, 40.h),
            ),
            onPressed: () => setState(() => ++pageIndex),
            child: Text(
              "Next",
              style: context.textTheme.bodyLarge!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      );
    } else if (pageIndex == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "We use these information to personalize your profile and will not be visible on your profile.",
            style: context.textTheme.bodyLarge!.copyWith(color: theme60),
          ),
          SizedBox(height: 24.h),
          Text(
            "What's your date of birth?",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5.h),
          SpecialForm(
            width: 390.w,
            height: 40.h,
            readOnly: true,
            controller: ageController,
            type: TextInputType.text,
            suffix: IconButton(
              splashRadius: 0.01,
              iconSize: 16.r,
              icon:
                  const Icon(Icons.calendar_month_rounded, color: Colors.grey),
              onPressed: () async {
                pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(
                    () => ageController.text = formatDateTime(pickedDate!,
                        shorten: false, fancy: true),
                  );
                }
              },
            ),
            onValidate: (value) {
              if (value!.length < 8) {
                showError("Password is too short. Use at least 8 characters");
                return '';
              }
              return null;
            },
            hint: "Day of Month, Year",
          ),
          SizedBox(height: 24.h),
          Text(
            "What's your gender?",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5.h),
          ComboBox(
            hint: "Select your gender",
            value: gender,
            buttonWidth: 370.w,
            dropdownItems: const ["Male", "Female", "Other"],
            onChanged: (item) => setState(() => gender = item),
          ),
          SizedBox(
            height: 350.h,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: mainGold,
              elevation: 1.0,
              minimumSize: Size(390.w, 40.h),
            ),
            onPressed: () => setState(() => ++pageIndex),
            child: Text(
              "Next",
              style: context.textTheme.bodyLarge!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      );
    } else if (pageIndex == 3) {
      List<String> musicKeys = musicPreferences.keys.toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Help us personalize your music experience. What genres do you enjoy the most?",
            style: context.textTheme.bodyLarge!.copyWith(color: theme60),
          ),
          SizedBox(height: 50.h),
          SizedBox(
            height: 450.h,
            width: 370.w,
            child: GridView.builder(
              itemCount: musicKeys.length,
              itemBuilder: (_, index) => Container(
                width: 160.w,
                height: 105.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  image: DecorationImage(
                    image: AssetImage(musicPreferences[musicKeys[index]]!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      width: 165.w,
                      height: 105.h,
                      child: const ColoredBox(
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(
                      width: 160.w,
                      height: 105.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            musicKeys[index],
                            style: context.textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 24.h)
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0.w,
                      child: Checkbox(
                        value: music == musicKeys[index],
                        onChanged: (val) =>
                            setState(() => music = musicKeys[index]),
                      ),
                    )
                  ],
                ),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 105.h,
                mainAxisSpacing: 10.r,
                crossAxisSpacing: 10.r,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: mainGold,
              elevation: 1.0,
              minimumSize: Size(390.w, 40.h),
            ),
            onPressed: () => setState(() => ++pageIndex),
            child: Text(
              "Next",
              style: context.textTheme.bodyLarge!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      );
    } else {
      List<String> dspKeys = dspPreferences.keys.toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Link your favorite streaming services. We'll never post without your permission.",
            style: context.textTheme.bodyLarge!.copyWith(color: theme60),
          ),
          SizedBox(height: 24.h),
          Text(
            "What streaming platform do you use?",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5.h),
          ComboBox(
            hint: "Select your platform",
            value: dsp,
            buttonWidth: 370.w,
            dropdownItems: const ["Spotify", "Apple Music"],
            onChanged: (item) => setState(() => dsp = item),
          ),
          if (dsp != null) SizedBox(height: 16.h),
          if (dsp != null)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 1.0,
                minimumSize: Size(320.w, 45.h),
                maximumSize: Size(320.w, 45.h),
              ),
              onPressed: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                      "assets/${dsp! == "Spotify" ? "Spotify" : "Apple"} svg.svg"),
                  Text(
                    "Connect to ${dsp! == "Spotify" ? "Spotify" : "Apple Music"}",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: primary,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 24.h),
          Text(
            "Disclaimers!",
            style: context.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 16.h),
          Text(
            "You can disconnect your streaming platforms or update your privacy preferences in the app's settings at any time.",
            style: context.textTheme.bodyMedium!.copyWith(color: theme60),
          ),
          Text(
            "By connecting your streaming platforms, you agree to allow Playbucks to access and analyze your music listening data to provide personalized recommendations and rewards.",
            style: context.textTheme.bodyMedium!.copyWith(color: theme60),
          ),
          Text(
            "Your data privacy is important to us. We will not share your streaming platform data with third parties without your consent.",
            style: context.textTheme.bodyMedium!.copyWith(color: theme60),
          ),
          SizedBox(
            height: 100.h,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: mainGold,
              elevation: 1.0,
              minimumSize: Size(390.w, 40.h),
            ),
            onPressed: () => context.router.pushNamed(Pages.pushNotify),
            child: Text(
              "Sign up",
              style: context.textTheme.bodyLarge!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 16.h),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "By signing up, you agree to our ",
                  style: context.textTheme.bodyMedium!.copyWith(color: theme60),
                ),
                TextSpan(
                  text: "Terms and Conditions ",
                  style: context.textTheme.bodyMedium!.copyWith(color: mainGold),
                ),
                TextSpan(
                  text: "and ",
                  style: context.textTheme.bodyMedium!.copyWith(color: theme60),
                ),
                TextSpan(
                  text: "Privacy Policies.",
                  style: context.textTheme.bodyMedium!.copyWith(color: mainGold),
                ),
              ]
            ),
          )
        ],
      );
    }
  }

  String get title {
    switch (pageIndex) {
      case 0:
        return "Create account";
      case 1:
        return "Setup profile";
      case 2:
        return "Demography";
      case 3:
        return "Music preference";
      case 4:
        return "Connect streaming preference";
      default:
        return "";
    }
  }

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
          title,
          style: context.textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        5,
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
                              color: pageIndex == index ? mainGold : midPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    child,
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


class PushNotificationPage extends StatelessWidget {

  const PushNotificationPage({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80.h,
                  width: 160.w,
                  child: const ColoredBox(
                    color: neutral2,
                  ),
                ),
                SizedBox(height: 40.h),
                Text("Turn on push notifications.",
                  style: context.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8.h),
                Text("Get updates about new music, special offers, new rewards and more.",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(color: theme60),
                ),
                SizedBox(height: 40.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 1.0,
                    minimumSize: Size(200.w, 45.h),
                    maximumSize: Size(200.w, 45.h),
                    backgroundColor: mainGold,
                  ),
                  onPressed: () => context.router.pushReplacementNamed(Pages.home),
                  child: Text(
                    "Turn on notifications",
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w500, color: primary),
                  ),
                ),
                SizedBox(height: 16.h),
                GestureDetector(
                  onTap: () => context.router.pushReplacementNamed(Pages.home),
                  child: Text("Not Now",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}