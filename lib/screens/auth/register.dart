import 'package:flutter/material.dart';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  DateTime? pickedDate;
  String? gender;

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
                      showError(context, "Please fill in your email.");
                      return '';
                    }
                    return null;
                  },
                  onSave: (value) => _authDetails["email"] = value!,
                  hint: "your email",
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
                      showError(context,
                          "Password is too short. Use at least 8 characters");
                      return '';
                    }
                    return null;
                  },
                  onSave: (value) => _authDetails["password"] = value!,
                  hint: "password",
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
                      showError(context,
                          "Password is too short. Use at least 8 characters");
                      return '';
                    }
                    return null;
                  },
                  onSave: (value) => _authDetails["password"] = value!,
                  hint: "password",
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
            hint: "Username",
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
              style: context.textTheme.bodyLarge!.copyWith(
                  color: Colors.black, fontWeight: FontWeight.w600),
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
                    lastDate: DateTime(2100));
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
                showError(context,
                    "Password is too short. Use at least 8 characters");
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
            buttonWidth: 200.w,
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
    } else if(pageIndex == 3) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Help us personalize your music experience. What genres do you enjoy the most?",
            style: context.textTheme.bodyLarge!.copyWith(color: theme60),
          ),
          SizedBox(height: 50.h),


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
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Link your favorite streaming services. We'll never post without your permission.",
            style: context.textTheme.bodyLarge!.copyWith(color: theme60),
          ),
          SizedBox(height: 50.h),

          SizedBox(
            height: 350.h,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: mainGold,
              elevation: 1.0,
              minimumSize: Size(390.w, 40.h),
            ),
            onPressed: () => context.router.pushReplacementNamed(Pages.home),
            child: Text(
              "Sign up",
              style: context.textTheme.bodyLarge!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
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
