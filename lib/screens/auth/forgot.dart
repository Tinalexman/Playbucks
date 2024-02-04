import 'package:flutter/material.dart';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playbucks/api/user_service.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:playbucks/utils/widgets.dart';
import 'package:playbucks/utils/functions.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPasswordPage> {
  final TextEditingController _emailControl = TextEditingController();
  bool showPassword = false;

  @override
  void dispose() {
    _emailControl.dispose();
    super.dispose();
  }

  void navigate() {
    context.router
        .pushNamed(Pages.authInfo, extra: AuthInfoState.resetEmailSent);
  }

  void forgot() {
    passwordDetails({"email": _emailControl.text.trim()}, reset: false)
        .then((resp) {
      if (!mounted) return;
      if (!resp.success) {
        showError(resp.message);
        return;
      } else {
        navigate();
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
          "Forgot Your Password?",
          style: context.textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "No worries! Enter your email address, and we'll help you reset your password.",
                  style: context.textTheme.bodyLarge!.copyWith(color: theme60),
                ),
                SizedBox(height: 24.h),
                Text(
                  "Enter your Email",
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
                      showError("Invalid Email Address");
                      return '';
                    }
                    return null;
                  },
                  hint: "e.g you@example.com",
                ),
                SizedBox(
                  height: 150.h,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 1.0,
                    minimumSize: Size(320.w, 45.h),
                    maximumSize: Size(320.w, 45.h),
                    backgroundColor: mainGold,
                  ),
                  onPressed: forgot,
                  child: Text(
                    "Reset Password",
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w500, color: primary),
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

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController password = TextEditingController();
  final TextEditingController confirm = TextEditingController();

  bool showPassword = false, showConfirm = false;

  @override
  void dispose() {
    password.dispose();
    confirm.dispose();
    super.dispose();
  }

  void navigate() {
    context.router
        .pushNamed(Pages.authInfo, extra: AuthInfoState.resetEmailSent);
  }

  void reset() {
    passwordDetails({
      "email": password.text.trim(),
      "resetCode": confirm.text.trim(),
    }, reset: true)
        .then((resp) {
      if (!mounted) return;
      if (!resp.success) {
        showError(resp.message);
        return;
      } else {
        navigate();
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
          "Reset Your Password",
          style: context.textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "Log in to your Playbucks account to continue discovering, enjoying, and earning rewards with music.",
                  style: context.textTheme.bodyLarge!.copyWith(color: theme60),
                ),
                SizedBox(height: 24.h),
                Text(
                  "Enter your new password",
                  style: context.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5.h),
                SpecialForm(
                  width: 390.w,
                  height: 40.h,
                  obscure: !showPassword,
                  controller: password,
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
                      showError(
                          "Password is too short. Use at least 8 characters");
                      return '';
                    }
                    return null;
                  },
                  hint: "e.g 12345678",
                ),
                SizedBox(height: 24.h),
                Text(
                  "Confirm new password",
                  style: context.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5.h),
                SpecialForm(
                  width: 390.w,
                  height: 40.h,
                  obscure: !showConfirm,
                  controller: confirm,
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
                      showError(
                          "Password is too short. Use at least 8 characters");
                      return '';
                    }
                    return null;
                  },
                  hint: "e.g 12345678",
                ),
                SizedBox(
                  height: 150.h,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 1.0,
                    minimumSize: Size(320.w, 45.h),
                    maximumSize: Size(320.w, 45.h),
                    backgroundColor: mainGold,
                  ),
                  onPressed: () => context.router.pushReplacementNamed(
                      Pages.authInfo,
                      extra: AuthInfoState.resetPasswordSuccess),
                  child: Text(
                    "Reset Password",
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w500, color: primary),
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

class AuthInfoPage extends StatelessWidget {
  final AuthInfoState infoState;

  const AuthInfoPage({super.key, required this.infoState});

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
                Text(
                  infoState == AuthInfoState.resetEmailSent
                      ? "Password Reset Email Sent"
                      : "Password Reset Successful",
                  style: context.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8.h),
                Text(
                  infoState == AuthInfoState.resetEmailSent
                      ? "We've sent you an email with instructions on how to reset your password. Please check your inbox."
                      : "Your Playbucks password has been successfully updated. Log in with your new password to continue.",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(color: theme60),
                ),
                SizedBox(height: 40.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 1.0,
                    minimumSize: Size(180.w, 45.h),
                    maximumSize: Size(180.w, 45.h),
                    backgroundColor: mainGold,
                  ),
                  onPressed: () {
                    if (infoState == AuthInfoState.resetEmailSent) {
                      context.router.pushNamed(Pages.passwordReset);
                    } else {
                      context.router.goNamed(Pages.login);
                    }
                  },
                  child: Text(
                    "Return to log in",
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w500, color: primary),
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

enum AuthInfoState { resetEmailSent, resetPasswordSuccess }
