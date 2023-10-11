import 'package:flutter/material.dart';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:playbucks/utils/widgets.dart';
import 'package:playbucks/utils/functions.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginState();
}

class _LoginState extends ConsumerState<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _emailControl = TextEditingController();
  final Map<String, String> _authDetails = {"email": "", "password": ""};
  bool showPassword = false;

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
        title: Text(
          "Welcome Back to Playbucks!",
          style: context.textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "Log in to your Playbucks account to continue discovering, enjoying, and earning rewards with music.",
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
                        "Enter your Email or Username",
                        style: context.textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5.h),
                      SpecialForm(
                        width: 390.w,
                        height: 40.h,
                        controller: _emailControl,
                        type: TextInputType.emailAddress,
                        onValidate: (value) {
                          if (value!.trim().isEmpty || !value.contains("@")) {
                            showError(context, "Invalid Email Address");
                            return '';
                          }
                          return null;
                        },
                        onSave: (value) => _authDetails["email"] = value!,
                        hint: "your email or username",
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        "Password",
                        style: context.textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5.h),
                      SpecialForm(
                        width: 390.w,
                        height: 40.h,
                        obscure: !showPassword,
                        controller: _controller,
                        type: TextInputType.text,
                        suffix: GestureDetector(
                          onTap: () =>
                              setState(() => showPassword = !showPassword),
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
                      SizedBox(
                        height: 50.h,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 1.0,
                          minimumSize: Size(320.w, 45.h),
                          maximumSize: Size(320.w, 45.h),
                          backgroundColor: mainGold,
                        ),
                        onPressed: () =>
                            context.router.pushReplacementNamed(Pages.home),
                        child: Text(
                          "Log In",
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w500, color: primary),
                        ),
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () => context.router.pushNamed(Pages.login),
                          child: Text(
                            "Forgot password?",
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyLarge!
                                .copyWith(color: theme),
                          ),
                        )
                      ),
                    ],
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
