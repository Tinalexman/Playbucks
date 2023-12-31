import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playbucks/managers/providers.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:playbucks/utils/functions.dart';
import 'package:playbucks/utils/widgets.dart';

class AccountSettingsPage extends ConsumerWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          "Account Settings",
          style: context.textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12.h,
              ),
              Text(
                "Manage your Playbucks account information.",
                style: context.textTheme.bodyMedium!.copyWith(color: theme60),
              ),
              SizedBox(height: 48.h),
              GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (_) => const _AccountSettingDialog()).then(
                  (value) {
                    if(value == null || !value) return;
                    context.router.pushNamed(Pages.changeEmail);
                  },
                ),
                child: SizedBox(
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Change email",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme60,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            ref.read(currentUserProvider).email,
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: theme40,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 26.r,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (_) => const _AccountSettingDialog()).then(
                      (value) {
                        if(value == null || !value) return;
                        context.router.pushNamed(Pages.changePassword);
                      },
                ),
                child: SizedBox(
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Change password",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme60,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 26.r,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              GestureDetector(
                onTap: () {
                  logout(ref);
                  context.router.goNamed(Pages.splash);
                },
                child: Text(
                  "Sign out",
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: redError,
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

class _AccountSettingDialog extends StatefulWidget {
  const _AccountSettingDialog({super.key});

  @override
  State<_AccountSettingDialog> createState() => _AccountSettingDialogState();
}

class _AccountSettingDialogState extends State<_AccountSettingDialog> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 390.w,
        height: 270.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: neutral2,
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Verify password",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  icon: const Icon(Boxicons.bx_x),
                  iconSize: 26.r,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              "Verify your password to proceed and change your information",
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium!.copyWith(color: theme60),
            ),
            SizedBox(height: 24.h),
            Text(
              "Enter password",
              style: context.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5.h),
            SpecialForm(
              controller: controller,
              width: 375.w,
              height: 40.h,
              hint: "Enter your password",
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Text(
                    "Cancel",
                    style: context.textTheme.bodyLarge!.copyWith(color: mainGold),
                  ),
                ),
                SizedBox(width: 20.w),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainGold,
                    minimumSize: Size(120.w, 50.h),
                    maximumSize: Size(120.w, 50.h),
                  ),
                  child: Text(
                    "Verify",
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w500, color: primary),
                  ),
                ),
                SizedBox(height: 10.h)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({Key? key}) : super(key: key);

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPage();
}

class _ChangeEmailPage extends State<ChangeEmailPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
          "Change email",
          style: context.textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12.h,
              ),
              Text(
                "Change your email.",
                style: context.textTheme.bodySmall!.copyWith(color: theme60),
              ),
              SizedBox(height: 24.h),
              Text(
                "New email",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5.h),
              SpecialForm(
                width: 390.w,
                height: 40.h,
                controller: controller,
                type: TextInputType.emailAddress,
                onValidate: (value) {
                  if (value!.trim().isEmpty || !value.contains("@")) {
                    showError(context, "Invalid Email Address");
                    return '';
                  }
                  return null;
                },
                hint: "e.g you@example.com",
              ),
              SizedBox(height: 250.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 1.0,
                  minimumSize: Size(320.w, 45.h),
                  maximumSize: Size(320.w, 45.h),
                  backgroundColor: mainGold,
                ),
                onPressed: () => context.router.pop(),
                child: Text(
                  "Save Changes",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w500, color: primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPage();
}

class _ChangePasswordPage extends State<ChangePasswordPage> {
  final TextEditingController current = TextEditingController();
  final TextEditingController updated = TextEditingController();

  bool showPassword = false;

  @override
  void dispose() {
    current.dispose();
    updated.dispose();
    super.dispose();
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
          "Change password",
          style: context.textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "Change your old password.",
                  style: context.textTheme.bodySmall!.copyWith(color: theme60),
                ),
                SizedBox(height: 24.h),
                Text(
                  "Enter current password",
                  style: context.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5.h),
                SpecialForm(
                  width: 390.w,
                  height: 40.h,
                  controller: current,
                  hint: "Your old password",
                ),
                SizedBox(height: 5.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => context.router.pushNamed(Pages.forgotPassword),
                    child: Text(
                      "Forgot password?",
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: mainGold,
                        decoration: TextDecoration.underline,
                        decorationColor: mainGold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                Text(
                  "Enter new password",
                  style: context.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5.h),
                SpecialForm(
                  width: 390.w,
                  height: 40.h,
                  controller: updated,
                  hint: "Create new password",
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
                ),
                SizedBox(height: 5.h),
                Text(
                  "Password requirements",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: theme60,
                  ),
                ),
                SizedBox(height: 250.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 1.0,
                    minimumSize: Size(320.w, 45.h),
                    maximumSize: Size(320.w, 45.h),
                    backgroundColor: mainGold,
                  ),
                  onPressed: () => context.router.pop(),
                  child: Text(
                    "Save Changes",
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
